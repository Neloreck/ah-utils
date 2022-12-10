SLASH_AHCONFIRM1 = "/ahconfirm";
SLASH_AHCONFIRM2 = "/ahc";

function SlashCmdList.AHCONFIRM()
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

      print(WrapTextInColorCode("[AhConfirm] Perform buy click: " .. goldPrice .. "g " .. silverPrice .. "s", "FF67fa05"));
      AuctionHouseFrame.BuyDialog.BuyNowButton:Click();
    else
      print(WrapTextInColorCode("[AhConfirm] Preparing to confirm buy, waiting", "FFf5de0f"));
    end;
  -- ---------------------------------------------------
  -- Item is not up-to-date, confirm and start again
  -- ---------------------------------------------------
  elseif hasDialog and hasOkayButton then
    print(WrapTextInColorCode("[AhConfirm] Perform okay click, ops dismissed", "FFa38c92"));
    AuctionHouseFrame.BuyDialog.OkayButton:Click();
  -- ---------------------------------------------------
  -- Items selected, open connfirmation
  -- ---------------------------------------------------
  elseif hasCommodities and hasBuyCommodity and canBuyCommodity and not hasDialog then
    print(WrapTextInColorCode("[AhConfirm] Perform buy commodity click", "FF5ff578"));
    AuctionHouseFrame.CommoditiesBuyFrame.BuyDisplay.BuyButton:Click()
  -- ---------------------------------------------------
  -- No ops defined
  -- ---------------------------------------------------
  else 
    print(WrapTextInColorCode("[AhConfirm] No frames or enabled buttons, skip ops", "FFd4d2c5"));
  end;
end
