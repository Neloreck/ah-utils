local addonName, addon = ...;

-- ---------------------------------------------------
-- Check whether arguments collection includes specified argument
-- ---------------------------------------------------
function hasArgument(arguments, argument)
  local index = string.find(arguments, argument);

  if (index == nil) then
    return false;
  else
    return true;
  end
end

addon.utils.arguments = {};
addon.utils.arguments.hasArgument = hasArgument;
