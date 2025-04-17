local dap = require 'dap'
local json = require 'dkjson' -- You'll need the dkjson Lua module or any other JSON decoder

dap.adapters.coreclr = {
  type = 'executable',
  command = '/usr/local/bin/netcoredbg', -- Adjust path if needed
  args = { '--interpreter=vscode' },
}

-- Function to detect if it's a WebApp (Web API) or ConsoleApp
local function detect_project_type()
  -- Look for the .csproj file in the current directory
  local csproj_files = vim.fn.glob(vim.fn.getcwd() .. '/src/*/*.csproj', false, true)

  if #csproj_files == 0 then
    print '❌ No .csproj file found in the workspace!'
    return nil
  end

  -- Read the .csproj file content
  local csproj_file = csproj_files[1]
  local csproj_content = vim.fn.readfile(csproj_file)

  local is_web_app = false
  local is_console_app = false
  local app_type = 'unknown'

  -- Check for WebApp (look for AspNetCoreHostingModel or ASP.NET Core references)
  for _, line in ipairs(csproj_content) do
    if string.match(line, '<AspNetCoreHostingModel>') or string.match(line, '<FrameworkReference Include="Microsoft.AspNetCore.App" />') then
      is_web_app = true
      break
    end
  end

  -- Check for ConsoleApp (look for OutputType Exe)
  for _, line in ipairs(csproj_content) do
    if string.match(line, '<OutputType>Exe</OutputType>') then
      is_console_app = true
      break
    end
  end

  if is_web_app then
    -- Further distinguish between WebAPI or generic WebApp
    for _, line in ipairs(csproj_content) do
      if string.match(line, '<PackageReference Include="Microsoft.AspNetCore.Routing" />') then
        app_type = 'webapi'
        break
      end
    end

    if app_type == 'webapi' then
      return 'webapp-api'
    else
      return 'webapp'
    end
  elseif is_console_app then
    return 'consoleapp'
  else
    return 'unknown'
  end
end

-- Function to create a default debug_config.json based on the app type
local function create_default_debug_config()
  local project_type = detect_project_type()
  if not project_type then
    return nil
  end

  local config = {
    program = 'bin/Debug/net9.0/MyApp.dll', -- Default placeholder, will need to be replaced with the actual path
    args = {},
    env = {
      ASPNETCORE_ENVIRONMENT = 'Development',
    },
  }

  if project_type == 'webapp' or project_type == 'webapp-api' then
    -- Web App Configurations (WebAPI)
    config.env.ASPNETCORE_URLS = 'http://localhost:5000' -- Default port for web apps
  elseif project_type == 'consoleapp' then
    -- Console App Configurations
    config.args = { '--myArgument', 'value' } -- Default args for console apps
  end

  -- Write the config to a JSON file
  local json_config = json.encode(config, { indent = true })
  local config_file = vim.fn.getcwd() .. '/debug_config.json'
  vim.fn.writefile(vim.fn.split(json_config, '\n'), config_file)
  print('✅ Created debug_config.json at: ' .. config_file)

  return config
end

-- Function to load the debug configuration from the JSON file
local function load_debug_config()
  local config_file = vim.fn.getcwd() .. '/debug_config.json'
  local file_contents = vim.fn.readfile(config_file)

  if #file_contents == 0 then
    print('❌ No configuration file found at: ' .. config_file)
    return nil
  end

  local config_json = table.concat(file_contents, '\n')
  local config, pos, err = json.decode(config_json, 1, nil)

  if err then
    print('❌ Error parsing JSON configuration: ' .. err)
    return nil
  end

  return config
end

-- Get the C# DLL path dynamically
local function get_csharp_dll()
  local config = load_debug_config()
  if not config or not config.program then
    print '❌ No program path specified in the config.'
    return nil
  end
  return vim.fn.getcwd() .. '/' .. config.program
end

-- Use the loaded config for debugging
dap.configurations.cs = {
  {
    name = 'Launch Web App (WebAPI) or Console App',
    type = 'coreclr',
    request = 'launch',
    program = get_csharp_dll, -- Auto-detect program path from config
    args = function()
      local config = load_debug_config()
      return config and config.args or {} -- Use args from config file
    end,
    cwd = '${workspaceFolder}/src',
    stopAtEntry = false,
    env = function()
      local config = load_debug_config()
      return config and config.env or {}
    end,
  },
}
