local profile = {};

local varhelper = gFunc.LoadFile('common/varhelper.lua');
local expwarp = gFunc.LoadFile('common/expwarphelper.lua');
local common = gFunc.LoadFile('common/commonfunc.lua');

local macros = require 'ffxi.macros';

local capes = T{
    EXP = { Name = 'Mecisto. Mantle', Augment = { [1] = 'Cap. Point+37%', [2] = 'CHR+1', [3] = 'DEF+1', [4] = 'Mag. Acc.+3' } },
}

local jse = T{
    AF = {
        Head = 'Rev. Coronet +3',
        Body = 'Rev. Surcoat +3',
        Hands = 'Rev. Gauntlets +3',
        Legs = 'Rev. Breeches +3',
        Feet = 'Rev. Leggings +3'
    },
    Relic = {
        Head = '',
        Body = '',
        Hands = '',
        Legs = '',
        Feet = ''
    },
    Empy = {
        Head = '',
        Body = '',
        Hands = '',
        Legs = '',
        Feet = ''
    }
}

local main;

local sets = {
    Idle = {
        Ammo = 'Coiste Bodhar',
        Head = 'Sakpata\'s Helm',
        Neck = 'Elite Royal Collar',
        Ear1 = 'Alabaster Earring',
        Ear2 = 'Cryptic Earring',
        Body = 'Sakpata\'s Plate',
        Hands = 'Sakpata\'s Gauntlets',
        Ring1 = 'Murky Ring',
        Ring2 = 'Moonbeam Ring',
        Back = 'Shadow Mantle',
        Waist = 'Plat. Mog. Belt',
        Legs = 'Sakpata\'s Cuisses',
        Feet = 'Sakpata\'s Leggings',
    },

    DT = {
        Ammo = 'Coiste Bodhar',
        Head = 'Sakpata\'s Helm',
        Neck = 'Elite Royal Collar',
        Ear1 = 'Alabaster Earring',
        Ear2 = 'Cryptic Earring',
        Body = 'Sakpata\'s Plate',
        Hands = 'Sakpata\'s Gauntlets',
        Ring1 = 'Murky Ring',
        Ring2 = 'Moonbeam Ring',
        Back = 'Shadow Mantle',
        Waist = 'Plat. Mog. Belt',
        Legs = 'Sakpata\'s Cuisses',
        Feet = 'Sakpata\'s Leggings',
    },

    Enmity = {
        Head = jse.AF.Head,
        Neck = 'Warder\'s Charm +1',
        Ear1 = 'Friomisi Earring',
        Ear2 = 'Cryptic Earring',
        Body = jse.AF.Body,
        Hands = jse.AF.Hands,
        Ring1 = 'Petrov Ring',
        Ring2 = 'Vengeful Ring',
        Back = 'Cerberus Mantle',
        Waist = 'Plat. Mog. Belt',
        Legs = jse.AF.Legs,
        Feet = 'Souveran Schuhs +1',
    },

    FC = {
        Ear2 = 'Etiolation Earring',
        Body = jse.AF.Body,
        Hands = 'Leyline Gloves',
        Ring1 = 'Kishar Ring'
    },

    SavBlade = {
        Ammo = 'Oshasha\'s Treatise',
        Head = 'Nyame Helm',
        Neck = 'Rep. Plat. Medal',
        Ear1 = 'Thrud Earring',
        Ear2 = { Name = 'Moonshade Earring', Augment = { [1] = 'TP Bonus +250', [2] = '"Mag. Atk. Bns."+4' } },
        Body = 'Nyame Mail',
        Hands = { Name = 'Odyssean Gauntlets', Augment = { [1] = 'Attack+18', [2] = 'STR+1', [3] = 'Weapon skill damage +9%', [4] = 'MND+7', [5] = 'Accuracy+18' } },
        Ring1 = 'Regal Ring',
        Ring2 = 'Ephramad\'s Ring',
        Back = "Cerberus Mantle",
        Waist = { Name = 'Sailfi Belt +1', AugPath='A' },
        Legs = "Nyame Flanchard",
        Feet = "Nyame Sollerets",
    },

    DefaultWeaponskill = {
        Ammo = 'Oshasha\'s Treatise',
        Head = 'Nyame Helm',
        Neck = 'Rep. Plat. Medal',
        Ear1 = 'Thrud Earring',
        Ear2 = { Name = 'Moonshade Earring', Augment = { [1] = 'TP Bonus +250', [2] = '"Mag. Atk. Bns."+4' } },
        Body = 'Nyame Mail',
        Hands = { Name = 'Odyssean Gauntlets', Augment = { [1] = 'Attack+18', [2] = 'STR+1', [3] = 'Weapon skill damage +9%', [4] = 'MND+7', [5] = 'Accuracy+18' } },
        Ring1 = 'Regal Ring',
        Ring2 = 'Ephramad\'s Ring',
        Back = "Cerberus Mantle",
        Waist = { Name = 'Sailfi Belt +1', AugPath='A' },
        Legs = "Nyame Flanchard",
        Feet = "Nyame Sollerets",
    },
    

};


