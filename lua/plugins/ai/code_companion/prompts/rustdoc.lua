return {
  strategy = "inline",
  description = "Create Rust doc for this function",
  opts = {
    placement = "before",
  },
  prompts = {
    {
      role = "system",
      content = [[You are a Rust documentation expert. Create comprehensive Rust documentation for functions.

REQUIREMENTS:
1. Generate complete Rust doc comments with proper /// syntax
2. Include a clear description of what the function does
3. Document all parameters in # Arguments section with types and descriptions
4. Document return value in # Returns section with type and description
5. Add # Errors section if the function can return Result/Option or panic
6. Add # Panics section if the function can panic
7. Include # Examples section with practical usage that compiles
8. Add # Safety section if function is unsafe
9. Use proper Rust documentation formatting
10. Infer parameter and return types from the function signature
11. Write clear, concise descriptions following Rust conventions
12. Don't include the function code in your response, only the documentation

Format:
/// Brief description of what the function does.
///
/// Longer description if needed, explaining the purpose and behavior.
///
/// # Arguments
///
/// * `param_name` - Description of the parameter
/// * `other_param` - Description of another parameter
///
/// # Returns
///
/// Description of what the function returns
///
/// # Errors
///
/// Description of error conditions (if applicable)
///
/// # Panics
///
/// Description of panic conditions (if applicable)
///
/// # Examples
///
/// ```rust
/// // Usage example that compiles
/// let result = function_name(param);
/// assert_eq!(result, expected);
/// ```

Be thorough but concise. Follow Rust documentation conventions and focus on clarity.]],
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

            -- Traverse up to find Rust function node
            while node do
              local node_type = node:type()
              if node_type == "function_item" or node_type == "impl_item" or node_type == "associated_function" then
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
          return "Please place cursor on a Rust function or select a function to document."
        end

        return "Create comprehensive Rust documentation for the following function:\n\n```rust\n" .. text .. "\n```"
      end,
    },
  },
}
