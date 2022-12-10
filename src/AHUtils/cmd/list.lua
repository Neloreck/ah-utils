local addonName, addon = ...;

addon.cmd.list = {
  BUY = {
    DEFAULT = "/ah_buy";
    SHORT = "/ah_b";
    ARGUMENTS = {
      SCALP = "-scalp";
      CONFIRM_ONLY = "-confirm-only";
      MAX_PRICE = "-max-price";
      RELOAD = "-reload";
    };
    DESCRIPTION = [[Automated buy process for automated buyout of first cheapest row of commodities.
(1) pick first row, (2) press buy, (3.1) confirm buy or (3.2) dismiss error modal, (4) back to 1.
Arguments:
[-scalp] - leave one item in cheapest row, buy (count-1) to prevent breaking of further scalp ops.
[-max_price] - do not use 'select commodity step', for manual selection of commodities, only proceed with buy/confirm clicks.
[-reload] - reload when commodities do not meet price requirements.
[-max_price] - supply maximal price to prevent buyout of expensive enties, example: -max_price=1g25s.]];
  };
  HELP = {
    DEFAULT = "/ah_help";
    SHORT = "/ah_h";
    DESCRIPTION = "Print commands list and descriptions for them.";
  };
  REFRESH = {
    DEFAULT = "/ah_refresh";
    SHORT = "/ah_r";
    DESCRIPTION = "Refresh AH commodities list.";
  };
  UNDERCUT = {
    DEFAULT = "/ah_undercut";
    SHORT = "/ah_u";
    ARGUMENTS = {
      SET_PRICE = "-set-price";
    };
    DESCRIPTION = "Post selected item with 1s value, fast init for commodities scalping.";
  };
};