profile.Sets = sets;

profile.Packer = {
};

local player = gData.GetPlayer();

local actions = {
    ['Savage Blade'] = sets.SavBlade,
};

profile.OnLoad = function()
    gSettings.AllowAddSet = true;

    varhelper.Initialize();
    expwarp.Initialize(varhelper);

    -- if (player.SubJob == ("SAM")) then
    --     macros.set_book(4);
    -- elseif (player.SubJob == ("RUN")) then
    --     macros.set_book(5);
    -- end

    varhelper.CreateCycle('DT', {
        [1] = 'Off',
        [2] = 'DT',
        [3] = 'DTacc',
    });

    varhelper.CreateToggle('TH', false);


    varhelper.CreateToggle('EXPcape', false);

    AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^F1 /lac fwd DT');
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^NUMPAD0 /lac fwd TH');
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^NUMPAD1 /lac fwd EXPcape');
end

profile.OnUnload = function()
    varhelper.Destroy();
    expwarp.Destroy();
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^F1');
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^NUMPAD0');
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^NUMPAD1');
end

profile.HandleCommand = function(args)
    if (args[1] == 'DT') then
        varhelper.AdvanceCycle('DT');
    elseif (args[1] == expwarp.WarpCycle) then
        varhelper.AdvanceCycle(expwarp.WarpCycle);
    elseif (args[1] == expwarp.ExpCycle) then
        varhelper.AdvanceCycle(expwarp.ExpCycle);
    elseif (args[1] == expwarp.WarpReset) then
        varhelper.ResetCycle(expwarp.WarpCycle);
    elseif (args[1] == 'TH') then
        varhelper.AdvanceToggle('TH');
    elseif (args[1] == 'EXPcape') then
        varhelper.AdvanceToggle('EXPcape');
    end

end

profile.HandleDefault = function()
    local equip = gData.GetEquipment();


    if (equip.Main ~= nil) then
        if (isTwoHanded(equip.Main.Name) and equip.Sub == nil) then
            -- gFunc.Equip('Sub', 'Khonsu');
            gFunc.Equip('Sub', 'Daduchos Grip');
        end
    end

    -- gFunc.Message("test");

    if (player.Status == 'Engaged') then
        if (varhelper.GetCycle('DT') == 'DT') then
            gFunc.EquipSet(sets.DT);
        elseif (varhelper.GetCycle('DT') == 'DTacc') then
            gFunc.EquipSet(sets.DTacc);
        else
            gFunc.EquipSet(sets.Idle);
        end
    elseif (player.Status == 'Resting') then
        gFunc.EquipSet(sets.PDT);
    else
        if (varhelper.GetCycle('DT') == 'DT') then
            gFunc.EquipSet(sets.DT);
        elseif (varhelper.GetCycle('DT') == 'DTacc') then
            gFunc.EquipSet(sets.DTacc);
        else
            gFunc.EquipSet(sets.Idle);
        end
    end

    if (varhelper.GetToggle('TH') == true) then
        gFunc.EquipSet(sets.TH);
    end

    -- Warp items
    expwarp.Cycle(expwarp.Warp, varhelper);

    -- EXP rings
    expwarp.Cycle(expwarp.Exp, varhelper);

    Schneddick();
    CheckCape();

    if (varhelper.GetToggle('EXPcape') == true) then
        gFunc.Equip('Back', capes['EXP']);
    end
    
    varhelper.Update();
end

profile.HandleAbility = function()
    local action = gData.GetAction();

    if(action.Name == "Palisade" or action.Name == "Shield Bash" or action.Name == "Sentinel") then
        gFunc.EquipSet(sets.Enmity);
    end
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
    gFunc.EquipSet(sets.FC);
end

profile.HandleMidcast = function()
    local action = gData.GetAction();

    if(action.Name == "Flash") then
        gFunc.EquipSet(sets.Enmity);
    end
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
    local action = gData.GetAction();
    local val = actions[action.Name];

    if not val then gFunc.EquipSet(sets.DefaultWeaponskill) else gFunc.EquipSet(val) end
    CheckCape();
end

return profile;