local M = {}

---@param patterns string[]
---@param lines string[]
M.grep_lines = function(patterns, lines)
	local results = {}
	for _, line in ipairs(lines) do
		local lower_line = string.lower(line)
		for _, pattern in ipairs(patterns) do
			local match = string.match(lower_line, pattern)

			if nil ~= match then
				table.insert(results, { text =  match })
			end
		end
	end
	return results
end

M.get_host_list = function()
	local host_file = "~/.ssh/config"
	local host_list = {}

	-- read the file
	local file = io.open(vim.fn.expand(host_file), "r")
	if file then
		local content = file:read("*a")
		file:close()
		local lines = vim.split(content, "\n")
		host_list = M.grep_lines({ "%f[%w]host%f[%W]%s*([^*]*)$" }, lines)
	end

	return host_list
end



---@param user string
---@param hostname string
---@param port string
---@return string
M.get_cmd = function(user, hostname, port)

	local url = ""
	if user ~= nil then
		url = user .. "@"
	end

	url = url .. hostname

	if port ~= nil then
		url = url .. ":" .. port
	end

return "oil-ssh://" .. url .. "/"


end

-- to execute the function
M.hosts_picker = function()
  local Snacks = require("snacks")
  local Oil = require("oil")
  local host_list = M.get_host_list()
  return Snacks.picker.pick(
    { 
      title = "SSH Hosts",
      items = host_list,
      format = "text",
      layout = {
        preset = "select",
      },
      confirm = function(picker, item)
        picker:close()
					local ssh_host_infos = vim.fn.systemlist("ssh -GT " .. item.text)

					if vim.v.shell_error ~= 0 then
						vim.notify("Error: " .. vim.inspect(ssh_host_infos), vim.log.levels.WARN)
					end

					local user = M.grep_lines(
						{ "^user%f[%W]%s*(.*)", "^hostname%f[%W]%s*(.*)", "^port%f[%W]%s*(.*)" },
						ssh_host_infos
					)
					if #user ~= 3 then
						vim.notify("Not enough data found for " .. item.text, vim.log.levels.WARN)
					end

					local cmd = M.get_cmd(user[1].text, user[2].text, user[3].text)
					-- vim.cmd(cmd)
          Oil.open_float(cmd, {preview = {}})
      end,
    }
  )
end

return M
