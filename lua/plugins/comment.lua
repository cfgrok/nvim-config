-- Set up manual commentstring support for CFML/CFScript
local function toggle_cf_commentstring()
  local ft = require("Comment.ft")
  local cf_comment = ft.get("cf", 1)
  local cfml_comment = "<!---%s--->"
  local cfscript_comment = { "//%s", "/*%s*/" }

  if cf_comment == cfscript_comment[1] then
    ft.set("cf", cfml_comment)
    LazyVim.info("CFML comments active", { title = "Comments" })
  else
    ft.set("cf", cfscript_comment)
    LazyVim.info("CFScript comments active", { title = "Comments" })
  end
end

return {
  {
    "numToStr/Comment.nvim",
    config = true,
    event = "VeryLazy",
    keys = { { "<leader>uz", toggle_cf_commentstring, desc = "Toggle CFML/CFScript Comments" } },
  },
}
