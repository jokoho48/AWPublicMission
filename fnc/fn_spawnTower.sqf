/*
Author: SENSEI

Last modified: 11/28/2014

Description: spawns tower

			 returns group
__________________________________________________________________*/
private ["_pos","_range","_count","_side","_unitArray","_posArray","_type","_grp","_tower","_unit"];

_pos = param [0,[0,0,0],[[]]];
_range = param [1,100,[0]];
_count = param [2,1,[0]];
_side = param [3,SEN_enemySide];

_unitArray  = [];
_posArray = [];

call {
	if (_side isEqualTo WEST) exitWith {_type = SEN_unitPoolWest select (random ((count SEN_unitPoolWest) - 1));};
	if (_side isEqualTo CIVILIAN) exitWith {_type = SEN_unitPoolCiv select (random ((count SEN_unitPoolCiv) - 1));};
	_type = SEN_unitPool select (random ((count SEN_unitPool) - 1));
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
