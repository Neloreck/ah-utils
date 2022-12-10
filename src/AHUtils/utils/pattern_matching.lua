local addonName, addon = ...;
local pattern_matching = {};

-- ---------------------------------------------------
-- Parse total value from '*g*s' pattern
-- ---------------------------------------------------
local function parsePriceFromArguments(arguments)
  local goldValue = string.match(arguments, "%d+g");
  local silverValue = string.match(arguments, "%d+s")

  goldValue = goldValue and goldValue:match("%d+");
  silverValue = silverValue and silverValue:match("%d+");

  return (goldValue and tonumber(goldValue) or 0) * 100 + (silverValue and tonumber(silverValue) or 0);
end

-- ---------------------------------------------------
-- Escaping provided string for correct pattern matching
-- ---------------------------------------------------
local function escapeString(text)
  return text:gsub("([^%w])", "%%%1")
end

addon.utils.pattern_matching = {};
addon.utils.pattern_matching.parsePriceFromArguments = parsePriceFromArguments;
addon.utils.pattern_matching.escapeString = escapeString;
