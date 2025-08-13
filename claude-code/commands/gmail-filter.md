# gmail-filter

Creates a Gmail filter and applies it to existing matching emails.

## Usage

```
/gmail-filter "<search_query>" "<label_name>"
```

## Arguments

- `search_query`: Gmail search expression or organization name (e.g., "from:example.com", "subject:report", "John Doe Consulting")
- `label_name`: Target label name (will be created if it doesn't exist)

## Examples

```
/gmail-filter "from:notifications@example.com" "Development/GitHub"
/gmail-filter "subject:invoice" "Finance/Invoices"  
/gmail-filter "John Doe Consulting" "Clients/JohnDoe"
```

## Implementation

This command:
1. Creates or gets the specified label
2. If search_query is a plain text person or organization name:
   - Searches existing emails for matches containing that text
   - Analyzes From, To, and X-Original-Sender headers to extract domain names
   - Creates a comprehensive filter covering all discovered email patterns
3. If search_query is already a Gmail search expression, uses it directly
4. Creates a Gmail filter to automatically label future emails and remove from inbox
5. Applies the label to all existing matching emails and removes them from inbox

## Notes

- Labels support hierarchical structure with "/" separator
- Filters automatically remove emails from inbox in addition to applying the label
- For organization names, the command intelligently maps to relevant email domains and headers
- Handles X-Original-Sender header to catch emails forwarded through mailing lists/groups
- Existing matching emails are processed in batches for efficiency
