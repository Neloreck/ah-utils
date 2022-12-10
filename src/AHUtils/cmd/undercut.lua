local addonName, addon = ...;
local cmdList = addon.cmd.list;
local patternMatchingUtils = addon.utils.pattern_matching;
local Logger = addon.utils.logging.Logger;

local log = Logger:new({ prefix = "AhUndercut" });

-- ---------------------------------------------------
-- Get parameters for price limiting value
-- ---------------------------------------------------
local function getPriceLimit(arguments)
  local pattern = patternMatchingUtils.escapeString(cmdList.UNDERCUT.ARGUMENTS.SET_PRICE) .. "=" .. ".*";
  local limitParam = string.match(arguments, pattern .. "%s") or string.match(arguments, pattern .. "$");

  if (limitParam) then
    local totalPrice = patternMatchingUtils.parsePriceFromArguments(limitParam);
    return totalPrice;
  else
    return 1;
  end
end

function SlashCmdList.AH_UNDERCUT(arguments)
  if (not AuctionHouseFrame) then
    log:gray("No AH open detected");
    return;
  end

  local isPostButtonVisible = AuctionHouseFrame.CommoditiesSellFrame.PostButton:IsVisible();
  local isPostButtonEnabled = AuctionHouseFrame.CommoditiesSellFrame.PostButton:IsEnabled();
  local isCommoditySelected = AuctionHouseFrame.CommoditiesSellFrame.ItemDisplay.ItemButton.Icon:IsVisible();

  if (isCommoditySelected and isPostButtonVisible and isPostButtonEnabled) then
    local commodityName = AuctionHouseFrame.CommoditiesSellFrame.ItemDisplay.Name:GetText() or "?";
    local priceLimit = getPriceLimit(arguments)
    local goldPrice = math.floor(priceLimit / 100);
    local silverPrice = priceLimit % 100;

    log:green("Perform item undercut, price: " .. goldPrice .. "g" .. silverPrice .. "s - " .. commodityName);

    AuctionHouseFrame.CommoditiesSellFrame.QuantityInput.InputBox:SetText("1");
    AuctionHouseFrame.CommoditiesSellFrame.PriceInput.MoneyInputFrame.GoldBox:SetText(goldPrice);
    AuctionHouseFrame.CommoditiesSellFrame.PriceInput.MoneyInputFrame.SilverBox:SetText(silverPrice)
    AuctionHouseFrame.CommoditiesSellFrame.PostButton:Click();
  else
    log:gray("Cannot perform undercut, you should put commodity in the post slot");
  end
end
