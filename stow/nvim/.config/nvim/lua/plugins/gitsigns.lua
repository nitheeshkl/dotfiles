return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local gitsigns = require("gitsigns")

    gitsigns.setup({
      on_attach = function(bufnr)
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- Hunk navigation (respects diff mode).
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end, "Next git hunk")
        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end, "Prev git hunk")

        -- Hunk actions.
        map("n", "<leader>hs", gitsigns.stage_hunk, "Stage hunk")
        map("n", "<leader>hr", gitsigns.reset_hunk, "Reset hunk")
        map("v", "<leader>hs", function()
          gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Stage selected hunk")
        map("v", "<leader>hr", function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Reset selected hunk")
        map("n", "<leader>hp", gitsigns.preview_hunk, "Preview hunk")
        map("n", "<leader>hb", function()
          gitsigns.blame_line({ full = true })
        end, "Blame line")

        -- Toggles.
        map("n", "<leader>tb", gitsigns.toggle_current_line_blame, "Toggle inline blame")
      end,
    })
  end,
}
