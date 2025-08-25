-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Need to load the options before the plugins, in case anything set in the options file effects any plugins
require("config.options")

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
    {
      "neovim/nvim-lspconfig",
      config = function()
        require("lspconfig").elixirls.setup({
          cmd = { "/Users/thomasmclean/.config/nvim/ex/language_server.sh" },
          filetypes = { "elixir", "eelixir" },
          root_dir = require("lspconfig").util.root_pattern("mix.exs", ".git"),
        })

        require("lspconfig").solargraph.setup({
          cmd = { "solargraph", "stdio" },
          filetypes = { "ruby" },
          init_options = { formatting = false },
          settings = { solargraph = { diagnostics = true } },
        })
      end,
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.

  install = { colorscheme = { "tokyonight-storm" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

require("ibl").setup()

function open_float_term()
  local buf = vim.api.nvim_create_buf(false, true) -- Create a new scatrch buffer
  local width = 80 -- set desired width
  local height = 20 -- set desired height
  local opts = {
    relative = "editor",
    width = width,
    height = height,
    col = vim.o.columns - width,
    row = vim.o.lines - height,
    style = "minimal",
  }

  vim.api.nvim_open_win(buf, true, opts) --Open the float window

  vim.cmd("terminal") --Start the terminal in the new buffer
end

vim.api.nvim_create_user_command("FloatTerm", open_float_term, {})

require("config.keymaps")
require("config.treesitter-config")
