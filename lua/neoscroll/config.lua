local config = {}

config.default_options = {
  mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
  hide_cursor = true,
  stop_eof = true,
  respect_scrolloff = false,
  cursor_scrolls_alone = true,
  performance_mode = false,
  easing = "linear",
}

config.opts = vim.deepcopy(config.default_options)

function config.set_options(custom_opts)
  -- local options = vim.tbl_deep_extend("force", config.default_options, custom_opts or {})
  for key, value in pairs(custom_opts) do
    config.opts[key] = value
  end
end

-- Helper function for mapping keys
local function map_key(key, func, args)
  local args_str = table.concat(args, ", ")
  local prefix = [[lua require('neoscroll').]]
  local lua_cmd = prefix .. func .. "(" .. args_str .. ")"
  local cmd = "<cmd>" .. lua_cmd .. "<CR>"
  local opts = { silent = true, noremap = true }
  vim.api.nvim_set_keymap("n", key, cmd, opts)
  vim.api.nvim_set_keymap("x", key, cmd, opts)
end

-- Set mappings
function config.set_mappings(custom_mappings)
  for key, val in pairs(custom_mappings) do
    map_key(key, val[1], val[2])
  end
end

return config
