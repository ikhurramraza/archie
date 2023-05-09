require("packer").startup({
  function(use)
    use("tpope/vim-repeat")
    use("tpope/vim-fugitive")
    use("jesseleite/vim-noh")
    use("wbthomason/packer.nvim")
    use("stevearc/dressing.nvim")
    use("qpkorr/vim-renamer")
    use("famiu/bufdelete.nvim")
    use("metakirby5/codi.vim")
    use("ThePrimeagen/harpoon")
    use("github/copilot.vim")

    use({
      "mbbill/undotree",
      config = function()
        vim.g.undotree_WindowLayout = 3
        vim.g.undotree_DiffAutoOpen = 0
        vim.g.undotree_SetFocusWhenToggle = 1

        vim.keymap.set("n", "<leader>ou", "<CMD>UndotreeToggle<CR>")
      end,
    })

    use({
      "folke/which-key.nvim",
      config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        require("which-key").setup({})
      end,
    })

    -- Ruby language
    use("vim-ruby/vim-ruby")
    use("tpope/vim-endwise")

    -- Text objects
    use({ "tek/vim-textobj-ruby", requires = "kana/vim-textobj-user" })
    use({ "kana/vim-textobj-line", requires = "kana/vim-textobj-user" })
    use({ "kana/vim-textobj-indent", requires = "kana/vim-textobj-user" })
    use({ "rhysd/vim-textobj-anyblock", requires = "kana/vim-textobj-user" })
    use({ "sgur/vim-textobj-parameter", requires = "kana/vim-textobj-user" })
    use({ "EvanQuan/vim-textobj-delimiters", requires = "kana/vim-textobj-user" })

    -- Text manipulators
    use("AndrewRadev/splitjoin.vim")
    use("christoomey/vim-sort-motion")

    use({
      "AndrewRadev/sideways.vim",
      config = function()
        vim.keymap.set("n", "<C-H>", "<CMD>SidewaysLeft<CR>")
        vim.keymap.set("n", "<C-L>", "<CMD>SidewaysRight<CR>")
      end,
    })

    use({
      "junegunn/vim-easy-align",
      config = function()
        vim.keymap.set("n", "ga", "<Plug>(EasyAlign)")
        vim.keymap.set("x", "ga", "<Plug>(EasyAlign)")
      end,
    })

    use({
      "kylechui/nvim-surround",
      config = function()
        require("nvim-surround").setup()
      end,
    })

    -- Themes
    use({ "dracula/vim", as = "dracula" })
    use({ "catppuccin/nvim", as = "catppuccin" })

    -- LSP
    use("j-hui/fidget.nvim")
    use("neovim/nvim-lspconfig")
    use("jose-elias-alvarez/typescript.nvim")
    use("simrat39/rust-tools.nvim")
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("jose-elias-alvarez/null-ls.nvim")
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

    -- Completion
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/cmp-nvim-lsp")
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")

    -- Telescope
    use({ "nvim-telescope/telescope.nvim", requires = "nvim-lua/plenary.nvim" })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    use({ "debugloop/telescope-undo.nvim" })
    use({ "nvim-telescope/telescope-frecency.nvim", requires = "kkharji/sqlite.lua" })
    use({ "nvim-telescope/telescope-live-grep-args.nvim" })

    use({ "jdhao/better-escape.vim", event = "InsertEnter" })

    use({ "cuducos/yaml.nvim", requires = "nvim-telescope/telescope.nvim" })

    use({
      "907th/vim-auto-save",
      config = function()
        vim.g.auto_save = 0
        vim.g.auto_save_silent = 1
        vim.keymap.set("n", "<leader>os", "<cmd>AutoSaveToggle<CR>")
      end,
    })

    use({
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end,
    })

    use({
      "f-person/git-blame.nvim",
      config = function()
        vim.g.gitblame_enabled = 0
        vim.keymap.set("n", "<leader>ob", "<cmd>GitBlameToggle<CR>")
      end,
    })

    use({
      "lewis6991/gitsigns.nvim",
      config = function()
        require("gitsigns").setup({
          on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            vim.keymap.set("n", "[h", gs.prev_hunk, { buffer = bufnr })
            vim.keymap.set("n", "]h", gs.next_hunk, { buffer = bufnr })
            vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr })
            vim.keymap.set("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>", { buffer = bufnr })
            vim.keymap.set("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>", { buffer = bufnr })
            vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { buffer = bufnr })
            vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { buffer = bufnr })
          end,
        })
      end,
    })

    use({
      "takac/vim-hardtime",
      config = function()
        vim.g.hardtime_default_on = 1
        vim.g.list_of_normal_keys = { "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>", "+", "-" }
        vim.g.list_of_visual_keys = { "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>", "+", "-" }
        vim.g.list_of_insert_keys = { "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>" }
        vim.keymap.set("n", "<leader>oh", "<cmd>HardTimeToggle<CR>")
      end,
    })

    use({
      "nvim-lualine/lualine.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("lualine").setup({
          sections = {
            lualine_a = { "mode" },
            lualine_b = { { "branch", icon = "" }, "diff", "diagnostics" },
            lualine_c = { "filename" },
            lualine_x = {},
            lualine_y = { "progress" },
            lualine_z = { "location" },
          },
          extensions = {
            "quickfix",
          },
          options = {
            disabled_filetypes = { "undotree" },
          },
        })
      end,
    })

    use({
      "tyru/open-browser-github.vim",
      requires = "tyru/open-browser.vim",
      config = function()
        vim.keymap.set("n", "<leader>ghf", "<cmd>OpenGithubFile<CR>")
        vim.keymap.set("n", "<leader>ghp", "<cmd>OpenGithubPullReq<CR>")
      end,
    })

    use({
      "unblevable/quick-scope",
      config = function()
        vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
      end,
    })

    use({
      "vim-test/vim-test",
      config = function()
        vim.g["test#strategy"] = "basic"

        vim.keymap.set("n", "<leader>tn", "<cmd>TestNearest<CR>", { silent = true })
        vim.keymap.set("n", "<leader>tf", "<cmd>TestFile<CR>", { silent = true })
        vim.keymap.set("n", "<leader>ta", "<cmd>TestSuite<CR>", { silent = true })
        vim.keymap.set("n", "<leader>tl", "<cmd>TestLast<CR>", { silent = true })
        vim.keymap.set("n", "<leader>tv", "<cmd>TestVisit<CR>", { silent = true })

        vim.keymap.set("n", "<leader>tN", "<cmd>TestNearest -strategy=neovim<CR>", { silent = true })
        vim.keymap.set("n", "<leader>tF", "<cmd>TestFile    -strategy=neovim<CR>", { silent = true })
        vim.keymap.set("n", "<leader>tA", "<cmd>TestSuite   -strategy=neovim<CR>", { silent = true })
        vim.keymap.set("n", "<leader>tL", "<cmd>TestLast    -strategy=neovim<CR>", { silent = true })
        vim.keymap.set("n", "<leader>tV", "<cmd>TestVisit   -strategy=neovim<CR>", { silent = true })
      end,
    })
  end,
  config = {
    display = {
      open_fn = require("packer.util").float,
    },
    snapshot = "snapshot.json",
    snapshot_path = require("packer.util").join_paths(vim.fn.stdpath("config")),
  },
})
