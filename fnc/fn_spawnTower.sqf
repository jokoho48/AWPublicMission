/*
Author: SENSEI

Last modified: 11/28/2014

Description: spawns tower

             returns group
__________________________________________________________________*/
private ["_unitArray","_posArray","_type","_grp","_tower","_unit"];
params [["_pos", [0,0,0], [[]]], ["_range", 100, [0]], ["_count", 1, [0]], ["_side", SEN_enemySide]];

_unitArray  = [];
_posArray = [];

_type = call {
    if (_side isEqualTo WEST) exitWith {SEN_unitPoolWest call BIS_fnc_selectRandom};
    if (_side isEqualTo CIVILIAN) exitWith {SEN_unitPoolCiv call BIS_fnc_selectRandom};
     SEN_unitPool call BIS_fnc_selectRandom
};

_posArray = [_pos,_range,(_range*0.3),_count] call SEN_fnc_findPosArray;

if !(count _posArray isEqualTo 0) then {
    _grp = createGroup _side;
    _grp allowfleeing 0;
    _grp setVariable ["zbe_cacheDisabled", true, true];
    {
        _tower = "Land_Cargo_Patrol_V1_F" createVehicle [0,0,0];
        _tower setdir random 360;
        _tower setPosATL _x;
        _tower setvectorup [0,0,1];
        _unit = _grp createUnit [_type, [0,0,0], [], 0, "NONE"];
        _unit setFormDir (getDir _tower);
        _unit setDir (getDir _tower);
        _unit setpos (_tower buildingpos 1);
        _unit setUnitPos "UP";
        _unit setskill ["spotDistance",0.90];
        _unit disableAI "MOVE";
        _unitArray pushBack _unit;
     } forEach _posArray;

    _grp
} else {
    grpNull
};
