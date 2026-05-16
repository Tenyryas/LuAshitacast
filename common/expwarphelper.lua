-- ExpWarp Helper by Kyane
-- That lua necessitates the use of the varhelper.lua file for cycling and toggling
-- Put this file in your common folder in your luashitacast config folder
-- load with local expwarp = gFunc.LoadFile('common/expwarphelper.lua'); in your main Lua and use that variable to access everything contained here

local warp = {
    [1] = 'Off',
    [2] = 'Warp Ring',
    [3] = 'Dim. Ring (Dem)',
    [4] = 'Dim. Ring (Holla)',
    [5] = 'Dim. Ring (Mea)',
    [6] = "Nexus Cape"
};

local exp = {
    [1] = 'Off',
    [2] = 'Empress Band',
    [3] = 'Trizek Ring',
    [4] = 'Endorsement Ring',
    [5] = 'Echad Ring'
};

local expcape = false;

local expwarphelper = {
    Warp = warp;
    Exp = exp;
    WarpCycle = "Warp";
    WarpReset = "WarpR";
    ExpCycle = "EXP";
};

-- Requires a varhelper.GetCycle() function as variable.
-- Example: expwarp.CycleWarp(varhelper.GetCycle('Warp'));
expwarphelper.CycleWarp = function(getcycle)
    if (getcycle ~= "Off") then
        if(getcycle == "Warp Cudgel") then
            gFunc.Equip('Main', getcycle);
        elseif(getcycle == "Nexus Cape") then
            gFunc.Equip('Back', getcycle);
        else
            gFunc.Equip('Ring1', getcycle);
        end
    end
end

-- Requires a varhelper.GetCycle() function as variable.
-- Example: expwarp.CycleWarp(varhelper.GetCycle('Exp'));
expwarphelper.CycleExp = function(getcycle)
    if (getcycle ~= "Off") then
        gFunc.Equip('Ring2', getcycle);
    end
end

-- Frontend function for CycleWarp & CycleExp.
-- @param varCycle: string.
-- @param varhelper: varhelper variable.
expwarphelper.Cycle = function (varCycle, varhelper)
    if(varCycle == expwarphelper.Warp)then
        expwarphelper.CycleWarp(varhelper.GetCycle(expwarphelper.WarpCycle));
    elseif (varCycle == expwarphelper.Exp) then
        expwarphelper.CycleExp(varhelper.GetCycle(expwarphelper.ExpCycle));
    end
end

expwarphelper.Initialize = function(varhelper)
    varhelper.CreateCycle(expwarphelper.WarpCycle, expwarphelper.Warp);
    varhelper.CreateCycle(expwarphelper.ExpCycle, expwarphelper.Exp);

    AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^F12 /lac fwd Warp');
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind +^F12 /lac fwd WarpR');
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind !F12 /lac fwd EXP');
end

expwarphelper.Destroy = function()
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^F12');
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind +^F12');
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind !F12');
end


return expwarphelper;