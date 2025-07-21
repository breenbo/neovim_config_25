; ~/.config/nvim/queries/rust/injections.scm

(
  (line_comment) @comment
  .
  (macro_invocation
    macro: (identifier) @_macro_name
    (token_tree
      [
        (string_literal)
        (raw_string_literal)
      ] @injection.content
    )
    (#eq? @_macro_name "format")
    (#match? @comment "typst")
  )
  (#set! injection.language "typst")
)
