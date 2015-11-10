/*
loadout script by joko
Idea by Belbo
adds the loadouts to the specific playable units for the side West
Call from initPlayerLocal.sqf via:
[Object] call JK_loadOut_fnc_loadoutsInit;
*/

///// No editing necessary below this line /////
if (isNil "db_fnc_codeload") exitWith {};
params [["_target", player, [objNull]]];
_command = ["plt_sgt", "plt_co"];
_TL = ["b1_ftl", "b2_ftl", "a1_ftl", "a2_ftl"];
_SL = ["a_sl", "b_sl"];
_crew = ["rh1_driver", "rh1_co", "rh1_gunner"];
_pilots = ["r_1", "r_2", "r_3", "r_4"];

[SEN_arsenal] call JK_loadOut_fnc_chooseLoadout;


_db = 1;
_strTarget = str _target;
if (_strTarget in _command) exitWith {
    ["AR_COMMAND", _target, "JK_loadOut_fnc_selectGear", true, _db] remoteExec ["db_fnc_codeload", 2, false];
};
if (_strTarget in _TL) exitWith {
    ["AR_FTL", _target, "JK_loadOut_fnc_selectGear", true, _db] remoteExec ["db_fnc_codeload", 2, false];
};
if (_strTarget in _SL) exitWith {
    ["AR_LEADER", _target, "JK_loadOut_fnc_selectGear", true, _db] remoteExec ["db_fnc_codeload", 2, false];
};
if (_strTarget in _crew) exitWith {
    ["CREW", _target, "JK_loadOut_fnc_selectGear", true, _db] remoteExec ["db_fnc_codeload", 2, false];
};
if (_strTarget in _pilots) exitWith {
    ["PILOT", _target, "JK_loadOut_fnc_selectGear", true, _db] remoteExec ["db_fnc_codeload", 2, false];
};
["AR_RIFLEMAN", _target, "JK_loadOut_fnc_selectGear", true, _db] remoteExec ["db_fnc_codeload", 2, false];
