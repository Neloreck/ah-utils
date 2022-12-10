local addonName, addon = ...

local Logger = { prefix = "LOG" };

function Logger:new (obj)
  obj = obj or {};
  setmetatable(obj, self);
  self.__index = self;
  return obj;
end

function printLoggerEntry(prefix, text, color)
  print(WrapTextInColorCode("[" .. prefix .. "] " .. text, color));
end

function Logger:darkGreen(text)
  return printLoggerEntry(self.prefix, text, addon.utils.EColor.DARKER_GREEN);
end

function Logger:green(text)
  return printLoggerEntry(self.prefix, text, addon.utils.EColor.GREEN);
end

function Logger:yellow(text)
  return printLoggerEntry(self.prefix, text, addon.utils.EColor.YELLOW);
end

function Logger:grayish(text)
  return printLoggerEntry(self.prefix, text, addon.utils.EColor.GRAYISH_PINK);
end

function Logger:gray(text)
  return printLoggerEntry(self.prefix, text, addon.utils.EColor.GRAY);
end

addon.utils.Logger = Logger;
