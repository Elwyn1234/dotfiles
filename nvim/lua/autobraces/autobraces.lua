autoBraces = {} -- A global object that we will use to hold all functions that this plugin will need to use.

--[[
  TODO: update this function to not check if we should_format because this is now done by the function held in the expression variable of the keymapping code.

  function description:
    if there is a brace to the left and right of the cursor, ignoring white space:
      trim inter-brace spaces
      move the second brace to the line below
      indent the second brace
]]
function autoBraces.formatFunctionBody()
  cursor = vim.api.nvim_win_get_cursor(0)
  line = vim.api.nvim_buf_get_lines(0, cursor[1] - 1, cursor[1], true)
  should_format = false
  open_brace_col = 0

-- cursor[2] points to the previous character, not the next character (we are in insert mode so the cursor is between two characters). We want to look at the next character, so we add one.
  for i = cursor[2] + 1, line[1]:len() do
    if line[1]:sub(i, i) == '}' then
      should_format = true
      break
    elseif line[1]:sub(i, i) ~= ' ' then
      break
    end
  end
  for i = cursor[2], 0, -1 do
    if line[1]:sub(i, i) == '{' then
      open_brace_col = i
      break
    elseif line[1]:sub(i, i) ~= ' ' then
      should_format = false
      break
    end
  end
  if not should_format then
    return
  end

  line1 = string.sub(line[1], 0, open_brace_col)
  vim.api.nvim_buf_set_lines(0, cursor[1] - 1, cursor[1], true, {line1})
  
  indentation = 0
  for i = 1, line[1]:len() do
    if line[1]:sub(i, i) ~= ' ' then
      indentation = i-1
      line2 = string.rep(" ", indentation) .. "}"
      vim.api.nvim_buf_set_lines(0, cursor[1], cursor[1], true, {line2})
      break
    end
  end
end

function autoBraces.formatFunctionBodyCondition()
  cursor = vim.api.nvim_win_get_cursor(0)
  line = vim.api.nvim_buf_get_lines(0, cursor[1] - 1, cursor[1], true)
  should_format = false
  if cursor[1] == nil or line[1] == nil then -- the function seems to get called when vim boots so this protects against that
    return false
  end

-- cursor[2] points to the previous character, not the next character (we are in insert mode so the cursor is between two characters). We want to look at the next character, so we add one.
  for i = cursor[2] + 1, line[1]:len() do
    if line[1]:sub(i, i) == '}' then
      should_format = true
      break
    elseif line[1]:sub(i, i) ~= ' ' then
      break
    end
  end
  for i = cursor[2], 0, -1 do
    if line[1]:sub(i, i) == '{' then
      break
    elseif line[1]:sub(i, i) ~= ' ' then
      should_format = false
      break
    end
  end

  print(should_format)
  return should_format
end

--[[reduntant functions:



function autoBraces.shiftCursorLeft()
  cursor = vim.api.nvim_win_get_cursor(0)
  cursor[2] = cursor[2] - 1
  vim.api.nvim_win_set_cursor(0, cursor)
end

function autoBraces.autoBraces()
  cursor = vim.api.nvim_win_get_cursor(0)
  line = vim.api.nvim_buf_get_lines(0, cursor[1] - 1, cursor[1], true)

  start_of_line = string.sub(line[1], 0, cursor[2])
  end_of_line = string.sub(line[1], cursor[2] + 1)
  new_line = start_of_line .. "{}" .. end_of_line
  cursor[2] = cursor[2] + 1

  vim.api.nvim_buf_set_lines(0, cursor[1] - 1, cursor[1], true, { new_line })
  vim.api.nvim_win_set_cursor(0, cursor)
end
]]

vim.api.nvim_set_keymap('i', '{', "{}<Esc>i", {noremap = true})
-- TODO: why does this still break Coc even after setting expr variable: is the wrong bool being returned?
--vim.api.nvim_set_keymap('i', '<CR>', "<cmd>lua autoBraces.formatFunctionBody()<CR><CR>", {noremap = true, expr = autoBraces.formatFunctionBodyCondition() })
