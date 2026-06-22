local profile = {};

local varhelper = gFunc.LoadFile('common/varhelper.lua');
local expwarp = gFunc.LoadFile('common/expwarphelper.lua');
local common = gFunc.LoadFile('common/commonfunc.lua');

local macros = require 'ffxi.macros';

local capes = {
    ['DEX'] = { Name = 'Ankou\'s Mantle', Augment = { [1] = '"Dbl.Atk."+10', [2] = 'DEX+20', [3] = 'Phys. dmg. taken -10%', [4] = 'Attack+20', [5] = 'Accuracy+30' } },
    ['STR'] = { Name = 'Ankou\'s Mantle', Augment = { [1] = 'Weapon skill damage +10%', [2] = 'STR+20', [3] = 'Phys. dmg. taken -10%', [4] = 'Attack+20', [5] = 'Accuracy+20' } },
    ['VIT'] = { Name = 'Ankou\'s Mantle', Augment = { [1] = 'Weapon skill damage +10%', [2] = 'VIT+29', [3] = 'Phys. dmg. taken -10%', [4] = 'Attack+20', [5] = 'Accuracy+20' } },
    ['EXP'] = { Name = 'Mecisto. Mantle', Augment = { [1] = 'Cap. Point+37%', [2] = 'CHR+1', [3] = 'DEF+1', [4] = 'Mag. Acc.+3' } },
}

local jse = {
    ['AF'] = { Head = 'Ignominy Burgeonet', Body = 'Ig. Cuirass +4', Hands = '', Legs = 'Ig. Flanchard +3', Feet = '' },
    ['Relic'] = { Head = 'Fall. Burgeonet +3', Body = 'Fall. Cuirass +3', Hands = 'Fall. Fin. Gaunt.', Legs = 'Fall. Flanchard +4', Feet = '' },
    ['Empy'] = { Head = '', Body = '', Hands = '', Legs = '', Feet = 'Heath. Sollerets +1'}
}

local main;

