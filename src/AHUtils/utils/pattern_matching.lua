local addonName, addon = ...
local pattern_matching = {};

-- ---------------------------------------------------
-- Parse total value from '*g*s' pattern
-- ---------------------------------------------------
pattern_matching.parse_price_from_arguments = function (arguments)
  local goldValue = string.match(arguments, "%dg");
  local silverValue = string.match(arguments, "%ds")

  goldValue = goldValue and goldValue:match("%d");
  silverValue = silverValue and silverValue:match("%d");

  return (goldValue and tonumber(goldValue) or 0) * 100 + (silverValue and tonumber(silverValue) or 0);
end

addon.utils.pattern_matching = pattern_matching;