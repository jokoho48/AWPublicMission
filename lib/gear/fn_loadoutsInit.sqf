/*
loadout script by joko
Idea by Belbo
adds the loadouts to the specific playable units for the side West
Call from initPlayerLocal.sqf via:
[Object] call JK_loadOut_fnc_loadoutsInit;
*/

///// No editing necessary below this line /////

params [["_target", player, [objNull]]];
_command = ["plt_sgt"];
_TL = ["b1_ftl", "b2_ftl", "a1_ftl", "a2_ftl"];
_SL = ["a_sl", "b_sl"];
_crew = ["rh1_driver", "rh1_co", "rh1_gunner"];
_pilots = ["r_1", "r_2", "r_3", "r_4"];

[SEN_arsenal] call JK_loadOut_fnc_chooseLoadout;

_strTarget = str _target;
if (_strTarget in _command) exitWith {
    [_target, "AR_Command"] call JK_loadOut_fnc_selectGear;
};
if (_strTarget in _TL) exitWith {
    [_target, "AR_FTL"] call JK_loadOut_fnc_selectGear;
};
if (_strTarget in _SL) exitWith {
    [_target, "AR_Leader"] call JK_loadOut_fnc_selectGear;
};
if (_strTarget in _crew) exitWith {
    [_target, "Crew"] call JK_loadOut_fnc_selectGear;
};
if (_strTarget in _pilots) exitWith {
    [_target, "Pilot"] call JK_loadOut_fnc_selectGear;
};
