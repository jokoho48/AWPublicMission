/*
loadout script by joko
adds the loadouts to the specific playable units for the side West
Call from initPlayerLocal.sqf via:
[Object] call JK_loadOut_fnc_loadoutsInit;
*/

///// No editing necessary below this line /////
params [["_target", player, [objNull]]];
[SEN_arsenal] call JK_loadOut_fnc_chooseLoadout;
AW_arsenal call AW_loadOut_fnc_chooseFaction;
call JK_loadOut_fnc_reset;
private _db = 6;
["Loadouts:rifleman", _target, "JK_loadOut_fnc_selectGear", true, _db] remoteExecCall ["db_fnc_codeload", 2, false];
