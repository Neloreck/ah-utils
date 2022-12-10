local addonName, addon = ...;
local cmdList = addon.cmd.list;
local Logger = addon.utils.logging.Logger;

local log = Logger:new({ prefix = "AhHelp" });

function SlashCmdList.AH_HELP()
    log:green("Commands list for AH utils addon:");
    local index = 0;

    for key, it in pairs(cmdList) do
        local description = it.DEFAULT .. " or " .. it.SHORT .. " - " .. it.DESCRIPTION;

        if (index % 2 == 0) then
            log:darkGreen(description);
        else
            log:green(description);
        end

        index = index + 1;
    end
end
