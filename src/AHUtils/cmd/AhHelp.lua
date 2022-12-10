local addonName, addon = ...
local log = addon.utils.Logger:new({ prefix = "AhHelp" });

SLASH_AHHELP1 = addon.cmd.list.HELP.DEFAULT;
SLASH_AHHELP2 = addon.cmd.list.HELP.SHORT;

function SlashCmdList.AHHELP()
    log:green("Commands list for AH utils addon:");
    local index = 0;

    for key, it in pairs(addon.cmd.list) do
        local description = it.DEFAULT .. " or " .. it.SHORT .. " - " .. it.DESCRIPTION;

        if (index % 2 == 0) then
            log:darkGreen(description);
        else
            log:green(description);
        end

        index = index + 1;
    end
end
