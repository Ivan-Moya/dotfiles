return {
  {
    "mfussenegger/nvim-jdtls",
    opts = function(_, opts)
      -- jdtls requires Java 21 or higher.
      -- If Java 21 is installed but not the default, we point to it here.
      local java_21 = "/usr/lib/jvm/java-21-amazon-corretto"
      if vim.fn.isdirectory(java_21) == 1 then
        vim.env.JAVA_HOME = java_21
      end

      -- You can also add other jdtls specific options here if needed
      -- opts.full_config_tree = true
    end,
  },
}
