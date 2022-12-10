SLASH_AHUNDERCUT1 = "/ahundercut";
SLASH_AHUNDERCUT2 = "/ahu";

function SlashCmdList.AHUNDERCUT()
  print(WrapTextInColorCode("[AhUndercut] Perform 1s item undercut", "FFff9f82"));

  AuctionHouseFrame.CommoditiesSellFrame.QuantityInput.InputBox:SetText("1");
  AuctionHouseFrame.CommoditiesSellFrame.PriceInput.MoneyInputFrame.GoldBox:SetText("0");
  AuctionHouseFrame.CommoditiesSellFrame.PriceInput.MoneyInputFrame.SilverBox:SetText("1")
  AuctionHouseFrame.CommoditiesSellFrame.PostButton:Click();
end
