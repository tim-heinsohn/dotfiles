#!/usr/bin/env node

/**
 * Test script for Playwright MCP QA optimization
 * Demonstrates token usage reduction in real scenarios
 */

const { PlaywrightQAOptimizer } = require('./playwright-qa-optimizer');

// Mock Playwright page interface for testing
class MockPage {
  constructor(url = 'https://example.com', title = 'Test Page') {
    this._url = url;
    this._title = title;
  }
  
  url() {
    return this._url;
  }
  
  async title() {
    return this._title;
  }
  
  async evaluate(fn, ...args) {
    // Mock implementation - in real usage, this would run in browser context
    if (fn.name === 'extractCriticalElements') {
      return [
        {
          selector: '[data-testid="login-button"]',
          tagName: 'button',
          text: 'Sign In',
          value: '',
          attributes: { 'data-testid': 'login-button', type: 'submit' },
          visible: true,
          position: { x: 100, y: 200, width: 120, height: 40 }
        },
        {
          selector: '#username',
          tagName: 'input',
          text: '',
          value: 'test@example.com',
          attributes: { id: 'username', type: 'email', placeholder: 'Email' },
          visible: true,
          position: { x: 100, y: 120, width: 200, height: 35 }
        }
      ];
    }
    
    if (fn.name === 'extractFormStates') {
      return [{
        action: '/login',
        method: 'post',
        elements: [
          { type: 'email', name: 'username', value: 'test@example.com', required: true },
          { type: 'password', name: 'password', value: '', required: true }
        ]
      }];
    }
    
    if (fn.name === 'extractPerformance') {
      return {
        loadTime: 1200,
        domContentLoaded: 800,
        firstPaint: 300,
        firstContentfulPaint: 450,
        resourceCount: 15,
        errorCount: 0
      };
    }
    
    return [];
  }
}

// Test scenarios
async function runOptimizationTests() {
  console.log('🔍 Playwright MCP QA Optimization Tests\n');
  
  const optimizer = new PlaywrightQAOptimizer({ maxTokens: 2000 });
  const page = new MockPage();
  
  // Test 1: Full extraction
  console.log('Test 1: Full QA Data Extraction');
  const fullData = await optimizer.extractQAData(page, {
    include: ['criticalElements', 'formStates', 'performance']
  });
  console.log('Token usage:', fullData.tokenUsage);
  console.log('Data keys:', Object.keys(fullData));
  console.log('');
  
  // Test 2: Targeted extraction
  console.log('Test 2: Targeted Critical Elements Only');
  const targetedData = await optimizer.extractQAData(page, {
    include: ['criticalElements']
  });
  console.log('Token usage:', targetedData.tokenUsage);
  console.log('Critical elements:', targetedData.criticalElements?.length || 0);
  console.log('');
  
  // Test 3: Token budget management
  console.log('Test 3: Token Budget Management');
  const budgetOptimizer = new PlaywrightQAOptimizer({ maxTokens: 500 });
  const budgetData = await budgetOptimizer.extractQAData(page, {
    include: ['criticalElements', 'formStates', 'performance']
  });
  console.log('Max tokens:', 500);
  console.log('Actual usage:', budgetData.tokenUsage);
  console.log('Budget efficiency:', Math.round((budgetData.tokenUsage / 500) * 100) + '%');
  console.log('');
  
  // Test 4: Performance comparison
  console.log('Test 4: Real Browser Context Test (if Playwright MCP is available)');
  console.log('Run this with actual Playwright MCP to see real token usage');
  console.log('');
  
  // Usage examples for actual Playwright MCP
  console.log('📋 Implementation Examples:');
  console.log('');
  console.log('// Basic usage with Playwright MCP:');
  console.log('const optimizer = new PlaywrightQAOptimizer({ maxTokens: 2000 });');
  console.log('const qaData = await optimizer.extractQAData(page, {');
  console.log('  include: ["criticalElements", "errors", "performance"]');
  console.log('});');
  console.log('');
  console.log('// Test-specific configuration:');
  console.log('const loginTest = await optimizer.extractQAData(page, {');
  console.log('  include: ["criticalElements", "formStates"],');
  console.log('  maxElements: 10,');
  console.log('  maxTextLength: 100');
  console.log('});');
  console.log('');
  console.log('// Token monitoring:');
  console.log('const result = await optimizer.extractQAData(page);');
  console.log('console.log(`Token efficiency: ${(result.tokenUsage / 2000 * 100).toFixed(1)}%`);');
}

// CLI interface
if (require.main === module) {
  runOptimizationTests().catch(console.error);
}

module.exports = { runOptimizationTests };