(local find (require :formedit.find))
(local ts (require :vim.treesitter))
(local ts_utils (require :nvim-treesitter.ts_utils))

(fn form []
  (let [form (find.form)
        parent (form:parent)
        text (ts.get_node_text form 0)
        parent_range (ts_utils.node_to_lsp_range parent)]
    (vim.lsp.util.apply_text_edits [{ "range" parent_range "newText" text } 0 "utf8"])
    (vim.api.nvim_win_set_cursor 0 [(+ parent_range.start.line 1) parent_range.start.character])))

(fn element []
  (let [element (find.element)
        parent (element:parent)
        text (ts.get_node_text element 0)
        [start-row start-col end-row end-col] [(parent:range)]]
    (vim.api.nvim_buf_set_text 0 start-row start-col end-row end-col [text])
    (vim.api.nvim_win_set_cursor 0 [(+ start-row 1) start-col])))

{: form : element}
