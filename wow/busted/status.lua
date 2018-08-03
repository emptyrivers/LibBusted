-- snippet to back out of library if already up-to-date
local LibBusted, version = LibStub("LibBusted")
if version >= __BUSTED_VERSION then return end

local function get_status(status)
  local smap = {
    ['success'] = 'success',
    ['pending'] = 'pending',
    ['failure'] = 'failure',
    ['error'] = 'error',
    ['true'] = 'success',
    ['false'] = 'failure',
    ['nil'] = 'error',
  }
  return smap[tostring(status)] or 'error'
end

LibBusted.busted.status = function(inital_status)
  local objstat = get_status(inital_status)
  local obj = {
    success = function(self) return (objstat == 'success') end,
    pending = function(self) return (objstat == 'pending') end,
    failure = function(self) return (objstat == 'failure') end,
    error   = function(self) return (objstat == 'error') end,

    get = function(self)
      return objstat
    end,

    set = function(self, status)
      objstat = get_status(status)
    end,

    update = function(self, status)
      -- prefer current failure/error status over new status
      status = get_status(status)
      if objstat == 'success' or (objstat == 'pending' and status ~= 'success') then
        objstat = status
      end
    end
  }

  return setmetatable(obj, {
    __index = {},
    __tostring = function(self) return objstat end
  })
end
