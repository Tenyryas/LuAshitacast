CheckCape = function (cape)
    local target = gData.GetTarget();
    if (target ~= nil) and (target.HPP <= 5) then
        gFunc.Equip("Back", cape);
    end
end

Schneddick = function ()
    local player = gData.GetPlayer();
    if (player.Status ~= "Engaged" and player.IsMoving) then
        gFunc.Equip("Ring2", "Shneddick Ring");
    end
end

function isTwoHanded(itemName)

    if(itemName) == nil then return end

    if (type(itemName) == 'table') then
        itemName = item.Name;
    end
    local item = AshitaCore:GetResourceManager():GetItemByName(itemName, 0);
    if (not item) then
        return false;
    end

    local weapontypes = {
        -- H2H = 1;
        -- Dagger = 2;
        -- Sword = 3;
        GSword = 4;
        -- Axe = 5;
        GAxe = 6;
        Scythe = 7;
        Polearm = 8;
        -- Katana = 9;
        GKatana = 10;
        -- Club = 11;
        Staff = 12;
    }

    for key, value in pairs(weapontypes) do
        if value == item.Skill then
            return true;
        end
    end

    return false;
end