local profile = {};
local Aby = {};

local varhelper = gFunc.LoadFile('common/varhelper.lua');

local macros = require 'ffxi.macros';

local sets = {
};
profile.Sets = sets;

profile.Packer = {
};

Aby.Weapons = {
    ['Sword'] = "Nihility";
    ['Dagger'] = "Palladium Dagger";
    ['Staff'] = "Treat Staff II";
    ['Club'] = "Hagoita";
    ['GSword'] = "Goujian";
    ['Scythe'] = "Lost Sickle";
    ['Polearm'] = "Iapetus";
    ['Katana'] = "Debahocho";
    ['GKatana'] = "Mutsunokami +1";
}

profile.OnLoad = function()
    gSettings.AllowAddSet = true;

    varhelper.Initialize();
    varhelper.CreateToggle('Abyssea', false);
    varhelper.CreateCycle('Aby Procs', {
        [1] = 'Dagger',
        [2] = 'Sword',
        [3] = 'Staff',
        [4] = 'Club',
        [5] = 'GSword',
        [6] = 'Scythe',
        [7] = 'Polearm',
        [8] = 'Katana',
        [9] = 'GKatana',
    });

    AshitaCore:GetChatManager():QueueCommand(-1, '/bind !F1 /lac fwd Abyssea');
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^F1 /lac fwd "Aby Procs"');
end

profile.OnUnload = function()
    varhelper.Destroy();
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind !F1');
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^F1');
end

profile.HandleCommand = function(args)
    if (args[1] == 'Abyssea') then
        varhelper.AdvanceToggle('Abyssea');
    elseif (args[1] == 'Aby Procs') then
        varhelper.AdvanceCycle('Aby Procs');
    end
end

profile.HandleDefault = function()
        local player = gData.GetPlayer();

        if (player.Status == 'Engaged') then
            gFunc.Equip('Ammo', "Suppa Shuriken");
            if (varhelper.GetToggle('Abyssea') == true) then
                if (varhelper.GetCycle('Aby Procs') == 'Dagger') then
                    gFunc.Equip('Main', Aby.Weapons['Dagger']);
                    gFunc.Equip('Sub', Aby.Weapons['Katana']);
                elseif (varhelper.GetCycle('Aby Procs') == 'Sword') then
                    gFunc.Equip('Main', Aby.Weapons['Sword']);
                    gFunc.Equip('Sub', Aby.Weapons['Dagger']);
                elseif (varhelper.GetCycle('Aby Procs') == 'Staff') then
                    gFunc.Equip('Main', Aby.Weapons['Staff']);
                elseif (varhelper.GetCycle('Aby Procs') == 'Club') then
                    gFunc.Equip('Main', Aby.Weapons['Club']);
                    gFunc.Equip('Sub', Aby.Weapons['Dagger']);
                elseif (varhelper.GetCycle('Aby Procs') == 'GSword') then
                    gFunc.Equip('Main', Aby.Weapons['GSword']);
                elseif (varhelper.GetCycle('Aby Procs') == 'Scythe') then
                    gFunc.Equip('Main', Aby.Weapons['Scythe']);
                elseif (varhelper.GetCycle('Aby Procs') == 'Polearm') then
                    gFunc.Equip('Main', Aby.Weapons['Polearm']);
                elseif (varhelper.GetCycle('Aby Procs') == 'Katana') then
                    gFunc.Equip('Main', Aby.Weapons['Katana']);
                    gFunc.Equip('Sub', Aby.Weapons['Dagger']);
                elseif (varhelper.GetCycle('Aby Procs') == 'GKatana') then
                    gFunc.Equip('Main', Aby.Weapons['GKatana']);
                end
            else
                gFunc.Equip('Main', "Naegling");
                gFunc.Equip('Sub', "Kaja Knife");
                gFunc.Equip('Ammo', 'Per. Lucky Egg');
            end
        end
end

profile.HandleAbility = function()
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
end

profile.HandleMidcast = function()
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
end

return profile;