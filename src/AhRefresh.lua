SLASH_AHREFRESH1 = "/ahrefresh";
SLASH_AHREFRESH2 = "/ahr";

function SlashCmdList.AHREFRESH()
  if AuctionHouseFrame.CommoditiesBuyFrame.ItemList.RefreshFrame:IsVisible() then
    print(WrapTextInColorCode("[AhRefresh] Perform AH items list refresh", "FFe1fc74"));

    if AuctionHouseFrame.BuyDialog.OkayButton:IsShown() then
      AuctionHouseFrame.BuyDialog.OkayButton:Click();
    end;

    AuctionHouseFrame.CommoditiesBuyFrame.ItemList.RefreshFrame.RefreshButton:Click();
  else
    print(WrapTextInColorCode("[AhRefresh] No frames for refresh", "FF949e6a"));
  end;
end
