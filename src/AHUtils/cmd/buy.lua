local addonName, addon = ...;
local argumentUtils = addon.utils.arguments;
local patternMatchingUtils = addon.utils.pattern_matching;
local cmdList = addon.cmd.list;
local Logger = addon.utils.logging.Logger;

local log = Logger:new({ prefix = "AhBuy" });

SLASH_AH_BUY1 = addon.cmd.list.BUY.DEFAULT;
SLASH_AH_BUY2 = addon.cmd.list.BUY.SHORT;

function SlashCmdList.AH_BUY(arguments)
  if (not AuctionHouseFrame) then
    log:gray("No AH open detected");
    return;
  end

  local hasCommodities = AuctionHouseFrame.CommoditiesBuyFrame:IsVisible();

  if (AuctionHouseFrame.BuyDialog:IsVisible()) then
    if (AuctionHouseFrame.BuyDialog.BuyNowButton:IsVisible()) then
      return confirmBuy()
    elseif (AuctionHouseFrame.BuyDialog.OkayButton:IsVisible()) then
      return confirmBuyDismissModal();
    end
  elseif (hasCommodities) then
    return selectCommoditiesRow(arguments);
  end

  log:gray("No frames or enabled buttons, skip ops");
end

-- ---------------------------------------------------
-- Try to buy the item from menu dialog
-- ---------------------------------------------------
function confirmBuy()
  if (AuctionHouseFrame.BuyDialog.BuyNowButton:IsEnabled()) then
    local hasGoldPrice = AuctionHouseFrame.BuyDialog.PriceFrame.GoldDisplay.Text:IsVisible();
    local goldPrice = hasGoldPrice and AuctionHouseFrame.BuyDialog.PriceFrame.GoldDisplay.Text:GetText() or "0";
    local silverPrice = AuctionHouseFrame.BuyDialog.PriceFrame.SilverDisplay.Text:GetText() or "0";

    log:green("Perform buy click: " .. goldPrice .. "g " .. silverPrice .. "s");
    AuctionHouseFrame.BuyDialog.BuyNowButton:Click();
  else
    log:yellow("Preparing to confirm buy, waiting for button readiness");
  end;
end

-- ---------------------------------------------------
-- Item is not up-to-date, confirm and start again
-- ---------------------------------------------------
function confirmBuyDismissModal()
  log:gray("Perform okay click, ops dismissed");
  AuctionHouseFrame.BuyDialog.OkayButton:Click();
end

