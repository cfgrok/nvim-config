return {
  -- Increase timeout on notifications
  {
    "nvim-notify",
    opts = {
      stages = "fade_in_slide_out",
      timeout = 5000,
    },
  },
}
