--[[
@project glzl
@file glzl.lua
@author GlazedHam
@date 2/22/2018
@revision 0.01

This module is a simple console logger.
--]]

local glzl = {};

--[[
GLZ_LOG_LEVEL_STRINGS

This is a table of strings that represent the different
logging states. Used to enforce string based naming.
--]]
GLZ_LOG_LEVEL_STRINGS = {
  "TRACE",
  "DEBUG",
  "INFO",
  "WARN",
  "ERROR",
  "ALWAYS"
}

--[[
GLZ_LOG_LEVELS

This is a table of the log levels and thier corresponding
numbers, used for determining if we are in a state where we
can or cannot write out the log.
--]]
GLZ_LOG_LEVELS = {};
for i = 1,#GLZ_LOG_LEVEL_STRINGS do
  GLZ_LOG_LEVELS[GLZ_LOG_LEVEL_STRINGS[i]] = i
end

--[[
GLZ_LOG_LEVEL

This is the current log level state.
--]]
GLZ_LOG_LEVEL = GLZ_LOG_LEVELS["INFO"]

--[[
getElapsedTime

This function return the number of seconds since the programs intial
execution. Only accurate enough to the nearest 100th of a second. If we
want higher resolution timers we need to get external modules or make
a C wrapper.
--]]
function getElapsedTime()
  return os.clock()
end

--[[
printConsoleMessage

This function is used by all printing functions to output the log
message with the appropriate format. Currently this is only for
console output but could be adapted to return a string for file
output as well.
--]]
function printConsoleMessage(message, logLevel)
  if logLevel >= GLZ_LOG_LEVEL then
    print("(" .. string.format("%0.3f", getElapsedTime()) .. ")[" .. GLZ_LOG_LEVEL_STRINGS[logLevel] .. "] " .. message)
  end
end

--[[
glzl.glzSetLogLevel

Publicly exposed function allowing the end user to set the modules log level.
--]]
function glzl.glzSetLogLevel(logLevel)
  GLZ_LOG_LEVEL = logLevel
  printConsoleMessage("Log level set to: " .. GLZ_LOG_LEVEL_STRINGS[GLZ_LOG_LEVEL], GLZ_LOG_LEVELS["ALWAYS"])
end

--[[
glzl.glzTrace

Publicly exposed function allowing the end user to output a trace message.
--]]
function glzl.glzTrace(msg)
  printConsoleMessage(msg, GLZ_LOG_LEVELS["TRACE"])
end

--[[
glzl.glzTrace

Publicly exposed function allowing the end user to output a trace message.
--]]
function glzl.glzDebug(msg)
  printConsoleMessage(msg, GLZ_LOG_LEVELS["DEBUG"])
end

--[[
glzl.glzInfo

Publicly exposed function allowing the end user to output an info message.
--]]
function glzl.glzInfo(msg)
  printConsoleMessage(msg, GLZ_LOG_LEVELS["INFO"])
end

--[[
glzl.glzWarn

Publicly exposed function allowing the end user to output a warning message.
--]]
function glzl.glzWarn(msg)
  printConsoleMessage(msg, GLZ_LOG_LEVELS["WARN"])
end

--[[
glzl.glzError

Publicly exposed function allowing the end user to output an error message.
--]]
function glzl.glzError(msg)
  printConsoleMessage(msg, GLZ_LOG_LEVELS["ERROR"])
end

--[[
glzl.GLZ_LOG_LEVELS

Publicly exposed variable to give the users more information on what
strings are acceptable for log levels.
--]]
glzl.GLZ_LOG_LEVELS = GLZ_LOG_LEVELS

--[[ Expose the logger "object". --]]
return glzl