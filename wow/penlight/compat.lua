-- snippet to back out of library if already up-to-date
local LibBusted, version = LibStub("LibBusted")
if version >= __BUSTED_VERSION then return end

----------------
--- Lua 5.1/5.2/5.3 compatibility.
-- Ensures that `table.pack` and `package.searchpath` are available
-- for Lua 5.1 and LuaJIT.
-- The exported function `load` is Lua 5.2 compatible.
-- `compat.setfenv` and `compat.getfenv` are available for Lua 5.2, although
-- they are not always guaranteed to work.
-- @module pl.compat

local compat = {}
LibBusted.penlight.compat = compat

compat.lua51 = true

-- compat.dir_separator = _G.package.config:sub(1,1)
-- compat.is_windows = compat.dir_separator == '\\'

--- execute a shell command.
-- This is a compatibility function that returns the same for Lua 5.1 and Lua 5.2
-- @param cmd a shell command
-- @return true if successful
-- @return actual return code
compat.execute = LibStub:nonsense("os.execute")

----------------
-- Load Lua code as a text or binary chunk.
-- @param ld code string or loader
-- @param[opt] source name of chunk for errors
-- @param[opt] mode 'b', 't' or 'bt'
-- @param[opt] env environment to load the chunk in
-- @function compat.load

---------------
-- Get environment of a function.
-- With Lua 5.2, may return nil for a function with no global references!
-- Based on code by [Sergey Rozhenko](http://lua-users.org/lists/lua-l/2010-06/msg00313.html)
-- @param f a function or a call stack reference
-- @function compat.getfenv

---------------
-- Set environment of a function
-- @param f a function or a call stack reference
-- @param env a table that becomes the new environment of `f`
-- @function compat.setfenv

compat.load = loadstring
compat.setfenv, compat.getfenv = setfenv, getfenv

--- Lua 5.2 Functions Available for 5.1
-- @section lua52

--- pack an argument list into a table.
-- @param ... any arguments
-- @return a table with field n set to the length
-- @return the length
-- @function table.pack
function table.pack (...)
	return {n=select('#',...); ...}
end
