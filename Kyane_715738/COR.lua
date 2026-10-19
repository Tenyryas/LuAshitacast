local profile = {};

local varhelper = gFunc.LoadFile('common/varhelper.lua');
local expwarp = gFunc.LoadFile('common/expwarphelper.lua');
local common = gFunc.LoadFile('common/commonfunc.lua');

local equip = gData.GetEquipment();

local macros = require 'ffxi.macros';

local capes = T{
    MagWS = { Name = 'Camulus\'s Mantle', Augment = { [1] = 'Weapon skill damage +10%', [2] = 'Magic Damage+20', [3] = 'AGI+30', [4] = 'Mag. Acc.+20' } },
    MeleeTP = { Name = 'Camulus\'s Mantle', Augment = { [1] = 'Damage taken-5%', [2] = '"Dbl.Atk."+10', [3] = 'Accuracy+27', [4] = 'Attack+20', [5] = 'DEX+20' } },
    Midshot = { Name = 'Camulus\'s Mantle', Augment = { [1] = 'Damage taken-5%', [2] = 'Rng.Acc.+30', [3] = 'AGI+20', [4] = '"Store TP"+10', [5] = 'Rng.Atk.+20' } },
    EXP = { Name = 'Mecisto. Mantle', Augment = { [1] = 'Cap. Point+37%', [2] = 'CHR+1', [3] = 'DEF+1', [4] = 'Mag. Acc.+3' } },
}

local jse = T{
    AF = {
        Head = 'Laksa. Tricorne +4',
        Body = 'Laksa. Frac +4',
        Hands = '',
        Legs = 'Laksa. Trews +4',
        Feet = ''
    },
    Relic = {
        Head = 'Lanun Tricorne +2',
        Body = 'Lanun Frac +4',
        Hands = 'Lanun Gants +4',
        Legs = 'Lanun Trews +2',
        Feet = 'Lanun Bottes +4'
    },
    Empy = {
        Head = 'Chass. Tricorne +2',
        Body = 'Chasseur\'s Frac +2',
        Hands = 'Chasseur\'s Gants +3',
        Legs = 'Chas. Culottes +2',
        Feet = 'Chass. Bottes +3'
    }
}

local weapons = T{
    LanunRoll = { Name = 'Lanun Knife', AugPath='C' },
    Fomalhaut = 'Fomalhaut',
    Compensator = 'Compensator',
    Daduchos = 'Daduchos Saber',
    Tauret = 'Tauret',
    Naegling = 'Naegling',
    Nusku = 'Nusku Shield'
}

local wsets = T{
    M_DaggerDW = T{
        Main = weapons.Tauret,
        Sub = weapons.Daduchos
    },
    LM_DaggerDW = T{
        Main = weapons.LanunRoll,
        Sub = weapons.Daduchos
    },
    M_SwordDW = T{
        Main = weapons.Naegling,
        Sub = weapons.Daduchos
    },
    Naegling = T{
        Main = weapons.Naegling,
        Sub = weapons.Nusku
    },
    Lanun = T{
        Main = weapons.LanunRoll,
        Sub = weapons.Nusku
    },
}

