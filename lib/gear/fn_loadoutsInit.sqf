/*
loadout script by joko
adds the loadouts to the specific playable units for the side West
Call from initPlayerLocal.sqf via:
[Object] call JK_loadOut_fnc_loadoutsInit;
*/

///// No editing necessary below this line /////
params [["_target", player, [objNull]]];
[SEN_arsenal] call JK_loadOut_fnc_chooseLoadout;

private _db = 1;
["Loadouts:AR_RIFLEMAN", _target, "JK_loadOut_fnc_selectGear", true, _db] remoteExec ["db_fnc_codeload", 2, false];
