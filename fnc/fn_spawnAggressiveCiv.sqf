/*
Author: joko // Jonas


Description: spawns Aggressive Civilan

             returns nothing
__________________________________________________________________*/
private ["_grp", "_targets", "_targetPlayer"];
params ["_unit", "_range"];
_grp = [[_unit]] call SEN_fnc_setSide;
_unit = leader _grp;
_unit forceSpeed (_unit getSpeed "FAST");
_unit allowfleeing 0;
_targets = [(getPosATL _unit),_range] call SEN_fnc_getNearPlayers;

if (count _targets isEqualTo 0) exitWith {[1,"No players near Aggressive Civilian."] call SEN_fnc_log};

_targetPlayer = _targets call BIS_fnc_selectRandom;

{
    _unit reveal _x;
    nil
} count _targets;

[0,"Aggressive Civilian target is %1.",name _targetPlayer] call SEN_fnc_log;

_unit addVest "V_TacVestIR_blk";
_unit addWeapon "srifle_DMR_06_olive_F";
_unit addMagazine ["20Rnd_762x51_Mag", 5];

[_unit, _targetPlayer, _grp] spawn {
    params ["_unit", "_targetPlayer", "_grp"];
    _wp = _grp addWaypoint [getPos _targetPlayer, 10, 1, "Kill"];
    while {alive _unit} do {
        if (_targetPlayer getVariable ["ACE_isUnconscious", false] || alive _targetPlayer) then {
            _targets = [(getPosATL _unit),_range] call SEN_fnc_getNearPlayers;
            _targetPlayer = _targets call BIS_fnc_selectRandom;
        };
        _wp setWaypointPosition [getPos _targetPlayer, 10];
        sleep 60;
    };
};