local sets = T{
    Idle = {
        Range = 'Fomalhaut',
        Head = 'Malignance Chapeau',
        Neck = 'Sanctity Necklace',
        Ear1 = { Name = 'Alabaster Earring', AugPath='A' },
        Ear2 = 'Cassie Earring',
        Body = 'Malignance Tabard',
        Hands = 'Nyame Gauntlets',
        Ring1 = { Name = 'Murky Ring', AugPath='A' },
        Ring2 = 'Petrov Ring',
        Back = capes.MeleeTP,
        Waist = { Name = 'Sailfi Belt +1', AugPath='A' },
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },
    DT = {
        Head = 'Malignance Chapeau',
        Neck = 'Sanctity Necklace',
        Ear1 = { Name = 'Alabaster Earring', AugPath='A' },
        Ear2 = 'Cessance Earring',
        Body = 'Malignance Tabard',
        Hands = 'Nyame Gauntlets',
        Ring1 = { Name = 'Murky Ring', AugPath='A' },
        Ring2 = 'Petrov Ring',
        Back = capes.MeleeTP,
        Waist = { Name = 'Sailfi Belt +1', AugPath='A' },
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },
    TP = {
        Head = 'Malignance Chapeau',
        Neck = 'Iskur Gorget',
        Ear1 = 'Suppanomimi',
        Ear2 = 'Eabani Earring',
        Body = 'Malignance Tabard',
        Hands = 'Adhemar Wristbands',
        Ring1 = { Name = 'Murky Ring', AugPath='A' },
        Ring2 = 'Petrov Ring',
        Back = capes.MeleeTP,
        Waist = { Name = 'Sailfi Belt +1', AugPath='A' },
        Legs = jse.Empy.Legs,
        Feet = jse.Empy.Feet,
    },
    TH = {
        Ammo = 'Per. Lucky Egg',
        Head = 'Wh. Rarab Cap +1',
        Waist = 'Chaac Belt',
    },
    Roll = {
        Main = weapons.LanunRoll,
        -- Range = weapons.Compensator,
        Head =  jse.Relic.Head,
        Hands = jse.Empy.Hands,
        Ring1 = "Luzaf's Ring",
    },
    LeadenSalute = {
        Head = 'Pixie Hairpin +1',
        Neck = 'Comm. Charm +2',
        Ear1 = 'Moonshade Earring',
        Ear2 = 'Friomisi Earring',
        Body = jse.Relic.Body,
        Hands = jse.Empy.Hands,
        Ring1 = "Archon Ring",
        Ring2 = 'Dingir Ring',
        Back = capes.MagWS,
        Waist = 'Eschan Stone',
        Legs = 'Nyame Flanchard',
        Feet = jse.Relic.Feet,
    },
    HotShot = {
        Head = 'Nyame Helm',
        Neck = 'Comm. Charm +2',
        Ear1 = 'Moonshade Earring',
        Ear2 = 'Friomisi Earring',
        Body = jse.AF.Body,
        Hands = jse.Empy.Hands,
        Ring1 = "Archon Ring",
        Ring2 = 'Dingir Ring',
        Back = capes.MagWS,
        Waist = 'Fotia Belt',
        Legs = 'Nyame Flanchard',
        Feet = jse.Relic.Feet,
    },
    Wildfire = {
        Head = 'Nyame Helm',
        Neck = 'Comm. Charm +2',
        Ear1 = 'Moonshade Earring',
        Ear2 = 'Hecate\'s Earring',
        Body = jse.Relic.Body,
        Hands = jse.Empy.Hands,
        Ring1 = "Archon Ring",
        Ring2 = 'Dingir Ring',
        Back = capes.MagWS,
        Waist = 'Eschan Stone',
        Legs = 'Nyame Flanchard',
        Feet = jse.Relic.Feet,
    },
    LastStand = {
        Head = jse.Relic.Head,
        Neck = 'Sanctity Necklace',
        Ear1 = 'Moonshade Earring',
        Ear2 = 'Ishvara Earring',
        Body = jse.AF.Body,
        Hands = jse.Empy.Hands,
        Ring1 = "Regal Ring",
        Ring2 = 'Dingir Ring',
        Back = capes.Midshot,
        Waist = 'Fotia Belt',
        Legs = 'Nyame Flanchard',
        Feet = jse.Relic.Feet,
    },
    Aeolian = {
        Head = 'Nyame Helm',
        Neck = 'Comm. Charm +2',
        Ear1 = { Name = 'Moonshade Earring', Augment = { [1] = 'TP Bonus +250', [2] = '"Mag. Atk. Bns."+4' } },
        Ear2 = 'Friomisi Earring',
        Body = jse.Relic.Body,
        Hands = jse.Empy.Hands,
        Ring1 = 'Regal Ring',
        Ring2 = 'Dingir Ring',
        Back = capes.MagWS,
        Waist = 'Eschan Stone',
        Legs = jse.AF.Legs,
        Feet = jse.Relic.Feet,
    },
    preshot = {
        Head = jse.Empy.Head,
        Neck = 'Comm. Charm +2',
        Ear1 = { Name = 'Alabaster Earring', AugPath='A' },
        Ear2 = 'Enervating Earring',
        Body = jse.AF.Body,
        Hands = jse.Relic.Hands,
        Ring1 = 'Regal Ring',
        Ring2 = 'Dingir Ring',
        Back = 'Camulus\'s mantle',
        Waist = 'Eschan Stone',
        Legs = jse.AF.Legs,
        Feet = 'Meg. Jam. +2',
    },
    midshot = {
        Head = 'Malignance Chapeau',
        Neck = 'Comm. Charm +2',
        Ear1 = { Name = 'Alabaster Earring', AugPath='A' },
        Ear2 = 'Enervating Earring',
        Body = jse.Empy.Body,
        Hands = jse.Empy.Hands,
        Ring1 = 'Regal Ring',
        Ring2 = 'Dingir Ring',
        Back = capes.Midshot,
        Waist = 'Eschan Stone',
        Legs = jse.Empy.Legs,
        Feet = jse.Empy.Feet,
    },
    qdraw = {
        Head = 'Nyame Helm',
        Neck = 'Iskur Gorget',
        Ear1 = 'Friomisi Earring',
        Ear2 = 'Hecate\'s Earring',
        Body = jse.Relic.Body,
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Regal Ring',
        Ring2 = 'Dingir Ring',
        Back = capes.MagWS,
        Waist = 'Eschan Stone',
        Legs = jse.AF.Legs,
        Feet = jse.Empy.Feet,
    },
    SavBlade = {
        Head = 'Meghanada Visor +2',
        Neck = 'Rep. Plat. Medal',
        Ear1 = 'Moonshade Earring',
        Ear2 = 'Ishvara Earring',
        Body = jse.AF.Body,
        Hands = jse.Empy.Hands,
        Ring1 = 'Regal Ring',
        Ring2 = 'Ephramad\'s Ring',
        Back = capes.MeleeTP,
        Waist = 'Sailfi Belt +1',
        Legs = 'Meg. Chausses +2',
        Feet = jse.Relic.Feet,
    },
    tripleShot = {
        Head = 'Oshosi Mask',
        Body = jse.Empy.Body,
        Hands = jse.Relic.Hands,
        Back = capes.Midshot,
        Legs = 'Oshosi Trousers',
        Feet = 'Oshosi Leggings',
    },
    AccMidshot = {
        Ammo = 'Chrono Bullet',
        Head = jse.AF.Head,
        Neck = 'Iskur Gorget',
        Ear1 = { Name = 'Alabaster Earring', AugPath='A' },
        Ear2 = 'Enervating Earring',
        Body = jse.AF.Body,
        Hands = jse.Empy.Hands,
        Ring1 = 'Regal Ring',
        Ring2 = 'Ephramad\'s Ring',
        Back = capes.Midshot,
        Waist = 'Eschan Stone',
        Legs = jse.AF.Legs,
        Feet = jse.Empy.Feet,
    },

}
profile.Sets = sets;

