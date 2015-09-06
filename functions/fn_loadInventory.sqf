/*
Author: Quiksilver
Date modified: 12/10/2014 ArmA 1.30
*/

if (!(respawnInventory_Saved)) exitWith {hint "No gear saved for quick-loading!";};
if (loading_inventory) exitWith {hint "Loading gear, please wait ...";};
loading_inventory = true;
hint "Gear loaded";
[player,[player,"ClassGear"]] call BIS_fnc_loadInventory;
[{
    inventory_cleared = false;
}, 300, []] call ace_common_fnc_waitAndExecute;
