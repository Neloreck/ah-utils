local addonName, addon = ...
local log = addon.utils.Logger:new({ prefix = "AhRefresh" });

SLASH_AHREFRESH1 = addon.cmd.list.REFRESH.DEFAULT;
SLASH_AHREFRESH2 = addon.cmd.list.REFRESH.SHORT;

function SlashCmdList.AHREFRESH()
  if (not AuctionHouseFrame) then
    log:gray("No AH open detected");
    return;
  end

  if (AuctionHouseFrame.CommoditiesBuyFrame.ItemList.RefreshFrame:IsVisible()) then
    log:green("Perform AH items list refresh");

    if AuctionHouseFrame.BuyDialog.OkayButton:IsShown() then
      AuctionHouseFrame.BuyDialog.OkayButton:Click();
    end;

    AuctionHouseFrame.CommoditiesBuyFrame.ItemList.RefreshFrame.RefreshButton:Click();
  else
    log:gray("No frames for refresh");
  end;
end
