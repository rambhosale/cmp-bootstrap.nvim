local source = {}

local items = require("cmp_bootstrap/bootstrap-v5")

source.new = function()
  return setmetatable({}, { __index = source })
end

source.get_trigger_characters = function()
  return { "^%l" }
end

source.get_keyword_pattern = function()
  return "[^[:blank:]]*"
end

source.complete = function(self, request, callback)

    print(vim.inspect(request))
  if not vim.regex(self.get_keyword_pattern() .. "$"):match_str(request.context.cursor_before_line) then
    return callback()
  end
  if not self.items then
    self.items = items
  end
  callback(self.items)
end

return source
