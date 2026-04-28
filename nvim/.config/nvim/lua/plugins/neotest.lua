return {
  { "nvim-neotest/neotest-plenary", "stevanmilic/neotest-scala" },
  {
    "nvim-neotest/neotest",
    opts = { adapters = { "neotest-plenary", "neotest-scala" } },
  },
}
