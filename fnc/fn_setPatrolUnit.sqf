/*
Author: SENSEI

Last modified: 7/18/2015

Description: set unit on patrol

             returns nothing
__________________________________________________________________*/
private ["_unit","_maxRange","_minDist","_posArray","_pos1","_houses","_house","_housePosArray","_pos2","_dir","_range","_moveTo","_posCheck"];

_unit = _this select 0;
_maxRange = _this select 1;
_minDist = _maxRange*0.30;
_posArray = [];
_unit forceSpeed (_unit getSpeed "SLOW");
_pos1 = getposATL _unit;

for "_i" from 1 to 50 do {
    if ((count _this > 2) && {random 1 < 0.6}) then {
        _houses = _this select 2;
        _house = _houses select (random ((count _houses) - 1));
        _housePosArray = [_house] call bis_fnc_buildingPositions;
        _houses = _houses - [_house];
        if (count _housePosArray > 1) then {
            _pos2 = _housePosArray select (random ((count _housePosArray) - 1));
            _posArray pushBack _pos2;
        };
    } else {
        _dir = random 360;
        _range = (ceil random _maxRange);
        _pos2 = [(_pos1 select 0) + (sin _dir) * _range, (_pos1 select 1) + (cos _dir) * _range, 0];
        if !(surfaceIsWater _pos2) then {
            if ({(_pos2 distance _x) < _minDist} count _posArray isEqualTo 0) then {_posArray pushBack _pos2};
        };
    };
    if (count _posArray isEqualTo 5) exitWith {/*[0,"fn_setPatrolUnit: %1 has a full position array, %2. Iterations: %3.",_unit, _posArray, _i] call SEN_fnc_log;*/};
};

if (count _posArray < 2) exitWith { [2,"fn_setPatrolUnit position array count is too low for %1.",_unit] call SEN_fnc_log};

while {alive _unit && !(isPlayer(_unit findNearestEnemy _unit)) && !(_unit getVariable ["SEN_patrol_exit",false])} do {
    _moveTo = _posArray select (random ((count _posArray) - 1));
    _unit doMove _moveTo;
    /*[0,"fn_setPatrolUnit: %1 moving to %2.",_unit, _moveTo] call SEN_fnc_log;*/
    waitUntil {
        _posCheck = getposATL _unit;
        uiSleep 10;
        ((_unit distance _moveTo < 3) || (getposATL _unit) distance _posCheck < 0.4 || !alive _unit || (isPlayer(_unit findNearestEnemy _unit)) || (_unit getVariable ["SEN_patrol_exit",false]))
    };

    if (_unit distance _moveTo < 3) then {/*[0,"fn_setPatrolUnit: %1 at %2.",_unit, _moveTo] call SEN_fnc_log;*/ uiSleep (20 + random 20);};
};
_unit forceSpeed -1;
[0,format ["fn_setPatrolUnit: %1 exiting loop at %2.",typeOf _unit, getposATL _unit]] call SEN_fnc_log;