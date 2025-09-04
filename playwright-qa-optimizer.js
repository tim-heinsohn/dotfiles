/**
 * Playwright MCP QA Context Optimizer
 * Reduces token usage while preserving essential QA data
 */

class PlaywrightQAOptimizer {
  constructor(options = {}) {
    this.maxTokens = options.maxTokens || 4000;
    this.currentTokens = 0;
    this.priorityOrder = options.priorityOrder || [
      'criticalElements',
      'testResults',
      'errors',
      'forms',
      'navigation',
      'performance'
    ];
  }

  /**
   * Main method to extract optimized QA data
   */
  async extractQAData(page, options = {}) {
    const {
      include = ['criticalElements', 'testResults', 'errors'],
      maxElements = 50,
      maxTextLength = 200
    } = options;

    const data = {};
    this.currentTokens = 0;

    for (const type of include) {
      if (this.currentTokens >= this.maxTokens) break;
      
      const extractor = this.getExtractor(type);
      const extracted = await extractor(page, { maxElements, maxTextLength });
      
      if (extracted) {
        const tokens = this.estimateTokens(extracted);
        if (this.currentTokens + tokens <= this.maxTokens) {
          data[type] = extracted;
          this.currentTokens += tokens;
        } else {
          const truncated = this.truncateForTokens(extracted, this.maxTokens - this.currentTokens);
          if (truncated) {
            data[type] = truncated;
            this.currentTokens += this.estimateTokens(truncated);
          }
          break;
        }
      }
    }

    return {
      ...data,
      url: page.url(),
      title: await page.title(),
      timestamp: Date.now(),
      tokenUsage: this.currentTokens
    };
  }

  /**
   * Extract critical test elements only
   */
  async extractCriticalElements(page, options = {}) {
    const { maxElements = 50, maxTextLength = 200 } = options;
    
    return await page.evaluate((maxElements, maxTextLength) => {
      const elements = [];
      const testSelectors = [
        '[data-testid]',
        '[data-qa]',
        '[data-test]',
        '[role="button"]',
        '[role="link"]',
        'input',
        'select',
        'textarea',
        'button',
        'a[href]'
      ];

      for (const selector of testSelectors) {
        const found = Array.from(document.querySelectorAll(selector));
        for (const el of found.slice(0, maxElements - elements.length)) {
          if (elements.length >= maxElements) break;
          
          const rect = el.getBoundingClientRect();
          const isVisible = rect.width > 0 && rect.height > 0 && 
                          rect.top < window.innerHeight && rect.bottom > 0;
          
          elements.push({
            selector: this.generateSelector(el),
            tagName: el.tagName.toLowerCase(),
            text: el.textContent?.substring(0, maxTextLength) || '',
            value: el.value?.substring(0, maxTextLength) || '',
            attributes: this.extractAttributes(el),
            visible: isVisible,
            position: {
              x: Math.round(rect.left),
              y: Math.round(rect.top),
              width: Math.round(rect.width),
              height: Math.round(rect.height)
            }
          });
        }
      }
      
      return elements;
    }, maxElements, maxTextLength);
  }

  /**
   * Extract form states efficiently
   */
  async extractFormStates(page, options = {}) {
    const { maxElements = 20 } = options;
    
    return await page.evaluate((maxElements) => {
      const forms = Array.from(document.querySelectorAll('form'))
        .slice(0, maxElements)
        .map(form => ({
          action: form.action,
          method: form.method,
          id: form.id,
          elements: Array.from(form.querySelectorAll('input, select, textarea'))
            .map(input => ({
              type: input.type,
              name: input.name,
              id: input.id,
              value: input.value?.substring(0, 100) || '',
              placeholder: input.placeholder,
              required: input.required,
              disabled: input.disabled,
              checked: input.checked,
              valid: input.validity?.valid || true,
              validationMessage: input.validationMessage
            }))
        }));
      
      return forms;
    }, maxElements);
  }

  /**
   * Extract navigation context
   */
  async extractNavigation(page, options = {}) {
    const { maxElements = 10, maxTextLength = 50 } = options;
    
    return await page.evaluate((maxElements, maxTextLength) => {
      const navigation = {
        currentUrl: window.location.href,
        title: document.title,
        breadcrumbs: [],
        navigationLinks: []
      };

      // Extract breadcrumbs
      const breadcrumbSelectors = [
        '[aria-label="breadcrumb"] a',
        '.breadcrumb a',
        '.breadcrumbs a',
        'nav a'
      ];

      for (const selector of breadcrumbSelectors) {
        const breadcrumbs = Array.from(document.querySelectorAll(selector));
        if (breadcrumbs.length > 0) {
          navigation.breadcrumbs = breadcrumbs
            .slice(0, maxElements)
            .map(link => ({
              text: link.textContent?.substring(0, maxTextLength) || '',
              href: link.href
            }));
          break;
        }
      }

      // Extract main navigation
      const navSelectors = [
        'nav a',
        '[role="navigation"] a',
        '.nav a',
        '.navigation a'
      ];

      for (const selector of navSelectors) {
        const links = Array.from(document.querySelectorAll(selector));
        if (links.length > 0) {
          navigation.navigationLinks = links
            .slice(0, maxElements)
            .map(link => ({
              text: link.textContent?.substring(0, maxTextLength) || '',
              href: link.href,
              active: link.classList.contains('active') || link.getAttribute('aria-current') === 'page'
            }));
          break;
        }
      }

      return navigation;
    }, maxElements, maxTextLength);
  }

