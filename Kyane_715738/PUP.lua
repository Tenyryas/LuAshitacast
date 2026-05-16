local profile = {};

local varhelper = gFunc.LoadFile('common/varhelper.lua');
local expwarp = gFunc.LoadFile('common/expwarphelper.lua');
local common = gFunc.LoadFile('common/commonfunc.lua');

local macros = require 'ffxi.macros';

local capes = {
    ['Pet'] = 'Visucius\'s Mantle',
    ['EXP'] = { Name = 'Mecisto. Mantle', Augment = { [1] = 'Cap. Point+37%', [2] = 'CHR+1', [3] = 'DEF+1', [4] = 'Mag. Acc.+3' } },
}

local jse = {
    ['AF'] = { Head = '', Body = '', Hands = 'Pup. Dastanas +1', Legs = '', Feet = 'Foire Bab. +1' },
    ['Relic'] = { Head = 'Pitre Taj', Body = 'Pitre Tobe +1', Hands = 'Pitre Dastanas', Legs = 'Pitre Churidars', Feet = 'Pitre Babouches' },
    ['Empy'] = { Head = 'Karagoz Cappello', Body = 'Karagoz Farsetto', Hands = 'Karagoz Guanti', Legs = 'Cirque Pantaloni +1', Feet = 'Cirque Scarpe +1'}
}

local sets = {
    ['Idle'] = {
        Range = 'Animator P',
        Ammo = 'Automat. Oil +3',
        Head = 'Tali\'ah Turban +2',
        Neck = 'Sanctity Necklace',
        Ear1 = 'Handler\'s Earring',
        Ear2 = 'Mache Earring',
        Body = 'Malignance Tabard',
        Hands = { Name = 'Taeon Gloves', Augment = { [1] = 'Pet: Rng. Acc.+20', [2] = 'Pet: Damage taken -4%', [3] = 'Pet: Accuracy+20', [4] = 'Pet: "Dbl. Atk."+5' } },
        Ring1 = 'Varar Ring',
        Ring2 = 'Petrov Ring',
        Back = { Name = 'Visucius\'s Mantle', Augment = { [1] = 'Pet: R.Acc.+20', [2] = 'Pet: R.Atk.+20', [3] = 'Pet: Haste+10', [4] = 'Accuracy+20', [5] = 'Attack+20', [6] = 'Pet: Acc.+20', [7] = 'Pet: Atk.+20' } },
        Waist = 'Incarnation Sash',
        Legs = 'Tali\'ah Sera. +2',
        Feet = 'Tali\'ah Crackows +2',
    },
    ['PDT'] = {
        Range = 'Animator P',
        Ammo = 'Automat. Oil +3',
        Head = 'Tali\'ah Turban +2',
        Neck = 'Sanctity Necklace',
        Ear1 = 'Handler\'s Earring',
        Ear2 = 'Mache Earring',
        Body = 'Malignance Tabard',
        Hands = { Name = 'Taeon Gloves', Augment = { [1] = 'Pet: Rng. Acc.+20', [2] = 'Pet: Damage taken -4%', [3] = 'Pet: Accuracy+20', [4] = 'Pet: "Dbl. Atk."+5' } },
        Ring1 = 'Varar Ring',
        Ring2 = 'Petrov Ring',
        Back = { Name = 'Visucius\'s Mantle', Augment = { [1] = 'Pet: R.Acc.+20', [2] = 'Pet: R.Atk.+20', [3] = 'Pet: Haste+10', [4] = 'Accuracy+20', [5] = 'Attack+20', [6] = 'Pet: Acc.+20', [7] = 'Pet: Atk.+20' } },
        Waist = 'Incarnation Sash',
        Legs = 'Tali\'ah Sera. +2',
        Feet = 'Tali\'ah Crackows +2',
    },
    ['TP'] = {
    },
    ['DefaultWeaponskill'] = {
    },
    ['Overdrive'] = {-- this set will force on the ability AND stay on for the duration of OD, don't change the body out because of that
        Range = 'Animator P',
        Ammo = 'Automat. Oil +3',
        Head = jse.Empy.Head,
        -- Neck = 'Shulmanu Collar',
        -- Ear1 = 'Enmerkar Earring',
        -- Ear2 = 'Domes. Earring',
        Body = jse.Relic.Body,
        Hands = jse.Empy.Hands,
        Ring1 = 'Varar Ring',
        -- Ring2 = 'C. Palug Ring',
        Back = capes.Pet,
        Waist = 'Incarnation Sash',
        Legs = 'Heyoka Subligar',
        Feet = 'Heyoka Leggings',
    },
    ['PetDT'] = {
        Range = 'Animator P',
        Ammo = 'Automat. Oil +3',
        Head = { Name = 'Anwig Salade', Augment = { [1] = 'Pet: "Regen"+1', [2] = 'Attack+6', [3] = 'Pet: Damage taken -10%' } },
        Neck = 'Twilight Torque',
        Ear1 = 'Handler\'s Earring',
        Ear2 = 'Hypaspist Earring',
        Body = { Name = 'Taeon Tabard', Augment = { [1] = 'Pet: Rng. Acc.+24', [2] = 'Pet: Damage taken -4%', [3] = 'Pet: Accuracy+24', [4] = 'Pet: "Dbl. Atk."+5' } },
        Hands = { Name = 'Taeon Gloves', Augment = { [1] = 'Pet: Rng. Acc.+20', [2] = 'Pet: Damage taken -4%', [3] = 'Pet: Accuracy+20', [4] = 'Pet: "Dbl. Atk."+5' } },
        Ring1 = 'Varar Ring',
        Ring2 = 'Petrov Ring',
        Back = capes.Pet,
        Waist = 'Incarnation Sash',
        Legs = 'Tali\'ah Sera. +2',
        Feet = { Name = 'Taeon Boots', Augment = { [1] = 'Pet: Rng. Acc.+25', [2] = 'Pet: Damage taken -4%', [3] = 'Pet: Accuracy+25', [4] = 'Pet: "Dbl. Atk."+5' } },
    },
    ['Repair'] = {
        Range = 'Animator P',
        Ammo = 'Automat. Oil +3',
        Feet = jse.AF.Feet,
    },
    ['Maneuver'] = {
        Body = jse.Empy.Body,
        Hands = jse.AF.Hands,
        Back = capes.Pet,
	},
};

