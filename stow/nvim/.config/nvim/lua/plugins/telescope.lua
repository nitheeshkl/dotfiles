-- plugins/telescope.lua:
return {
  {
    'nvim-telescope/telescope.nvim',
    tag = 'v0.2.1',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local actions = require('telescope.actions')
      require('telescope').setup({
        defaults = {
          mappings = {
            i = {
              ["<C-Up>"] = actions.preview_scrolling_up,
              ["<C-Down>"] = actions.preview_scrolling_down,
              ["<C-Left>"] = actions.preview_scrolling_left,
              ["<C-Right>"] = actions.preview_scrolling_right,
              ["<C-S-t>"] = actions.select_tab,
            },
            n = {
              ["<C-Up>"] = actions.preview_scrolling_up,
              ["<C-Down>"] = actions.preview_scrolling_down,
              ["<C-Left>"] = actions.preview_scrolling_left,
              ["<C-Right>"] = actions.preview_scrolling_right,
              ["<C-S-t>"] = actions.select_tab,
            },
          },
        },
      })

      local builtin = require('telescope.builtin')
      local function get_current_dir()
        return vim.fn.expand("%:p:h")
      end
      vim.keymap.set('n', '<leader>f', function() builtin.find_files({ cwd = get_current_dir() }) end, {})
      vim.keymap.set('n', '<C-S-f>', function() builtin.live_grep({ cwd = get_current_dir() }) end, {})
      vim.keymap.set('n', '<leader>b', builtin.buffers, {})

    end
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      -- This is your opts table
      require("telescope").setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
              -- even more opts
            }

            -- pseudo code / specification for writing custom displays, like the one
            -- for "codeactions"
            -- specific_opts = {
            --   [kind] = {
            --     make_indexed = function(items) -> indexed_items, width,
            --     make_displayer = function(widths) -> displayer
            --     make_display = function(displayer) -> function(e)
            --     make_ordinal = function(e) -> string
            --   },
            --   -- for example to disable the custom builtin "codeactions" display
            --      do the following
            --   codeactions = false,
            -- }
          }
        }
      }
      -- To get ui-select loaded and working with telescope, you need to call
      -- load_extension, somewhere after setup function:
      require("telescope").load_extension("ui-select")
    end
  }
}
