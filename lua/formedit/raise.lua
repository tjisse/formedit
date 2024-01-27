-- [nfnl] Compiled from fnl/formedit/raise.fnl by https://github.com/Olical/nfnl, do not edit.
local find = require("formedit.find")
local ts = require("vim.treesitter")
local ts_utils = require("nvim-treesitter.ts_utils")
local function form()
  local form0 = find.form()
  local parent = form0:parent()
  local text = ts.get_node_text(form0, 0)
  local parent_range = ts_utils.node_to_lsp_range(parent)
  vim.lsp.util.apply_text_edits({{range = parent_range, newText = text}}, 0, "utf8")
  return vim.api.nvim_win_set_cursor(0, {(parent_range.start.line + 1), parent_range.start.character})
end
local function element()
  local element0 = find.element()
  local parent = element0:parent()
  local text = ts.get_node_text(element0, 0)
  local _let_1_ = {parent:range()}
  local start_row = _let_1_[1]
  local start_col = _let_1_[2]
  local end_row = _let_1_[3]
  local end_col = _let_1_[4]
  vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, {text})
  return vim.api.nvim_win_set_cursor(0, {(start_row + 1), start_col})
end
return {form = form, element = element}
