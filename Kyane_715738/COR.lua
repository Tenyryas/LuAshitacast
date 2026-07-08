local profile = {};

local varhelper = gFunc.LoadFile('common/varhelper.lua');
local expwarp = gFunc.LoadFile('common/expwarphelper.lua');
local common = gFunc.LoadFile('common/commonfunc.lua');

local macros = require 'ffxi.macros';

local capes = {
    ['EXP'] = { Name = 'Mecisto. Mantle', Augment = { [1] = 'Cap. Point+37%', [2] = 'CHR+1', [3] = 'DEF+1', [4] = 'Mag. Acc.+3' } },
}

local jse = T{
    AF = { 
        Head = 'Laksa. Tricorne +1', 
        Body = 'Laksa. Frac +4', 
        Hands = '', 
        Legs = 'Laksa. Trews +3', 
        Feet = '' },
    Relic = { 
        Head = 'Lanun Tricorne +2', 
        Body = 'Lanun Frac +3', 
        Hands = 'Lanun Gants +2', 
        Legs = 'Lanun Trews +2', 
        Feet = 'Lanun Bottes +2' },
    Empy = { 
        Head = 'Chass. Tricorne +2', 
        Body = 'Chasseur\'s Frac +2', 
        Hands = 'Chasseur\'s Gants +2', 
        Legs = 'Chas. Culottes +2', 
        Feet = 'Chass. Bottes +2'}
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
        Back = { Name = 'Camulus\'s Mantle', Augment = '"Snapshot"+10' },
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
        Back = { Name = 'Camulus\'s Mantle', Augment = '"Snapshot"+10' },
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
        Back = { Name = 'Camulus\'s Mantle', Augment = '"Snapshot"+10' },
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
        -- Range = 'Compensator',
        Head =  jse.Relic.Head,
        Ring1 = 'Barataria Ring',
        Ring2 = "Luzaf's Ring",
    },
    LeadenSalute = {
        Head = 'Nyame Helm',
        Neck = 'Commodore Charm +2',
        Ear1 = 'Moonshade Earring',
        Ear2 = 'Friomisi Earring',
        Body = jse.Relic.Body,
        Hands = 'Nyame Gauntlets',
        Ring1 = "Archon Ring",
        Ring2 = 'Dingir Ring',
        Back = 'Gunslinger\'s Cape',
        Waist = 'Eschan Stone',
        Legs = 'Nyame Flanchard',
        Feet = jse.Relic.Feet,
    },
    HotShot = {
        Head = 'Nyame Helm',
        Neck = 'Commodore Charm +2',
        Ear1 = 'Moonshade Earring',
        Ear2 = 'Friomisi Earring',
        Body = jse.AF.Body,
        Hands = jse.Empy.Hands,
        Ring1 = "Archon Ring",
        Ring2 = 'Dingir Ring',
        Back = 'Gunslinger\'s Cape',
        Waist = 'Fotia Belt',
        Legs = 'Nyame Flanchard',
        Feet = jse.Relic.Feet,
    },
    Wildfire = {
        Head = 'Nyame Helm',
        Neck = 'Commodore Charm +2',
        Ear1 = 'Moonshade Earring',
        Ear2 = 'Hecate\'s Earring',
        Body = jse.Relic.Body,
        Hands = jse.Empy.Hands,
        Ring1 = "Archon Ring",
        Ring2 = 'Dingir Ring',
        Back = 'Gunslinger\'s Cape',
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
        Hands = 'Meg. Gloves +2',
        Ring1 = "Regal Ring",
        Ring2 = 'Dingir Ring',
        Back = 'Gunslinger\'s Cape',
        Waist = 'Fotia Belt',
        Legs = 'Nyame Flanchard',
        Feet = jse.Relic.Feet,
    },
    Aeolian = {
        Head = 'Nyame Helm',
        Neck = 'Sanctity Necklace',
        Ear1 = { Name = 'Moonshade Earring', Augment = { [1] = 'TP Bonus +250', [2] = '"Mag. Atk. Bns."+4' } },
        Ear2 = 'Friomisi Earring',
        Body = jse.Relic.Body,
        Ring1 = 'Regal Ring',
        Ring2 = 'Petrov Ring',
        Back = { Name = 'Camulus\'s Mantle', Augment = '"Snapshot"+10' },
        Waist = 'Eschan Stone',
        Legs = jse.AF.Legs,
        Feet = jse.Empy.Feet,
    },
    preshot = {
        Head = jse.Empy.Head,
        Neck = 'Commodore Charm +2',
        Ear1 = { Name = 'Alabaster Earring', AugPath='A' },
        Ear2 = 'Enervating Earring',
        Body = jse.AF.Body,
        -- Body = 'Oshosi Vest',
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
        Neck = 'Commodore Charm',
        Ear1 = { Name = 'Alabaster Earring', AugPath='A' },
        Ear2 = 'Enervating Earring',
        Body = jse.Empy.Body,
        Hands = jse.Empy.Hands,
        Ring1 = 'Regal Ring',
        Ring2 = 'Dingir Ring',
        Back = { Name = 'Gunslinger\'s Cape', Augment = { [1] = '"Mag. Atk. Bns."+4', [2] = 'Enmity-2' } },
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
        Back = { Name = 'Gunslinger\'s Cape', Augment = { [1] = '"Mag. Atk. Bns."+4', [2] = 'Enmity-2' } },
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
        Hands = 'Meg. Gloves +2',
        Ring1 = 'Regal Ring',
        Ring2 = 'Etana Ring',
        Back = 'Camulus\'s mantle',
        Waist = 'Sailfi Belt +1',
        Legs = 'Meg. Chausses +2',
        Feet = jse.AF.Feet,
    },
    tripleShot = {
        Body = jse.Empy.Body,
        -- Hands = jse.Relic.Hands,
        -- Legs = 'Oshosi Trousers',
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

    varhelper.CreateCycle('FPS', {
        [1] = '30',
        [2] = '60',
    });

    varhelper.CreateToggle('EXPcape', false);

    AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^F1 /lac fwd DT');
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^NUMPAD0 /lac fwd TH');
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^NUMPAD1 /lac fwd EXPcape');
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^NUMPAD2 /lac fwd FPS');
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

    gFunc.EquipSet(sets.Idle);
    
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

    if (action.Name == 'Fold') then
        gFunc.Equip('Hands', jse.Relic.Hands);
    end
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
    local action = gData.GetAction();
    gFunc.EquipSet(sets.midshot);


    if (action.ActionType == "Ranged" and gData.GetBuffCount('Triple Shot') > 0) then
        gFunc.EquipSet(sets.tripleShot);
    end
end

profile.HandleWeaponskill = function()
    local action = gData.GetAction();
    local val = actions[action.Name];

    if not val then gFunc.EquipSet(sets.DefaultWeaponskill) else gFunc.EquipSet(val) end
    CheckCape();
end

return profile;