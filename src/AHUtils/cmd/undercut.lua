local addonName, addon = ...;
local cmdList = addon.cmd.list;
local Logger = addon.utils.logging.Logger;

local log = Logger:new({ prefix = "AhUndercut" });

SLASH_AH_UNDERCUT1 = cmdList.UNDERCUT.DEFAULT;
SLASH_AH_UNDERCUT2 = cmdList.UNDERCUT.SHORT;

function SlashCmdList.AH_UNDERCUT()
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