profile.Packer = {
};

local actions = {
    ['Savage Blade'] = sets.SavBlade,
    ['Leaden Salute'] = sets.LeadenSalute,
    ['Hot Shot'] = sets.HotShot,
    ['Wildfire'] = sets.Wildfire,
    ['Last Stand'] = sets.LastStand,
    ['Aeolian Edge'] = sets.Aeolian,
};

local player = gData.GetPlayer();

profile.OnLoad = function()
    gSettings.AllowAddSet = true;

    varhelper.Initialize();
    expwarp.Initialize(varhelper);

    macros.set_book(0);

    varhelper.CreateCycle('DT', {
        [1] = 'Off',
        [2] = 'DT'
    });

    varhelper.CreateToggle('TH', false);
    varhelper.CreateToggle('HighAcc', false);

    -- varhelper.CreateToggle('DualWield', true);
    varhelper.CreateCycle('WeaponMain', {
        [1] = 'LanunRoll',
        [2] = 'Tauret',
        [3] = 'Daduchos',
        [4] = 'Naegling',
    });
    varhelper.CreateCycle('WeaponSub', {
        [1] = 'Naegling',
        [2] = 'Tauret',
        [3] = 'LanunRoll',
        [4] = 'Daduchos',
        [5] = 'Nusku'
    });

    varhelper.CreateToggle('EXPcape', false);

    AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^F1 /lac fwd DT');
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^NUMPAD0 /lac fwd TH');
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^NUMPAD1 /lac fwd EXPcape');
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^!NUMPAD1 /lac fwd WeaponMain');
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^!NUMPAD2 /lac fwd WeaponSub');
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^!NUMPAD0 /lac fwd HighAcc');
end