  /**
   * Extract errors and validation messages
   */
  async extractErrors(page, options = {}) {
    const { maxElements = 20, maxTextLength = 200 } = options;
    
    return await page.evaluate((maxElements, maxTextLength) => {
      const errors = [];

      // Find error messages
      const errorSelectors = [
        '.error',
        '.error-message',
        '.validation-error',
        '[role="alert"]',
        '[aria-invalid="true"]',
        '.text-danger',
        '.alert-danger'
      ];

      errorSelectors.forEach(selector => {
        const elements = Array.from(document.querySelectorAll(selector));
        elements.forEach(el => {
          if (errors.length < maxElements) {
            errors.push({
              type: 'validation',
              selector: this.generateSelector(el),
              message: el.textContent?.substring(0, maxTextLength) || '',
              relatedInput: this.findRelatedInput(el)
            });
          }
        });
      });

      // Find console errors (if available)
      if (window.qaErrors) {
        errors.push(...window.qaErrors.slice(0, maxElements - errors.length));
      }

      return errors;
    }, maxElements, maxTextLength);
  }

  /**
   * Extract performance metrics
   */
  async extractPerformance(page, options = {}) {
    return await page.evaluate(() => {
      const navigation = performance.getEntriesByType('navigation')[0];
      const paint = performance.getEntriesByType('paint');
      
      return {
        loadTime: navigation?.loadEventEnd - navigation?.loadEventStart || 0,
        domContentLoaded: navigation?.domContentLoadedEventEnd - navigation?.domContentLoadedEventStart || 0,
        firstPaint: paint.find(p => p.name === 'first-paint')?.startTime || 0,
        firstContentfulPaint: paint.find(p => p.name === 'first-contentful-paint')?.startTime || 0,
        resourceCount: performance.getEntriesByType('resource').length,
        errorCount: window.qaErrors?.length || 0
      };
    });
  }

  /**
   * Utility methods
   */
  generateSelector(element) {
    if (element.dataset.testid) return `[data-testid="${element.dataset.testid}"]`;
    if (element.id) return `#${element.id}`;
    if (element.className) return `.${element.className.split(' ')[0]}`;
    return element.tagName.toLowerCase();
  }

  extractAttributes(element) {
    const allowed = ['data-testid', 'id', 'class', 'type', 'name', 'placeholder', 'required', 'disabled'];
    const attributes = {};
    
    Array.from(element.attributes).forEach(attr => {
      if (allowed.includes(attr.name)) {
        attributes[attr.name] = attr.value;
      }
    });
    
    return attributes;
  }

  findRelatedInput(errorElement) {
    const input = errorElement.closest('form')?.querySelector('[aria-invalid="true"]') ||
                 errorElement.previousElementSibling?.tagName === 'INPUT' ? errorElement.previousElementSibling : null;
    
    return input ? {
      selector: this.generateSelector(input),
      name: input.name,
      id: input.id
    } : null;
  }

  estimateTokens(data) {
    return JSON.stringify(data).length / 4; // Rough estimation
  }

  truncateForTokens(data, maxTokens) {
    const str = JSON.stringify(data);
    if (str.length / 4 <= maxTokens) return data;
    
    const truncated = str.substring(0, maxTokens * 4);
    try {
      return JSON.parse(truncated + '}}'); // Attempt to close object
    } catch {
      return { truncated: true, originalLength: str.length };
    }
  }

  getExtractor(type) {
    const extractors = {
      criticalElements: this.extractCriticalElements.bind(this),
      formStates: this.extractFormStates.bind(this),
      navigation: this.extractNavigation.bind(this),
      errors: this.extractErrors.bind(this),
      performance: this.extractPerformance.bind(this)
    };
    
    return extractors[type] || (() => null);
  }
}

// Usage examples
async function exampleUsage() {
  const optimizer = new PlaywrightQAOptimizer({ maxTokens: 2000 });
  
  // Basic usage
  const qaData = await optimizer.extractQAData(page, {
    include: ['criticalElements', 'errors', 'performance']
  });
  
  // Test-specific usage
  const formTest = await optimizer.extractQAData(page, {
    include: ['criticalElements', 'formStates', 'errors'],
    maxElements: 10
  });
  
  console.log('QA Data:', qaData);
  console.log('Token usage:', qaData.tokenUsage);
}

// Export for use
module.exports = { PlaywrightQAOptimizer };