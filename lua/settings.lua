-- nvim-treesitter
-- require'nvim-treesitter.configs'.setup {
--   highlight = {
--     enable = true,
--     additional_vim_regex_highlighting = false,
--   },
--   indent = {
--     enable = true,
--     disable = { "c", "cpp" },
--   },
-- }
-- require("nvim-treesitter").install({
--     "c",
--     "cpp",
--     "python",
--     "yaml",
--   }, { summary = true, max_jobs = 10 })
--   :wait(1800000)

vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function() vim.treesitter.start() end,
})

-- telescope
require("telescope").setup {
  defaults = {
    layout_strategy = 'vertical'
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
    file_browser = {
      theme = "ivy",
      hijack_netrw = true,
      ["i"] = {
        -- your custom insert mode mappings
      },
      ["n"] = {
        -- your custom normal mode mappings
      },
    },
    aerial = {
      show_nesting = {
        ['_'] = false,
        json = true,
        yaml = true,
      },
    },
  },
  pickers = {
    buffers = {
      ignore_current_buffer = true,
      sort_mru = true,
    },
  },
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>lf', builtin.find_files, {})
-- vim.keymap.set('n', '<leader>l.', function() builtin.find_files({cwd = vim.fn.expand("%:p:h")}) end, {})
vim.keymap.set('n', '<leader>lk', ':Telescope find_files cwd=%:p:h<CR>', { noremap = true })
vim.keymap.set('n', '<leader>lg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>ll', builtin.buffers, {})
vim.keymap.set('n', '<leader>lm', builtin.marks, {})
vim.keymap.set('n', '<leader>le', ':Telescope file_browser<CR>', { noremap = true })
vim.keymap.set('n', '<leader>e.', ':Telescope file_browser path=%:p:h select_buffer=true<CR>', { noremap = true })

-- Enable telescope extensions
require("telescope").load_extension "file_browser"
require("telescope").load_extension "aerial"
require("telescope").load_extension "fzf"

-- marks
require('marks').setup {
  default_mappings = false,
  mappings = {
    set_next = "<leader>mm",
    delete_line = "<leader>md",
  },
}

-- aerial
require('aerial').setup({
  on_attach = function(bufnr)
    vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
    vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
  end
})
vim.keymap.set('n', '<leader>tt', '<cmd>AerialToggle! left<CR>')

-- vista
-- vim.keymap.set('n', '<leader>tt', ':vista nvim_lsp<CR>', { noremap = true })
-- vim.keymap.set('n', '<leader>tc', ':Vista!<CR>', { noremap = true })

-- bufexplore
-- vim.keymap.set('n', '<leader>wm', ':Vista nvim_lsp<CR>BufExplorerHorizontalSplit<CR>', { noremap = true })

-- harpoon
local harpoon = require('harpoon')
harpoon:setup({})
local conf = require('telescope.config').values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end
  require('telescope.pickers').new({}, {
    prompt_title = 'Harpoon',
    finder = require('telescope.finders').new_table({
      results = file_paths,
    }),
    previewer = conf.file_previewer({}),
    sorter = conf.generic_sorter({}),
  }):find()
end

vim.keymap.set("n", "<leader>hh", function() toggle_telescope(harpoon:list()) end, { desc = "open harpoon window" })
vim.keymap.set('n', '<leader>ha', function() harpoon:list():add() end, {})
vim.keymap.set("n", "<leader>hf", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {})
vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end, {})
vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end, {})
vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end, {})
vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end, {})
vim.keymap.set("n", "<leader>h5", function() harpoon:list():select(5) end, {})
vim.keymap.set("n", "<leader>h6", function() harpoon:list():select(6) end, {})
vim.keymap.set("n", "<leader>h7", function() harpoon:list():select(7) end, {})
vim.keymap.set("n", "<leader>h8", function() harpoon:list():select(8) end, {})
vim.keymap.set("n", "<leader>h9", function() harpoon:list():select(9) end, {})

-- nvim-tree
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
--  renderer = {
--    group_empty = true,
--    filters = {
--      dotfiles = true,
--    },
--  },
})

-- Code Companion
require("codecompanion").setup()