profile.OnUnload = function()
    varhelper.Destroy();
    expwarp.Destroy();
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^F1');
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^NUMPAD0');
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^NUMPAD1');
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^!NUMPAD2');
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^!NUMPAD1');
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^!NUMPAD0');
end

profile.HandleCommand = function(args)
    local player = gData.GetPlayer();

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
    elseif (args[1] == 'HighAcc') then
        varhelper.AdvanceToggle('HighAcc');
    elseif (args[1] == 'EXPcape') then
        varhelper.AdvanceToggle('EXPcape');
    elseif (args[1] == 'WeaponMain') then
        varhelper.AdvanceCycle('WeaponMain');
        if (varhelper.GetCycle('WeaponMain') == varhelper.GetCycle('WeaponSub')) then
            varhelper.AdvanceCycle('WeaponMain');
        end
    elseif (args[1] == 'WeaponSub') then

        if(player.SubJob == 'NIN' or player.SubJob == 'DNC') then
            varhelper.AdvanceCycle('WeaponSub');
        else
            varhelper.SetCycle('WeaponSub', 5);
        end
        if (varhelper.GetCycle('WeaponMain') == varhelper.GetCycle('WeaponSub')) then
            varhelper.AdvanceCycle('WeaponSub');
        end
    end
end

profile.HandleDefault = function()
    local player = gData.GetPlayer();

    gFunc.EquipSet(sets.Idle);
    gFunc.Equip('Main', weapons[varhelper.GetCycle('WeaponMain')]);
    if(player.SubJob == 'NIN' or player.SubJob == 'DNC') then
        gFunc.Equip('Sub', weapons[varhelper.GetCycle('WeaponSub')]);
    else
        varhelper.SetCycle('WeaponSub', 5);
        gFunc.Equip('Sub', weapons[varhelper.GetCycle('WeaponSub')]);
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

    if(IsInTown()) then

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

    if (action.Name:contains('Roll')) then
        gFunc.EquipSet(sets.Roll);
        if(action.Name:contains('Blitzer')) then
            gFunc.Equip('Head', jse.Empy.Head);
        elseif(action.Name:contains('Tactician')) then
            gFunc.Equip('Body', jse.Empy.Body);
        elseif(action.Name:contains('Allies')) then
            gFunc.Equip('Hands', jse.Empy.Hands);
        elseif(action.Name:contains('Caster')) then
            gFunc.Equip('Legs', jse.Empy.Legs);
        elseif(action.Name:contains('Courser')) then
            gFunc.Equip('Feet', jse.Empy.Feet);
        end
    end

    -- if (action.Name == 'Fold') then
    --     gFunc.Equip('Hands', jse.Relic.Hands);
    -- end
    if (action.Name == 'Snake Eye') then
        gFunc.Equip('Legs', jse.Relic.Legs);
    end
    if (action.Name == 'Wild Card') then
        gFunc.Equip('Feet', jse.Relic.Feet);
    end

    if (action.Name:contains('Shot') and not action.Name:contains('Triple')) then
        gFunc.EquipSet(sets.qdraw);
    end
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
end

profile.HandleMidcast = function()
end

profile.HandlePreshot = function()
    gFunc.EquipSet(sets.preshot);
end

profile.HandleMidshot = function()
    local action = gData.GetAction()

    if(varhelper.GetToggle("HighAcc") == true) then
        gFunc.EquipSet(sets.AccMidshot);
    else
        gFunc.EquipSet(sets.midshot);
    end

    if (action.ActionType == "Ranged" and gData.GetBuffCount('Triple Shot') > 0 and varhelper.GetToggle("HighAcc") == false) then
        gFunc.EquipSet(sets.tripleShot);
    end
end

profile.HandleWeaponskill = function()
    local action = gData.GetAction();
    local val = actions[action.Name];

    if not val then gFunc.EquipSet(sets.DefaultWeaponskill) else gFunc.EquipSet(val) end
    if(val == 'Last Stand' and varhelper.GetToggle("HighAcc") == true) then
        gFunc.EquipSet(sets.AccMidshot);
    end
    CheckCape();
end

return profile;