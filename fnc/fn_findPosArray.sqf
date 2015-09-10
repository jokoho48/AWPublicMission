/*
Author: SENSEI

Last modified: 11/28/2014

Description: finds array of positions that are a minimum distance away from eachother
			 if the specified amount of positions are not found within a certain number of iterations, an empty array is returned

			 NOTE: this function works best in low density areas

			 returns position or object
__________________________________________________________________*/
private ["_center","_range","_minDist","_count","_ifRoad","_posArray","_counter","_check","_roads","_pos","_isEmpty","_posBuffer"];

_center = param [0,[],[[]]];
_range = param [1,100,[0]];
_minDist = param [2,0,[0]];
_count = param [3,1,[0]];
_ifRoad = param [4,false];
_posBuffer = param [5,5,[0]];

_posArray = [];
_counter = 100;

if (_minDist >= _range) then {_minDist = ((_range*0.25)/(_count*2))};

for "_s" from 0 to _counter do {
	_check = true;

	if (_ifRoad) then {
		_range = _range min 1000;
		_roads = _center nearRoads _range;
		_pos = getposATL (_roads select (random ((count _roads) - 1)));

		if (count _posArray >= 1) then {
			{ if (_x distance _pos < _minDist) exitWith { _check = false; } } forEach _posArray;
		};
	} else {
		_pos = [_center,0,_range] call SEN_fnc_findRandomPos;
		_isEmpty = _pos isFlatEmpty [_posBuffer, 0, 1, _posBuffer, 0, false, objNull];
		if !(count _isEmpty isEqualTo 0) then {
			if !(count (_pos nearRoads 12) isEqualTo 0) exitWith { _check = false };
			if (count _posArray >= 1) then {
				{ if (_x distance _pos < _minDist) exitWith { _check = false; } } forEach _posArray;
			};
		} else {
			_check = false;
		};
	};

	if (_check) then {_posArray pushBack _pos};
	if (count _posArray isEqualTo _count) exitWith {};

	if (_s isEqualTo _counter) then {_posArray = []; [2,"Cannot find adequate positions for fn_findPosArray. Consider decreasing minimum distance or count arguments."] call SEN_fnc_log};
};

_posArray