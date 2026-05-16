local Cycles = {};
local Toggles = {};
local Def = 0;
local Attk = 0;
local MainLV = 0;
local SubLV = 0;
local mastered = false;
local Main = 'FOO';
local Sub = 'BAR';

local varhelper = {
	Toggles = {},
	Values = {}
};

local fontSettings = T{
	visible = true,
	font_family = 'Bembo',
	font_height = 12,
	color = 0xFFFFFFFF,
	position_x = 130,
	position_y = 0,
	background = T{
		visible = true,
		color = 0x6000022F,
	}
};

local fonts = require('fonts');

varhelper.AdvanceCycle = function(name)
	local ctable = Cycles[name];
	if (type(ctable) ~= 'table') then
		return;
	end
	
	ctable.Index = ctable.Index + 1;
	if (ctable.Index > #ctable.Array) then
		ctable.Index = 1;
	end
end

varhelper.ResetCycle = function(name)
	local ctable = Cycles[name];
	if (type(ctable) ~= 'table') then
		return;
	end
	
	ctable.Index = 1;
end

varhelper.AdvanceToggle = function(name)
	if (type(Toggles[name]) ~= 'boolean') then
		return;
	elseif Toggles[name] then
		Toggles[name] = false;
	else
		Toggles[name] = true;
	end
end

--name must be a valid lua variable name in string format.
--default must be a boolean
varhelper.CreateToggle = function(name, default)
	Toggles[name] = default;
end

--name must be a valid lua variable name in string format.
--values must be an array style table containing only strings mapped to sequential indices.
--first value in table will be default.
varhelper.CreateCycle = function(name, values)
	local newCycle = {
		Index = 1,
		Array = values
	};
	Cycles[name] = newCycle;
end

varhelper.GetCycle = function(name)
	local ctable = Cycles[name];
	if (type(ctable) == 'table') then
		return ctable.Array[ctable.Index];
	else
		return 'Unknown';
	end
end

varhelper.GetToggle = function(name)
	if (Toggles[name] ~= nil) then
		return Toggles[name];
	else
		return false;
	end
end

varhelper.Update = function()

	local player = AshitaCore:GetMemoryManager():GetPlayer();
	
	local MID = player:GetMainJob();
	local SID = player:GetSubJob();
	Def = player:GetDefense();
	Attk = player:GetAttack();
    mastered = player:GetJobPointsSpent(MID) == 2100;

    if(mastered and player:GetMainJobLevel() == 99) then
        if(player:GetMasteryJobLevel() < 10) then
            MainLV = "|cfff1c232|0" .. player:GetMasteryJobLevel() .. "|r";
        else
            MainLV = "|cfff1c232|" .. player:GetMasteryJobLevel() .. "|r";
        end
    else
	    MainLV = player:GetMainJobLevel();
    end

	SubLV = player:GetSubJobLevel();
	Main = AshitaCore:GetResourceManager():GetString("jobs.names_abbr", MID);
	Sub = AshitaCore:GetResourceManager():GetString("jobs.names_abbr", SID);
	
end

varhelper.Destroy = function()
	if (varhelper.FontObject ~= nil) then
		varhelper.FontObject:destroy();
	end
	ashita.events.unregister('d3d_present', 'varhelper_present_cb');
end

varhelper.Initialize = function()
    varhelper.Update();
	varhelper.FontObject = fonts.new(fontSettings);	
	ashita.events.register('d3d_present', 'varhelper_present_cb', function ()
        local outText = MainLV .. Main .. '/' .. SubLV .. Sub ..'   Attk: ' .. Attk .. '   Def: ' .. Def ..' | ' ;
		for key, value in pairs(Toggles) do
			outText = outText .. key .. ': ';
			if (value == true) then
				outText = outText .. '|cFF00FF00|Yes|r ';
			else
				outText = outText .. '|cFFFF0000|No|r ';
			end
		end
		for key, value in pairs(Cycles) do

            if(value.Array[value.Index] == "Off") then
			    outText = outText .. key .. ': ' .. '|cFFFF0000|' .. value.Array[value.Index] .. '|r ';
            else
			    outText = outText .. key .. ': ' .. '|cFF00FF00|' .. value.Array[value.Index] .. '|r ';
            end
		end
		varhelper.FontObject.text = outText;
	end);
end

return varhelper;