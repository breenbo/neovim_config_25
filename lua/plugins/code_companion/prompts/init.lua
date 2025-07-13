-- Load all prompt files and return them as a table
return {
  translate_i18n = require("plugins.code_companion.prompts.translate_i18n"),
  js_doc = require("plugins.code_companion.prompts.jsdoc"),
  rust_doc = require("plugins.code_companion.prompts.rustdoc"),
}
