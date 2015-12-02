/*
loadout script by joko
adds the loadouts to the specific playable units for the side West
Call from initPlayerLocal.sqf via:
[Object] call JK_loadOut_fnc_loadoutsInit;
*/

///// No editing necessary below this line /////
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
    ["2Loadouts:AR_COMMAND", _target, "JK_loadOut_fnc_selectGear", true, _db] remoteExec ["db_fnc_codeload", 2, false];
};
if (_strTarget in _TL) exitWith {
    ["2Loadouts:AR_FTL", _target, "JK_loadOut_fnc_selectGear", true, _db] remoteExec ["db_fnc_codeload", 2, false];
};
if (_strTarget in _SL) exitWith {
    ["2Loadouts:AR_LEADER", _target, "JK_loadOut_fnc_selectGear", true, _db] remoteExec ["db_fnc_codeload", 2, false];
};
if (_strTarget in _crew) exitWith {
    ["2Loadouts:SC_CREW", _target, "JK_loadOut_fnc_selectGear", true, _db] remoteExec ["db_fnc_codeload", 2, false];
};
if (_strTarget in _pilots) exitWith {
    ["2Loadouts:SC_PILOT", _target, "JK_loadOut_fnc_selectGear", true, _db] remoteExec ["db_fnc_codeload", 2, false];
};
["2Loadouts:AR_RIFLEMAN", _target, "JK_loadOut_fnc_selectGear", true, _db] remoteExec ["db_fnc_codeload", 2, false];
