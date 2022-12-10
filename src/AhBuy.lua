SLASH_AHBUY1 = "/ahbuy";
SLASH_AHBUY2 = "/ahb";

function SlashCmdList.AHBUY()
 local hasDialog = AuctionHouseFrame.BuyDialog:IsShown();
  local hasCommodities = AuctionHouseFrame.CommoditiesBuyFrame:IsShown();
	
  local hasBuy = AuctionHouseFrame.BuyDialog.BuyNowButton:IsShown();
  local hasOkayButton = AuctionHouseFrame.BuyDialog.OkayButton:IsShown();
  local hasBuyCommodity = AuctionHouseFrame.CommoditiesBuyFrame.BuyDisplay.BuyButton:IsShown();
  
  local canBuyCommodity = hasBuyCommodity and AuctionHouseFrame.CommoditiesBuyFrame.BuyDisplay.BuyButton:IsEnabled();
  local canBuyNow = hasBuy and AuctionHouseFrame.BuyDialog.BuyNowButton:IsEnabled();

  -- ---------------------------------------------------
  -- Try to buy the item from menu dialog
  -- ---------------------------------------------------
  if hasDialog and hasBuy then
    if canBuyNow then
      local hasGoldPrice = AuctionHouseFrame.BuyDialog.PriceFrame.GoldDisplay.Text:IsVisible();    
      local goldPrice = hasGoldPrice and AuctionHouseFrame.BuyDialog.PriceFrame.GoldDisplay.Text:GetText() or "0";
      local silverPrice = AuctionHouseFrame.BuyDialog.PriceFrame.SilverDisplay.Text:GetText();

      print(WrapTextInColorCode("[AhBuy] Perform buy click: " .. goldPrice .. "g " .. silverPrice .. "s", "FF67fa05"));
      AuctionHouseFrame.BuyDialog.BuyNowButton:Click();
    else
      print(WrapTextInColorCode("[AhBuy] Preparing to confirm buy, waiting", "FFf5de0f"));
    end;
  -- ---------------------------------------------------
  -- Item is not up-to-date, confirm and start again
  -- ---------------------------------------------------
  elseif hasDialog and hasOkayButton then
    print(WrapTextInColorCode("[AhBuy] Perform okay click, ops dismissed", "FFa38c92"));
    AuctionHouseFrame.BuyDialog.OkayButton:Click();
  -- ---------------------------------------------------
  -- Select first row and confirm buy ops
  -- ---------------------------------------------------
  elseif hasCommodities and hasBuyCommodity and canBuyCommodity and not hasDialog then
    print(WrapTextInColorCode("[AhBuy] Perform buy commodity click", "FF5ff578"));

    local kiddos = { AuctionHouseFrame.CommoditiesBuyFrame.ItemList.ScrollBox.ScrollTarget:GetChildren() };
    for _, child in ipairs(kiddos) do
      child:Click();
      break;
    end; 

    AuctionHouseFrame.CommoditiesBuyFrame.BuyDisplay.BuyButton:Click()
  -- ---------------------------------------------------
  -- No ops defined
  -- ---------------------------------------------------
  else 
    print(WrapTextInColorCode("[AhBuy] No frames or enabled buttons, skip ops", "FFd4d2c5"));
  end;
end
