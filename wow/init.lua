__BUSTED_VERSION = 1
local LibBusted = LibStub:NewLibrary("LibBusted", __BUSTED_VERSION)

-- some methods (in particular system calls) make no sense in the WoW environment
-- so this will highlight when that occurs
function LibBusted:nonsense(descriptor)
	local function nsns()
		error(descriptor.." makes no sense in the WoW environment.", 2)
	end
	return setmetatable({}, {
		__index = nsns,
		__newindex = nsns,
		__add = nsns,
		__sub = nsns,
		__mul = nsns,
		__div = nsns,
		__pow = nsns,
		__eq = nsns,
		__le = nsns,
		__lt = nsns,
		__call = nsns,
	})
end

LibBusted.busted = {}
LibBusted.luassert = {}
LibBusted.penlight = {}
