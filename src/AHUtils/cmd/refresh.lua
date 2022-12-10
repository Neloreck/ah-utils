local addonName, addon = ...;
local cmdList = addon.cmd.list;
local Logger = addon.utils.logging.Logger;

local log = Logger:new({ prefix = "AhRefresh" });

function SlashCmdList.AH_REFRESH()
  if (not AuctionHouseFrame) then
    log:gray("No AH open detected");
    return;
  end

  if (AuctionHouseFrame.CommoditiesBuyFrame.ItemList.RefreshFrame:IsVisible()) then
    if AuctionHouseFrame.CommoditiesBuyFrame.ItemList.LoadingSpinner:IsVisible() then
      log:yellow("Waiting for commodities list update, skip ops");
      return;
    end

    if AuctionHouseFrame.BuyDialog.OkayButton:IsVisible() then
      log:green("Dismiss buy dialog modal");
      AuctionHouseFrame.BuyDialog.OkayButton:Click();
    end;

    log:green("Perform AH items list refresh");
    AuctionHouseFrame.CommoditiesBuyFrame.ItemList.RefreshFrame.RefreshButton:Click();
    return;
  end;

  if (AuctionHouseFrame.SearchBar.FavoritesSearchButton:IsVisible()) then
    if (AuctionHouseFrame.BrowseResultsFrame.ItemList.LoadingSpinner:IsVisible()) then
      log:yellow("Waiting for favorites list update, skip ops");
    else
      log:green("Perform AH favorites list refresh");
      AuctionHouseFrame.SearchBar.FavoritesSearchButton:Click();
    end

    return;
  end

  log:gray("No frames for refresh");
end