local sets = {
    ['Idle'] = {
        Ammo = 'Seeth. Bomblet +1',
        Head = 'Flam. Zucchetto +2',
        Neck = { Name = 'Abyssal Beads +1', AugPath='A' },
        Ear1 = 'Alabaster Earring',
        Ear2 = { Name = 'Heath. Earring +1', Augment = { [1] = 'Accuracy+11', [2] = 'Weapon skill damage +2%', [3] = 'Mag. Acc.+11' } },
        Body = 'Sakpata\'s Plate',
        Hands = 'Sakpata\'s Gauntlets',
        Ring1 = 'Murky Ring',
        Ring2 = 'Petrov Ring',
        Back = { Name = 'Ankou\'s Mantle', Augment = { [1] = '"Dbl.Atk."+10', [2] = 'Phys. dmg. taken -10%', [3] = 'Accuracy+30', [4] = 'Attack+20', [5] = 'DEX+20' } },
        Waist = { Name = 'Sailfi Belt +1', AugPath='A' },
        Legs = 'Sakpata\'s Cuisses',
        Feet = 'Flam. Gambieras +2',
    },
    ['PDT'] = {
        Ammo = 'Seeth. Bomblet +1',
        Head = 'Flam. Zucchetto +2',
        Neck = { Name = 'Abyssal Beads +1', AugPath='A' },
        Ear1 = 'Alabaster Earring',
        Ear2 = { Name = 'Heath. Earring +1', Augment = { [1] = 'Accuracy+11', [2] = 'Weapon skill damage +2%', [3] = 'Mag. Acc.+11' } },
        Body = 'Sakpata\'s Plate',
        Hands = 'Sakpata\'s Gauntlets',
        Ring1 = 'Murky Ring',
        Ring2 = 'Petrov Ring',
        Back = { Name = 'Ankou\'s Mantle', Augment = { [1] = '"Dbl.Atk."+10', [2] = 'Phys. dmg. taken -10%', [3] = 'Accuracy+30', [4] = 'Attack+20', [5] = 'DEX+20' } },
        Waist = { Name = 'Sailfi Belt +1', AugPath='A' },
        Legs = 'Sakpata\'s Cuisses',
        Feet = 'Flam. Gambieras +2',
    },
    ['TP'] = {
        Ammo = 'Coiste Bodhar',
        Head = 'Flam. Zucchetto +2',
        Neck = { Name = 'Abyssal Beads +1', AugPath='A' },
        Ear1 = 'Cessance Earring',
        Ear2 = { Name = 'Heath. Earring +1', Augment = { [1] = 'Accuracy+11', [2] = 'Weapon skill damage +2%', [3] = 'Mag. Acc.+11' } },
        Body = 'Valorous Mail',
        Hands = 'Sakpata\'s Gauntlets',
        Ring1 = 'Murky Ring',
        Ring2 = 'Petrov Ring',
        Back = { Name = 'Ankou\'s Mantle', Augment = { [1] = '"Dbl.Atk."+10', [2] = 'Phys. dmg. taken -10%', [3] = 'Accuracy+30', [4] = 'Attack+20', [5] = 'DEX+20' } },
        Waist = { Name = 'Sailfi Belt +1', AugPath='A' },
        Legs = 'Sakpata\'s Cuisses',
        Feet = 'Flam. Gambieras +2',
    },
    ['DefaultWeaponskill'] = {
        Ammo = 'Seeth. Bomblet +1',
        Head = 'Ratri Sallet',
        Neck = 'Abyssal Beads +1',
        Ear1 = { Name = 'Moonshade Earring', Augment = { [1] = '"Mag. Atk. Bns."+4', [2] = 'TP Bonus +250'} },
        Ear2 = 'Thrud Earring',
        Body = jse.AF.Body,
        Hands = 'Odyssean Gauntlets',
        Ring1 = 'Regal Ring',
        Ring2 = 'Petrov Ring',
        Back = capes['STR'],
        Waist = 'Sailfi Belt +1',
        Legs = jse.Relic.Legs,
        Feet = 'Sulev. Leggings +2',
    },
    ['CrossReaper'] = {
        Ammo = 'Seeth. Bomblet +1',
        Head = 'Ratri Sallet',
        Neck = 'Abyssal Beads +1',
        Ear1 = { Name = 'Moonshade Earring', Augment = { [1] = '"Mag. Atk. Bns."+4', [2] = 'TP Bonus +250'} },
        Ear2 = 'Thrud Earring',
        Body = jse.AF.Body,
        Hands = 'Odyssean Gauntlets',
        Ring1 = 'Regal Ring',
        Ring2 = 'Petrov Ring',
        Back = capes['STR'],
        Waist = 'Sailfi Belt +1',
        Legs = jse.Relic.Legs,
        Feet = 'Sulev. Leggings +2',
    },
    ['FotiaWS'] = {
        Ammo = 'Seeth. Bomblet +1',
        Head = 'Flam. Zucchetto +2',
        Neck = 'Abyssal Beads +1',
        Ear1 = { Name = 'Moonshade Earring', Augment = { [1] = '"Mag. Atk. Bns."+4', [2] = 'TP Bonus +250'} },
        Ear2 = 'Thrud Earring',
        Body = { Name = 'Valorous Mail', Augment = { [1] = 'Accuracy+37', [2] = 'Crit.hit rate+3', [3] = 'Attack+22', [4] = 'DEX+7' } },
        Hands = 'Odyssean Gauntlets',
        Ring1 = 'Regal Ring',
        Ring2 = 'Petrov Ring',
        Back = capes['STR'],
        Waist = 'Fotia Belt',
        Legs = jse.Relic.Legs,
        Feet = 'Sulev. Leggings +2',
    },
    ['Torcleaver'] = {
        Ammo = 'Seeth. Bomblet +1',
        Head = 'Ratri Sallet',
        Neck = 'Abyssal Beads +1',
        Ear1 = { Name = 'Moonshade Earring', Augment = { [1] = '"Mag. Atk. Bns."+4', [2] = 'TP Bonus +250'} },
        Ear2 = 'Thrud Earring',
        Body = jse.AF.Body,
        Hands = 'Odyssean Gauntlets',
        Ring1 = 'Regal Ring',
        Ring2 = 'Petrov Ring',
        Back = capes['VIT'],
        Waist = 'Sailfi Belt +1',
        Legs = jse.Relic.Legs,
        Feet = 'Sulev. Leggings +2',
    },
    ['Drain'] = {
        Ammo = 'Seeth. Bomblet +1',
        Head = jse.Relic.Head,
        Neck = 'Sanctity Necklace',
        Ear1 = 'Strophadic Earring',
        Ear2 = 'Hecate\'s Earring',
        Body = jse.Relic.Body,
        Hands = jse.Relic.Hands,
        Ring1 = 'Evanescence Ring',
        Ring2 = 'Archon Ring',
        Back = { Name = 'Niht Mantle', Augment = { [1] = 'Dark magic skill +10', [2] = 'Attack+10', [3] = '"Drain" and "Aspir" potency +17' } },
        Waist = 'Eschan Stone',
        Legs = { Name = 'Eschite Cuisses', AugPath='D' },
        Feet = 'Ratri Sollerets',
    },
    ['Stun'] = {
        Ammo = 'Seeth. Bomblet +1',
        Head = jse.Relic.Head,
        Neck = 'Sanctity Necklace',
        Ear1 = 'Strophadic Earring',
        Ear2 = 'Hecate\'s Earring',
        Body = jse.Relic.Body,
        Hands = jse.Relic.Hands,
        Ring1 = 'Etana Ring',
        Ring2 = 'Mujin Band',
        Back = { Name = 'Niht Mantle', Augment = { [1] = 'Dark magic skill +10', [2] = 'Attack+10', [3] = '"Drain" and "Aspir" potency +17' } },
        Waist = 'Eschan Stone',
        Legs = { Name = 'Eschite Cuisses', AugPath='D' },
        Feet = 'Ratri Sollerets',
    },
    ['DreadSpikes'] = {
        Ammo = 'Seeth. Bomblet +1',
        Head = 'Ratri Sallet',
        Neck = 'Sanctity Necklace',
        Ear1 = 'Strophadic Earring',
        Ear2 = 'Alabaster Earring',
        Body = jse.Relic.Body,
        Hands = 'Ratri Gadlings',
        Ring1 = 'Etana Ring',
        Ring2 = 'Moonbeam Ring',
        Back = { Name = 'Niht Mantle', Augment = { [1] = 'Dark magic skill +10', [2] = 'Attack+10', [3] = '"Drain" and "Aspir" potency +17' } },
        Waist = 'Eschan Stone',
        Legs = { Name = 'Eschite Cuisses', AugPath='D' },
        Feet = 'Ratri Sollerets',
    },
    ['FC'] = {
        Ammo = 'Seeth. Bomblet +1',
        Head = jse.Relic.Head,
        Neck = 'Sanctity Necklace',
        Ear1 = 'Etiolation Earring',
        Ear2 = 'Hecate\'s Earring',
        Body = jse.Relic.Body,
        Hands = jse.Relic.Hands,
        Ring1 = 'Etana Ring',
        Ring2 = 'Mujin Band',
        Back = { Name = 'Niht Mantle', Augment = { [1] = 'Dark magic skill +10', [2] = 'Attack+10', [3] = '"Drain" and "Aspir" potency +17' } },
        Waist = 'Eschan Stone',
        Legs = { Name = 'Eschite Cuisses', AugPath='D' },
        Feet = 'Flam. Gambieras +2',
    },
    ['SavBlade'] = {
        Ammo = 'Seeth. Bomblet +1',
        Head = 'Ratri Sallet',
        Neck = { Name = 'Abyssal Beads +1', AugPath='A' },
        Ear1 = 'Thrud Earring',
        Ear2 = { Name = 'Moonshade Earring', Augment = { [1] = 'TP Bonus +250', [2] = '"Mag. Atk. Bns."+4' } },
        Body = 'Ig. Cuirass +4',
        Hands = { Name = 'Odyssean Gauntlets', Augment = { [1] = 'Attack+18', [2] = 'STR+1', [3] = 'Weapon skill damage +9%', [4] = 'MND+7', [5] = 'Accuracy+18' } },
        Ring1 = 'Regal Ring',
        Ring2 = { Name = 'Murky Ring', AugPath='A' },
        Back = { Name = 'Ankou\'s Mantle', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = 'STR+20', [3] = 'Accuracy+20', [4] = 'Attack+20', [5] = 'Weapon skill damage +10%' } },
        Waist = { Name = 'Sailfi Belt +1', AugPath='A' },
        Legs = { Name = 'Fall. Flanchard +4', AugTrial=5633 },
        Feet = 'Sulev. Leggings +2',
    },
    ['TH'] = {
        Ammo = 'Per. Lucky Egg',
        Head = 'Wh. Rarab Cap +1',
        Waist = 'Chaac Belt',
    },
    ['DTacc'] = {
        Ammo = 'Seeth. Bomblet +1',
        Head = 'Sulevia\'s Mask +2',
        Neck = { Name = 'Abyssal Beads +1', AugPath='A' },
        Ear1 = 'Cessance Earring',
        Ear2 = 'Heath. Earring +1',
        Body = 'Sulevia\'s Plate. +2',
        Hands = 'Sulev. Gauntlets +2',
        Ring1 = 'Moonbeam Ring',
        Ring2 = 'Sulevia\'s Ring',
        Back = { Name = 'Ankou\'s Mantle', Augment = { [1] = '"Dbl.Atk."+10', [2] = 'Phys. dmg. taken -10%', [3] = 'Accuracy+30', [4] = 'Attack+20', [5] = 'DEX+20' } },
        Waist = 'Eschan Stone',
        Legs = 'Sulev. Cuisses +2',
        Feet = 'Sulev. Leggings +2',
    },
    ['Catastrophe'] = {
        Ammo = 'Seeth. Bomblet +1',
        Head = 'Ratri Sallet',
        Neck = 'Abyssal Beads +1',
        Ear1 = 'Thrud Earring',
        Ear2 = 'Heath. Earring +1',
        Body = jse.AF.Body,
        Hands = 'Odyssean Gauntlets',
        Ring1 = 'Regal Ring',
        Ring2 = 'Petrov Ring',
        Back = capes['STR'],
        Waist = { Name = 'Sailfi Belt +1', AugPath='A' },
        Legs = jse.Relic.Legs,
        Feet = 'Sulev. Leggings +2',
    },
    ['Shockwave'] = {
        Ammo = 'Seeth. Bomblet +1',
        Head = jse.Relic.Head,
        Neck = 'Abyssal Beads +1',
        Ear1 = 'Thrud Earring',
        Ear2 = 'Moonshade Earring',
        Body = jse.AF.Body,
        Hands = 'Odyssean Gauntlets',
        Ring1 = 'Regal Ring',
        Ring2 = 'Petrov Ring',
        Back = capes['STR'],
        Waist = "Fotia Belt",
        Legs = jse.Relic.Legs,
        Feet = "Sulev. Leggings +2",
    },
    ['Lockstyle'] = {
        Main = 'Beorc Sword',
        Sub = 'Umbra Strap',
        Head = 'Eyepatch',
        Body = 'Bellicus cuirass',
        Hands = 'Bellicus dastanas',
        Legs = 'Bellicus cuisses',
        Feet = 'Bellicus sabatons',
    },
    ['TownIdle'] = {
        Ammo = 'Coiste Bodhar',
        Head = { Name = 'Fall. Burgeonet +3', AugTrial=5457 },
        Neck = { Name = 'Abyssal Beads +1', AugPath='A' },
        Ear1 = { Name = 'Moonshade Earring', Augment = { [1] = 'TP Bonus +250', [2] = '"Mag. Atk. Bns."+4' } },
        Ear2 = { Name = 'Heath. Earring +1', Augment = { [1] = 'Accuracy+11', [2] = 'Weapon skill damage +2%', [3] = 'Mag. Acc.+11' } },
        Body = 'Ig. Cuirass +4',
        Hands = 'Sakpata\'s Gauntlets',
        Ring1 = { Name = 'Murky Ring', AugPath='A' },
        Ring2 = 'Petrov Ring',
        Back = { Name = 'Ankou\'s Mantle', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = 'Accuracy+20', [3] = 'Attack+20', [4] = 'VIT+29', [5] = 'Weapon skill damage +10%' } },
        Waist = { Name = 'Sailfi Belt +1', AugPath='A' },
        Legs = { Name = 'Fall. Flanchard +4', AugTrial=5633 },
        Feet = 'Sakpata\'s Leggings',
    }};

