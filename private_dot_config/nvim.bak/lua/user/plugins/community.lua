return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- example of imporing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity
  { import = "astrocommunity.pack.rust" },
  -- { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.completion.copilot-lua" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.proto" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.utility.noice-nvim" },
  -- { import = "astrocommunity.bars-and-lines.lualine-nvim" },
  -- {import = "astrocommunity.pack.zig"},
  { -- further customize the options set by the community
    "copilot.lua",
    opts = {
      suggestion = {
        keymap = {
          accept = "<C-l>",
          accept_word = false,
          accept_line = false,
          next = "<C-.>",
          prev = "<C-,>",
          dismiss = "<C/>",
        },
      },
    },
  },
  {

    "simrat39/rust-tools.nvim",
    opts = {
      tools = {
        inlay_hints = {
          auto = false,
        },
      },
      server = {
        attach = function(_, bufnr)
          -- Hover actions
          local rt = require "rust-tools"
          vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
        end,
      },
    },
  },
}
