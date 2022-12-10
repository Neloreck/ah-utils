local addonName, addon = ...;

-- ---------------------------------------------------
-- Enum with app-level defined colors for logging
-- ---------------------------------------------------
local EColor = {
  GREEN = "FF67fa05";
  DARKER_GREEN = "FF337d02";
  YELLOW = "FFf5de0f";
  GRAYISH_PINK = "FFa38c92";
  GRAY = "FFd4d2c5";
};

addon.utils.color = {};
addon.utils.color.EColor = EColor;