profile.Sets = sets;

profile.Packer = {
    'Automat. Oil +3',
};


profile.OnLoad = function()
    gSettings.AllowAddSet = true;

    varhelper.Initialize();

    varhelper.CreateCycle('DT', {
        [1] = 'Off',
        [2] = 'PDT',
    });

    varhelper.CreateCycle('PUPMode', {
        [1] = 'Master',
        [2] = 'Puppet',
        [3] = 'Hybrid'
    });

    expwarp.Initialize(varhelper);

    AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^F1 /lac fwd DT');
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^NUMPAD1 /lac fwd PUPMode');
end

profile.OnUnload = function()
    varhelper.Destroy();
    expwarp.Destroy();
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^F1');
end

profile.HandleCommand = function(args)
    if (args[1] == 'DT') then
        varhelper.AdvanceCycle('DT');
    elseif (args[1] == 'PUPMode') then
        varhelper.AdvanceCycle('PUPMode');
    elseif (args[1] == expwarp.WarpCycle) then
        varhelper.AdvanceCycle(expwarp.WarpCycle);
    elseif (args[1] == expwarp.ExpCycle) then
        varhelper.AdvanceCycle(expwarp.ExpCycle);
    elseif (args[1] == expwarp.WarpReset) then
        varhelper.ResetCycle(expwarp.WarpCycle);
    end

end

profile.HandleDefault = function()
    local player = gData.GetPlayer();
    local puppet = gData.GetPet();
    local equip = gData.GetEquipment();
    local OD = gData.GetBuffCount('Overdrive');

    if (player.SubJob == ("WAR")) then
        macros.set_book(1);
    end

    if (player.Status == 'Engaged' and varhelper.GetCycle('PUPMode') == 'Master') then
        if (varhelper.GetCycle('DT') == 'PDT') then
            gFunc.EquipSet(sets.PDT);
        else
            gFunc.EquipSet(sets.TP);
        end
    elseif (varhelper.GetCycle('PUPMode') == 'Puppet') then
        if (varhelper.GetCycle('DT') == 'PDT') then
            gFunc.EquipSet(sets.PetDT);
        else
            gFunc.EquipSet(sets.TP);
        end
    elseif (varhelper.GetCycle('PUPMode') == 'Hybrid') then
        if (varhelper.GetCycle('DT') == 'PDT') then
            gFunc.EquipSet(sets.PDT);
        else
            gFunc.EquipSet(sets.TP);
        end
    elseif (player.Status == 'Resting') then
        gFunc.EquipSet(sets.PDT);
    else
        if (varhelper.GetCycle('DT') == 'PDT') then
            gFunc.EquipSet(sets.PDT);
        else
            gFunc.EquipSet(sets.Idle);
        end
    end


    -- Warp items
    expwarp.Cycle(expwarp.Warp, varhelper);

    -- EXP rings
    expwarp.Cycle(expwarp.Exp, varhelper);


    if (OD > 0) then
        gFunc.EquipSet(sets.Overdrive)
    end

    Schneddick();
    CheckCape();
    varhelper.Update();
end

profile.HandleAbility = function()
	local ability = gData.GetAction();
	if (string.match(ability.Name, 'Repair')) or (string.match(ability.Name, 'Maintenance')) then
		gFunc.EquipSet(sets.Repair);
    elseif (string.contains(ability.Name, 'Maneuver')) then
        gFunc.EquipSet(sets.Maneuver);
    elseif (string.match(ability.Name, 'Overdrive')) then
        gFunc.EquipSet(sets.Overdrive);
	end

    CheckCape();
end

profile.HandleItem = function()
    CheckCape();
end

profile.HandlePrecast = function()
    -- gFunc.EquipSet(sets.FC);
end

profile.HandleMidcast = function()
    local action = gData.GetAction();

    CheckCape();
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
    CheckCape();
end

profile.HandleWeaponskill = function()
    local action = gData.GetAction();
    
    if (action.Name == 'Savage Blade') then
        -- gFunc.EquipSet(sets.FotiaWS);
    else
        gFunc.EquipSet(sets.DefaultWeaponskill);
    end
    CheckCape();
end

return profile;