# ah-utils

World of Warcraft auction house utilities addon

## About

Adds few slash commands for usage in custom macros. Enables keybinds-based control of auction house operations.

## Commands

 - "/ahbuy" or "/ahb" => automated buy of first (cheapest) row of proposed items, each call processes current step (select first row, click buy, confirm it or dismiss error, select first row...)
 - "/ahconfirm" or "/ahc" => command to by selected item, each call continues further with confirmations (click buy, confirm it or dismiss error, click buy...)
 - "/ahrefresh" or "/ahr" => command to refresh current commodities list
 - "/ahundercut" or "/ahu" => command sell one picked item in a very fast way with price of 1 silver, should be called when commodity is selected for selling (is in sell slot)

## What it allows

 - Key bindings for some AH operations
 - Automated confirmation of buying with key bindings
 - Fast automated process of buying undercut commodities / scalping
 - Fast automated process of undercutting for scalping
