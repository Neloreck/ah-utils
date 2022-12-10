local addonName, addon = ...
local log = addon.utils.Logger:new({ prefix = "AhUndercut" });

SLASH_AHUNDERCUT1 = addon.cmd.list.UNDERCUT.DEFAULT;
SLASH_AHUNDERCUT2 = addon.cmd.list.UNDERCUT.SHORT;

function SlashCmdList.AHUNDERCUT()
  if (not AuctionHouseFrame) then
    log:gray("No AH open detected");
    return;
  end

  local isPostButtonVisible = AuctionHouseFrame.CommoditiesSellFrame.PostButton:IsVisible();
  local isPostButtonEnabled = AuctionHouseFrame.CommoditiesSellFrame.PostButton:IsEnabled();
  local isCommoditySelected = AuctionHouseFrame.CommoditiesSellFrame.ItemDisplay.ItemButton.Icon:IsVisible();

  if (isCommoditySelected and isPostButtonVisible and isPostButtonEnabled) then
    log:green("Perform 1s item undercut");
    AuctionHouseFrame.CommoditiesSellFrame.QuantityInput.InputBox:SetText("1");
    AuctionHouseFrame.CommoditiesSellFrame.PriceInput.MoneyInputFrame.GoldBox:SetText("0");
    AuctionHouseFrame.CommoditiesSellFrame.PriceInput.MoneyInputFrame.SilverBox:SetText("1")
    AuctionHouseFrame.CommoditiesSellFrame.PostButton:Click();
  else
    log:gray("Cannot perform undercut, you should put commodity in the post slot");
  end
end