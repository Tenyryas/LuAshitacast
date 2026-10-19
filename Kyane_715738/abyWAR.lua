local profile = {};
local Aby = {};

local varhelper = gFunc.LoadFile('common/varhelper.lua');
local common = gFunc.LoadFile('common/commonfunc.lua');

local macros = require 'ffxi.macros';

local sets = {
    Idle = {
        Ammo = 'Seeth. Bomblet +1',
        Head = 'Malignance Chapeau',
        Neck = 'Sanctity Necklace',
        Ear1 = { Name = 'Alabaster Earring', AugPath='A' },
        Ear2 = 'Cassie Earring',
        Body = 'Malignance Tabard',
        Hands = 'Nyame Gauntlets',
        Ring1 = { Name = 'Murky Ring', AugPath='A' },
        Ring2 = 'Petrov Ring',
        Back = 'Izdubar Mantle',
        Waist = { Name = 'Sailfi Belt +1', AugPath='A' },
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },
    TP = {
        Ammo = 'Seeth. Bomblet +1',
        Head = 'Malignance Chapeau',
        Neck = 'Iskur Gorget',
        Ear1 = 'Suppanomimi',
        Ear2 = 'Eabani Earring',
        Body = 'Malignance Tabard',
        Hands = 'Adhemar Wristbands',
        Ring1 = { Name = 'Murky Ring', AugPath='A' },
        Ring2 = 'Petrov Ring',
        Back = 'Izdubar Mantle',
        Waist = { Name = 'Sailfi Belt +1', AugPath='A' },
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },
    TH = {
        Ammo = 'Per. Lucky Egg',
        Head = 'Wh. Rarab Cap +1',
        Waist = 'Chaac Belt',
    },
    Aeolian = {
        Head = 'Nyame Helm',
        Neck = 'Sanctity necklace',
        Ear1 = { Name = 'Moonshade Earring', Augment = { [1] = 'TP Bonus +250', [2] = '"Mag. Atk. Bns."+4' } },
        Ear2 = 'Friomisi Earring',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Regal Ring',
        Ring2 = 'Dingir Ring',
        Back = 'Izdubar Mantle',
        Waist = 'Eschan Stone',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },
};
profile.Sets = sets;

profile.Packer = {
};

local actions = {
    ['Aeolian Edge'] = sets.Aeolian,
    ['Red Lotus Blade'] = sets.Aeolian,
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
    varhelper.CreateToggle('TH', false);

    AshitaCore:GetChatManager():QueueCommand(-1, '/bind !F1 /lac fwd Abyssea');
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^NUMPAD0 /lac fwd TH');
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^F1 /lac fwd "Aby Procs"');
end

profile.OnUnload = function()
    varhelper.Destroy();
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind !F1');
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^F1');
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^NUMPAD0');
end

profile.HandleCommand = function(args)
    if (args[1] == 'Abyssea') then
        varhelper.AdvanceToggle('Abyssea');
    elseif (args[1] == 'Aby Procs') then
        varhelper.AdvanceCycle('Aby Procs');
    elseif (args[1] == 'TH') then
        varhelper.AdvanceToggle('TH');
    end
end

profile.HandleDefault = function()
        local player = gData.GetPlayer();

        gFunc.EquipSet(sets.Idle);
        if (player.Status == 'Engaged') then
            gFunc.EquipSet(sets.TP);

        if(varhelper.GetToggle('TH') == true) then
            gFunc.EquipSet(sets.TH);
        end
            if (varhelper.GetToggle('Abyssea') == true) then
                
                gFunc.EquipSet(sets.TH);
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
                gFunc.Equip('Sub', "Tauret");
            end
        end

        Schneddick();
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
    local action = gData.GetAction();
    local val = actions[action.Name];

    if not val then gFunc.EquipSet(sets.DefaultWeaponskill) else gFunc.EquipSet(val) end
end

return profile;