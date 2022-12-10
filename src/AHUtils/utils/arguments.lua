local addonName, addon = ...;

-- ---------------------------------------------------
-- Check whether arguments collection includes specified argument
-- ---------------------------------------------------
local function hasArgument(arguments, argument)
  local index = string.find(arguments, argument, nil, true);

  if (index == nil) then
    return false;
  else
    return true;
  end
end

addon.utils.arguments = {};
addon.utils.arguments.hasArgument = hasArgument;