-- ---------------------------------------------------
-- Select first row and confirm buy ops
-- ---------------------------------------------------
function selectCommoditiesRow(arguments)
  local isScalpEnabled = isScalp(arguments);
  local isConfirmOnlyEnabled = isConfirmOnly(arguments);
  local isPriceLimitEnabled = hasPriceLimit(arguments);
  local isReloadEnabled = isReload(arguments);
  local isListLoading = AuctionHouseFrame.CommoditiesBuyFrame.ItemList.LoadingSpinner:IsVisible();

  -- List is loading, skip OPs step
  if (isListLoading) then
    log:yellow("Waiting list load, cannot proceed with selection - it is not ready");
    return;
  end

  -- Select first row automatically if not disabled
  if (not isConfirmOnlyEnabled) then
    local kiddos = { AuctionHouseFrame.CommoditiesBuyFrame.ItemList.ScrollBox.ScrollTarget:GetChildren() };

    for _, child in ipairs(kiddos) do
      child:Click();
      break;
    end;
  end

  -- Commodity related frames / inputs
  local quantityInput = AuctionHouseFrame.CommoditiesBuyFrame.BuyDisplay.QuantityInput.InputBox;
  local nameInput = AuctionHouseFrame.CommoditiesBuyFrame.BuyDisplay.ItemDisplay.Name;
  local name = nameInput:GetText() or "unknown";
  local quantity = (quantityInput:GetText() and tonumber(quantityInput:GetText())) or 0;

  -- Pricing of elements
  local hasGoldPrice = AuctionHouseFrame.CommoditiesBuyFrame.BuyDisplay.UnitPrice.MoneyDisplayFrame.GoldDisplay.Text:IsVisible();
  local goldPrice = hasGoldPrice and AuctionHouseFrame.CommoditiesBuyFrame.BuyDisplay.UnitPrice.MoneyDisplayFrame.GoldDisplay.Text:GetText() or "0";
  local silverPrice = AuctionHouseFrame.CommoditiesBuyFrame.BuyDisplay.UnitPrice.MoneyDisplayFrame.SilverDisplay.Text:GetText() or "0";

  -- Ih have picked commodity and have limit, check it. If reload enabled, push it
  if (isPriceLimitEnabled) then
    local commodityPrice = tonumber(goldPrice) * 100 + tonumber(silverPrice);
    local maximalPrice = getPriceLimit(arguments);

    if (commodityPrice > maximalPrice) then
      log:yellow(
          "Commodity price is higher than expected limit: " .. goldPrice .. "g" .. silverPrice .. "s > " ..
          math.floor(maximalPrice / 100) .. "g" .. maximalPrice % 100 .. "s"
      );

      if (isReloadEnabled) then
        log:yellow("Perform AH items list refresh");
        refreshCommodityList();
      end

      return;
    end
  end

  -- If scalp option is pushed, then adjust quantity
  if isScalpEnabled then
    if (quantity > 1) then
      quantity = quantity - 1;

      log:green("Adjusting select commodity quantity to: " .. quantity .. "\\" .. quantity + 1);
      quantityInput:SetText(quantity);
    else
      log:yellow("Skip buy commodity operation, cannot leave less than 1 item")
      return;
    end
  end

  -- Click on buy commodity button
  if (AuctionHouseFrame.CommoditiesBuyFrame.BuyDisplay.BuyButton:IsVisible() and AuctionHouseFrame.CommoditiesBuyFrame.BuyDisplay.BuyButton:IsEnabled()) then
    log:green("Perform selected commodity buy: " .. quantity .. " " .. name);
    AuctionHouseFrame.CommoditiesBuyFrame.BuyDisplay.BuyButton:Click()
  else
    log:yellow("Cannot perform buy OP, it is not visible/enable");
  end
end

-- ---------------------------------------------------
-- Refresh commodities list
-- ---------------------------------------------------
function refreshCommodityList()
  if (AuctionHouseFrame.CommoditiesBuyFrame.ItemList.RefreshFrame:IsVisible()) then
    AuctionHouseFrame.CommoditiesBuyFrame.ItemList.RefreshFrame.RefreshButton:Click();
  end
end

-- ---------------------------------------------------
-- Get parameters for price limiting
-- ---------------------------------------------------
function hasPriceLimit(arguments)
  return argumentUtils.hasArgument(arguments, cmdList.BUY.ARGUMENTS.MAX_PRICE);
end

-- ---------------------------------------------------
-- Get parameters for price limiting value
-- ---------------------------------------------------
function getPriceLimit(arguments)
  local pattern = cmdList.BUY.ARGUMENTS.MAX_PRICE .. "=" .. ".*";
  local limitParam = string.match(arguments, pattern .. "%s") or string.match(arguments, pattern .. "$");

  if (limitParam) then
    local totalPrice = patternMatchingUtils.parse_price_from_arguments(limitParam);
    return totalPrice;
  else
    return 0;
  end
end

-- ---------------------------------------------------
-- Get parameters for scalp usage
-- ---------------------------------------------------
function isScalp(arguments)
  return argumentUtils.hasArgument(arguments, cmdList.BUY.ARGUMENTS.SCALP);
end

-- ---------------------------------------------------
-- Get parameters for reload usage
-- ---------------------------------------------------
function isReload(arguments)
  return argumentUtils.hasArgument(arguments, cmdList.BUY.ARGUMENTS.RELOAD);
end

-- ---------------------------------------------------
-- Get parameters for confirm only usage
-- ---------------------------------------------------
function isConfirmOnly(arguments)
  return argumentUtils.hasArgument(arguments, cmdList.BUY.ARGUMENTS.CONFIRM_ONLY);
end