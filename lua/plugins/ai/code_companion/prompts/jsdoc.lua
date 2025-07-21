return {
  strategy = "inline",
  description = "Create JSDoc for the this function",
  opts = {
    placement = "before",
  },
  prompts = {
    {
      role = "system",
      content = [[You are a JavaScript documentation expert. Create comprehensive JSDoc comments for functions.

REQUIREMENTS:
1. Generate complete JSDoc block comments with proper /** */ syntax
2. Include @description for the function purpose
3. Document all @param with types and descriptions
4. Document @returns with type and description
5. Add @throws if the function can throw errors
6. Include @example with practical usage
7. Use proper JSDoc tags and formatting
8. Infer parameter types from the code context when possible
9. Write clear, concise descriptions
10. Don't write again the function in your response

Format:
/**
 * Brief description of what the function does
 * @param {type} paramName - Description of parameter
 * @returns {type} Description of return value
 * @throws {ErrorType} Description of when error is thrown
 * @example
 * // Usage example
 * functionName(param);
 */

Be thorough but concise. Focus on clarity and usefulness for other developers.]],
    },
    {
      role = "user",
      content = function(context)
        local helpers = require("codecompanion.helpers.actions")
        local text = helpers.get_code(context.start_line, context.end_line)

        -- If no selection or only single line, try to detect function with treesitter
        if text == "" or context.start_line == context.end_line then
          local ts_utils = require("nvim-treesitter.ts_utils")
          local parsers = require("nvim-treesitter.parsers")

          if parsers.has_parser() then
            local node = ts_utils.get_node_at_cursor()

            -- Traverse up to find function node
            while node do
              local node_type = node:type()
              if
                node_type == "function_declaration"
                or node_type == "arrow_function"
                or node_type == "function_expression"
                or node_type == "method_definition"
              then
                local start_row, start_col, end_row, end_col = node:range()
                text = helpers.get_code(start_row + 1, end_row + 1)

                -- Update context with proper positions for inline strategy
                context.start_line = start_row + 1
                context.end_line = end_row + 1
                context.start_col = 0 -- Start at beginning of line
                context.end_col = 0 -- End at beginning of line
                break
              end
              node = node:parent()
            end
          end
        end

        if text == "" then
          return "Please place cursor on a function or select a function to document."
        end

        return "Create comprehensive JSDoc documentation for the following function:\n\n```javascript\n"
          .. text
          .. "\n```"
      end,
    },
  },
}
