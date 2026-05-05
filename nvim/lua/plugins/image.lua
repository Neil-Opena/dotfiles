-- Image viewer for Neovim using Kitty graphics protocol
return {
  "3rd/image.nvim",
  dependencies = {
    "leafo/magick",
  },
  config = function()
    -- Check if running in tmux
    local in_tmux = vim.env.TMUX ~= nil

    if in_tmux then
      -- Check if tmux has allow-passthrough enabled
      local handle = io.popen("tmux show -gv allow-passthrough 2>/dev/null")
      if handle then
        local result = handle:read("*a")
        handle:close()

        if not result:match("on") then
          vim.notify(
            "tmux 'allow-passthrough' is not enabled. Add 'set -g allow-passthrough on' to your tmux.conf",
            vim.log.levels.WARN
          )
          -- Disable image.nvim in tmux without passthrough
          return
        end
      end
    end

    -- Setup image.nvim with configuration
    require("image").setup({
      backend = "kitty",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "markdown", "vimwiki" },
        },
        neorg = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "norg" },
        },
      },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = nil,
      max_height_window_percentage = 50,
      window_overlap_clear_enabled = false,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      editor_only_render_when_focused = false,
      tmux_show_only_in_active_window = false,
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },
    })
  end,
}