local actions = {
    ["Savage Blade"] = sets.FotiaWS,
    ["Torcleaver"] = sets.Torcleaver,
    ["Cross Reaper"] = sets.Crossreaper,
    ["Catastrophe"] = sets.Catastrophe,
    ["Shockwave"] = sets.Shockwave,
    ["Resolution"] = sets.FotiaWS,
    ["Ground Strike"] = sets.FotiaWS,
    ["Qietus"] = sets.FotiaWS,
    ["Entropy"] = sets.FotiaWS,
    ["Insurgency"] = sets.FotiaWS
};

profile.Sets = sets;

profile.Packer = {
    { Name = 'Remedy', Quantity = 12 },
    { Name = 'Prism Powder', Quantity = 12 },
    { Name = 'Silent Oil', Quantity = 12 }
};


profile.OnLoad = function()
    gSettings.AllowAddSet = true;

    varhelper.Initialize();
    expwarp.Initialize(varhelper);

    varhelper.CreateCycle('DT', {
        [1] = 'Off',
        [2] = 'PDT',
        [3] = 'DTacc',
    });

    varhelper.CreateToggle('TH', false);

    varhelper.CreateCycle('FPS', {
        [1] = '30',
        [2] = '60',
    });

    varhelper.CreateToggle('EXPcape', false);

    AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^F1 /lac fwd DT');
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^NUMPAD0 /lac fwd TH');
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^NUMPAD1 /lac fwd EXPcape');
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^NUMPAD2 /lac fwd FPS');
    gFunc.LockStyle(sets.Lockstyle);
