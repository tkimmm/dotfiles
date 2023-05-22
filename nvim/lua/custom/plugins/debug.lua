-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  {
    -- NOTE: Yes, you can install new plugins here!
    'mfussenegger/nvim-dap',
    -- NOTE: And you can specify dependencies as well
    dependencies = {
      -- Creates a beautiful debugger UI
      'rcarriga/nvim-dap-ui',
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      require('mason').setup()

      require('mason-nvim-dap').setup({
        ensure_installed = {},
        -- automatic_setup = true,
        handlers = {

          -- function(config)
          --   require('mason-nvim-dap').default_setup(config)
          -- end,
          -- node2 = function(config)
          --   config.adapters = {
          --     {
          --       name = 'Node2: Launch',
          --       type = 'node2',
          --       request = 'launch',
          --       program = '${file}',
          --       cwd = vim.fn.getcwd(),
          --       sourceMaps = true,
          --       protocol = 'inspector',
          --       console = 'integratedTerminal',
          --     },
          --     {
          --       -- For this to work you need to make sure the node process is started with the `--inspect` flag.
          --       name = 'Node2: Attach to process',
          --       type = 'node2',
          --       request = 'attach',
          --       processId = require('dap.utils').pick_process,
          --     }
          --   }
          --   require('mason-nvim-dap').default_setup(config) -- don't forget this!
          -- end,

        },
      })

      -- Basic debugging keymaps, feel free to change to your liking!
      vim.keymap.set('n', '<leader>dd', dap.continue, { desc = 'Start [D]ebugging' })
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = 'Show [U]I' })
      vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Step [I]nto' })
      vim.keymap.set('n', '<leader>df', 'tabe %', { desc = '[F]ullscreen a tab' })
      vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Step [O]ver' })
      vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Step O[U]t' })
      vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Set a debug breakpoint' })
      vim.keymap.set('n', '<leader>B', function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end, { desc = "Set a conditional debug point" })

      -- Dap UI setup
      -- For more information, see |:help nvim-dap-ui|
      dapui.setup {
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        controls = {
          icons = {
            pause = '⏸',
            play = '▶',
            step_into = '⏎',
            step_over = '⏭',
            step_out = '⏮',
            step_back = 'b',
            run_last = '▶▶',
            terminate = '⏹',
            disconnect = "⏏",
          },
        },
      }
      -- toggle to see last session result. Without this ,you can't see session output in case of unhandled exception.
      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close
    end,
  },

  -- {
  --   "mxsdev/nvim-dap-vscode-js",
  --   dependencies = {
  --     "mfussenegger/nvim-dap"
  --   },
  --   config = function()
  --     require("dap-vscode-js").setup({
  --       node_path = os.getenv('HOME') .. '/.nvm/versions/node/v19.7.0/bin/node',
  --       debugger_path = os.getenv('HOME') .. '/Downloads/vscode-js-debug/',
  --       adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
  --     })
  --     local js_based_languages = { "typescript", "javascript", "typescriptreact" }
  --     for _, language in ipairs(js_based_languages) do
  --       require("dap").configurations[language] = {
  --         {
  --           type = "pwa-node",
  --           request = "launch",
  --           name = "Launch file",
  --           program = "${file}",
  --           cwd = "${workspaceFolder}",
  --         },
  --         {
  --           type = "pwa-node",
  --           request = "attach",
  --           name = "Attach",
  --           processId = require 'dap.utils'.pick_process,
  --           cwd = "${workspaceFolder}",
  --         },
  --         {
  --           type = "pwa-chrome",
  --           request = "launch",
  --           name = "Start Chrome with \"localhost\"",
  --           url = "http://localhost:3000",
  --           webRoot = "${workspaceFolder}",
  --           userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
  --         }
  --       }
  --     end
  --   end
  -- }

}
