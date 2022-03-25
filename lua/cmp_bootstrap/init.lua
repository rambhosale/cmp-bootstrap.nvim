local source = {}

local cmp = require("cmp")
local items = require("cmp_bootstrap/bootstrap-v5")

source.new = function()
  return setmetatable({}, { __index = source })
end

source.get_trigger_characters = function()
  return { "^%l" }
end

source.get_keyword_pattern = function()
  return [[\([^"' ~\.\s]\)*]]
end

local compDoc = function(className)
    local out = ''

    local type = className:sub(1,1)
    if type == 'm' then
        out = out .. 'margin-'
    elseif type == 'p' then
        out = out .. 'padding-'
    end

    local sides = className:sub(2,2)
    if sides == 't' then
        out = out .. 'top\t'
    elseif  sides == 'b' then
        out = out .. 'bottom\t'
    end

    local screenPrefix = string.sub(className, 4,6)
    -- local isSmallDevice = false

    if screenPrefix == 'md-' then
        out = "// Medium devices (tablets, 768px and up) \n@media (min-width: 768px) {\n\t" .. out
    elseif screenPrefix == 'lg-' then
        out = "// Large devices (desktops, 992px and up) \n@media (min-width: 992px) { \n\t" .. out
    elseif screenPrefix == 'xl-' then
        out = "// X-Large devices (large desktops, 1200px and up) \n@media (min-width: 1200px) { \n\t" .. out
    elseif screenPrefix == 'xxl' then
        out = "// XX-Large devices (larger desktops, 1400px and up) \n@media (min-width: 1400px) { \n\t" .. out
    else
        out = "// Small devices (landscape phones, 576px and up) \n@media (min-width: 576px) { \n\t" .. out
        -- isSmallDevice = true
    end

    local size = className:match('%d$')

    if size == '0' then
        out = out .. ' : $spacer * 0'
    elseif size == '1' then
        out = out .. ' : $spacer * 0.25'
    elseif size == '2' then
        out = out .. ' : $spacer * 0.5'
    elseif size == '3' then
        out = out .. ' : $spacer (default)'
    elseif size == '4' then
        out = out .. ' : $spacer * 1.5'
    elseif size == '5' then
        out = out .. ' : $spacer * 3'
    end

    return out .. "\n}"
end


local generateDoc = function (className)
    -- type of class
    -- margin
    local prefix = string.sub(className, 1, 3)

    local prefixMatch = prefix:match('^[mp][setb][-]')
    if prefixMatch then
        return compDoc(className)
    end

    return nil
end

source.complete = function(self, request, callback)

  if not vim.regex(self.get_keyword_pattern() .. "$"):match_str(request.context.cursor_before_line) then
    return callback()
  end

  local generatedClasses = {}
  for _, class in pairs(items) do
    table.insert(generatedClasses, {
      word=class,
      label=class,
      insertText=class,
      filterText=class,
      kind = cmp.lsp.CompletionItemKind.Value,
      documentation = generateDoc(class),
    })
  end

  callback(generatedClasses)
end

return source