end

profile.OnUnload = function()
    varhelper.Destroy();
    expwarp.Destroy();
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^F1');
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^NUMPAD0');
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^NUMPAD1');
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^NUMPAD2');
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
    elseif (args[1] == 'FPS') then
        varhelper.AdvanceCycle('FPS');
        if(varhelper.GetCycle('FPS') == '30') then
            AshitaCore:GetChatManager():QueueCommand(-1, '/fps 2');
        elseif (varhelper.GetCycle('FPS') == '60') then
            AshitaCore:GetChatManager():QueueCommand(-1, '/fps 1');
        end
    end

end

profile.HandleDefault = function()
    local player = gData.GetPlayer();
    local equip = gData.GetEquipment();


    if (equip.Main ~= nil) then
        if (isTwoHanded(equip.Main.Name) and equip.Sub == nil) then
            gFunc.Equip('Sub', 'Kaja Grip');
        end
    end

    if (player.SubJob == ("SAM")) then
        macros.set_book(4);
    elseif (player.SubJob == ("RUN")) then
        macros.set_book(5);
    end

    if (player.Status == 'Engaged') then
        if (varhelper.GetCycle('DT') == 'PDT') then
            gFunc.EquipSet(sets.PDT);
        elseif (varhelper.GetCycle('DT') == 'DTacc') then
            gFunc.EquipSet(sets.DTacc);
        else
            gFunc.EquipSet(sets.TP);
        end
    elseif (player.Status == 'Resting') then
        gFunc.EquipSet(sets.PDT);
    else
        if (varhelper.GetCycle('DT') == 'PDT') then
            gFunc.EquipSet(sets.PDT);
        elseif (varhelper.GetCycle('DT') == 'DTacc') then
            gFunc.EquipSet(sets.DTacc);
        else
            gFunc.EquipSet(sets.Idle);
        end
    end
    if(IsInTown() == true) then
        gFunc.EquipSet(sets.TownIdle);
    end

    if (varhelper.GetToggle('TH') == true) then
        gFunc.EquipSet(sets.TH);
    end

    -- if (player.Status == 'Engaged') then
    --     local mob = gData.GetTarget();
    --     if(player.TP > 1000 and mob.HPP <= 60) then
    --         AshitaCore:GetChatManager():QueueCommand(-1, '/ws Catastrophe <t>');
    --     end
    -- end

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

    if(action == "Blood Weapon") then
        gFunc.Equip("Body", jse.Relic.Body);
    end

    CheckCape();
end

profile.HandleItem = function()
    CheckCape();
end

profile.HandlePrecast = function()
    gFunc.EquipSet(sets.FC);
end

profile.HandleMidcast = function()
    local action = gData.GetAction();

    if(action.Name == "Drain II" or action.Name == "Drain III" or action.Name == "Thunder III" ) then
        gFunc.EquipSet(sets.Drain);
    end

    if(action.Name == "Stun") then
        gFunc.EquipSet(sets.Stun);
    end

    if(action.Name == "Dread Spikes") then
        gFunc.EquipSet(sets.DreadSpikes);
    end
    CheckCape();
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
    CheckCape();
end

profile.HandleWeaponskill = function()
    local action = gData.GetAction();
    local val = actions[action.Name];
    if not val then gFunc.EquipSet(sets.DefaultWeaponskill) else gFunc.EquipSet(val) end
    CheckCape();
end

return profile;