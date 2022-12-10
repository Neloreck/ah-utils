# AHUtils

World of Warcraft auction house utilities addon. <br/>
Implements in-game slash commands for usage in macroses and key-bingings for auction house operation. <br/>
Minimalistic automation of some operations.

## What it allows

 - Key bindings for some AH operations
 - Automated confirmation of buying
 - Automated buying configuration with price / quantity limits
 - Fast process of buying undercut commodities / scalping
 - Fast process of undercutting to init scalping

## Commands

### AH_HELP
#### Cmd:
- "/ah_help" or "/ah_h"

#### Arguments:
- __

#### Description:
- show commands list, description and arguments <br/>
 
### AH_BUY

#### Cmd:
- "/ah_help" or "/ah_h"

#### Arguments: 
- -reload
- -max-price=*g*s
- -confirm-only
- -scalp

#### Description:
- automated commodities buying, allows scalping and price limiting with separate parameters. <br/>Each call proceeds further with steps <br/>

#### Examples: <br/>
```
# Buy only cheapes row if it is has unit price of 10 silver or less, buy all items and leave only one unit for scalping
/ah_buy -scalp -max-price=0g10s
```
```
# Buy selected row of commodities, no automated pickup of cheapest row, buy items with unit price less than 5 gold 10 silver
/ah_buy -max-price=5g10s -confirm-only
```
```
# Automatically buy cheapest row of items
/ah_buy -max-price=5g10s -confirm-only
```

### AH_REFRESH

#### Cmd:
- "/ah_refresh" or "/ah_r"

#### Arguments:
- __

#### Description:
- command to refresh list of commodities, refreshes favorites list in case of general AH frame, in case of commodities refreshes pricing list

### AH_UNDERCUT

#### Cmd:
- "/ah_undercut" or "/ah_u"

#### Arguments:
- -set-price=*g*s

#### Description:
- command to perform fast init for scalping, needs selected item and 1 unit will be placed with minimal price of 1s

#### Examples: <br/>
```
# Post 1 item with price of 10 silver
/ah_undercut -set-price=0g10s
```
```
# Post 1 item with price of 1 silver
/ah_undercut
```
