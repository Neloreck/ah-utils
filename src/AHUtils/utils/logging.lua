local addonName, addon = ...;
local EColor = addon.utils.color.EColor;

local Logger = { prefix = "LOG" };

local function printLoggerEntry(prefix, text, color)
  print(WrapTextInColorCode("[" .. prefix .. "] " .. text or "", color));
end

-- ---------------------------------------------------
-- Logger class to print prefixed messages
-- ---------------------------------------------------
function Logger:new(obj)
  obj = obj or {};
  setmetatable(obj, self);
  self.__index = self;
  return obj;
end

function Logger:darkGreen(text)
  return printLoggerEntry(self.prefix, text, EColor.DARKER_GREEN);
end

function Logger:green(text)
  return printLoggerEntry(self.prefix, text, EColor.GREEN);
end

function Logger:yellow(text)
  return printLoggerEntry(self.prefix, text, EColor.YELLOW);
end

function Logger:grayish(text)
  return printLoggerEntry(self.prefix, text, EColor.GRAYISH_PINK);
end

function Logger:gray(text)
  return printLoggerEntry(self.prefix, text, EColor.GRAY);
end

addon.utils.logging = {};
addon.utils.logging.Logger = Logger;
