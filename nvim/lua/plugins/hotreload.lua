return {
  -- Auto-reload files when changed externally (e.g., by Claude)
  {
    "diogo464/hotreload.nvim",
    event = "BufReadPre",
    opts = {},
  },
}
