return {
  {
    "rgroli/other.nvim",
    main = "other-nvim",
    cmd = { "Other", "OtherTabNew", "OtherSplit", "OtherVSplit" },
    keys = {
      { "<leader>of", vim.cmd.Other, desc = "Toggle alternative file" },
    },
    opts = {
      mappings = {
        -- [Rails] Model to controller
        {
          pattern = "/app/models/(.*).rb",
          target = "/app/controllers/%1_controller.rb",
          context = "controller",
          transformer = "pluralize",
        },
        -- [Rails] Model to test
        {
          pattern = "/app/models/(.*).rb",
          target = "/test/models/%1_test.rb",
          context = "test",
        },
        -- [Rails] Model to spec
        {
          pattern = "/app/models/(.*).rb",
          target = "/spec/models/%1_spec.rb",
          context = "spec",
        },
      },
    },
  },
}
