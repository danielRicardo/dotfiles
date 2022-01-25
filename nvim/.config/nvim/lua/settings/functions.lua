
local function toggle_nums()
  vim.wo.number = not vim.wo.number
end

local function toggle_conceal()
  local current = vim.wo.conceallevel
  if current == 2 then
    vim.wo.conceallevel = 0
  else
    vim.wo.conceallevel = 2
  end
end

return {
  toggle_nums = toggle_nums,
  toggle_conceal = toggle_conceal,
}
