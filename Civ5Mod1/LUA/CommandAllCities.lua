-- CommandAllCities
-- Author: LambFerret
-- DateCreated: 11/22/2022 3:57:47 PM
--------------------------------------------------------------

--==--==--==--==--==--==pre setting--==--==--==--==--==--==--==
local buildingsInfo = {};
for row in GameInfo.Buildings() do
   buildingsInfo[row.ID] = row.Description
end
ContextPtr:SetHide(true);

--==--==--==--==--==--==--debug-==--==--==--==--==--==--==--==
local DebugEnabled = true;
local DebugPrint = nil;

if (DebugEnabled) then
   DebugPrint = function(name, string)
      print("-------" .. name .. "--------")
      print(dump(string))
      print("-------------------")
   end;
else
   DebugPrint = function(name, string) end;
end
function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k, v in pairs(o) do
         if type(k) ~= 'number' then k = '"' .. k .. '"' end
         s = s .. '[' .. k .. '] = ' .. dump(v) .. ',' .. "\n"
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==


function gatherListofBuildings(iPlayer)
   local canConstructMap = {};
   if (iPlayer ~= 0) then return end
   for city in Players[iPlayer]:Cities() do
      for buildingID, v in pairs(buildingsInfo) do
         if (city:CanConstruct(buildingID)) then
            canConstructMap[buildingID] = v
         end
      end
   end
   DebugPrint("cac", canConstructMap)
   return canConstructMap;
end

GameEvents.PlayerDoTurn.Add(gatherListofBuildings)


--==--==--==--==--==--==--==Open Window--==--==--==--==--==--==--==--==--==
function OpenDialog().
	ContextPtr:SetHide(false);
	MapModData.QuickTurns.DialogOpen = true;
end
--==--==--==--==--==--==--==Close Window--==--==--==--==-==--==--==--==--==
function CloseDialog()
	ContextPtr:SetHide(true);
	MapModData.QuickTurns.DialogOpen = false;
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==