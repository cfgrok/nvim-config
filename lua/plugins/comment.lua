return {
  {
    "numToStr/Comment.nvim",
    config = true,
    event = "VeryLazy",
    init = function()
      local ft = require("Comment.ft")
      local cfml_comment = "<!---%s--->"
      local cfscript_comment = { "//%s", "/*%s*/" }
      ft.set("cf", cfml_comment)

      -- CFML/CFScript toggle keymapping
      LazyVim.toggle.map("<leader>uz", {
        name = "CFScript Comments",
        get = function() return ft.get("cf", 1) == cfscript_comment[1] end,
        set = function(state)
          if state then
            ft.set("cf", cfscript_comment)
          else
            ft.set("cf", cfml_comment)
          end
        end,
      })
    end,
  },
}
