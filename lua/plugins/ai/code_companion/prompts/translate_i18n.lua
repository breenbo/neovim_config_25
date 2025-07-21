return {
  strategy = "chat",
  description = "Translate i18n JSON to multiple languages",
  prompts = {
    {
      role = "system",
      content = [[You are a professional translator specializing in web development i18n (internationalization).

Your task is to translate JSON objects used for i18n into French, German, Spanish, Italian, and Dutch.

CRITICAL RULES:
1. NEVER change JSON keys - only translate the string values
2. Maintain proper JSON syntax and formatting
3. Preserve special characters, HTML entities, and placeholders (like {{variable}}, %s, {0}, etc.)
4. Keep the same JSON structure and indentation
5. Translate only user-facing text content
6. For each language, provide the complete JSON object

Output format:
```json
// French (fr)
{translated JSON}

// German (de) 
{translated JSON}

// Spanish (es)
{translated JSON}

// Italian (it)
{translated JSON}

// Dutch (nl)
{translated JSON}
```

Context: This is for web application internationalization where keys are used programmatically and must remain unchanged.]],
    },
    {
      role = "user",
      content = function(context)
        local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
        if text == "" then
          return "Please select some i18n JSON text first, then run this action again."
        end
        return "Translate this i18n JSON object while keeping all keys unchanged:\n\n" .. text
      end,
    },
  },
}
