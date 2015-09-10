/*
Author: SENSEI

Last modified: 7/18/2015

Description: set vehicles on patrol

             returns nothing
__________________________________________________________________*/
private ["_driver","_maxRange","_isAir","_veh","_posArray","_minDist","_buffer","_roads","_pos1","_dir","_range","_pos2","_road","_height","_moveTo","_posCheck"];

_driver = _this select 0;
_maxRange = _this select 1;
_isAir = _this select 2;

if (_maxRange > 1000) then {_maxRange = 1000};
_driver setVariable ["SEN_patrol_exit",false];
_driver setBehaviour "SAFE";
_veh = vehicle _driver;
_posArray = [];
_minDist = _maxRange*0.30;
_buffer = 0;

if !(_isAir) then {
    _roads = _veh nearRoads _maxRange;
    _veh forceSpeed (_veh getSpeed "SLOW");
    _buffer = 30;

    if (count _roads isEqualTo 0) then {
        _pos1 = getposATL _veh;

        for "_i" from 1 to 50 do {
            _dir = random 360;
            _range = (ceil random _maxRange);
            _pos2 = [(_pos1 select 0) + (sin _dir) * _range, (_pos1 select 1) + (cos _dir) * _range, 0];
            if !(surfaceIsWater _pos2) then {
                if ({(_pos2 distance _x) < _minDist} count _posArray isEqualTo 0) then {_posArray pushBack _pos2};
            };

            if (count _posArray isEqualTo 3) exitWith {/*[0,"fn_setPatrolVeh: %1 has a full position array, %2. Iterations: %3.",_driver, _posArray, _i] call SEN_fnc_log;*/};
        };
    } else {
        for "_i" from 1 to 50 do {
            _road = _roads select (random ((count _roads) - 1));
               if ({(_road distance _x) < _minDist} count _posArray isEqualTo 0) then {_posArray pushBack (getposATL _road)};

            if (count _posArray isEqualTo 5) exitWith {/*[0,"fn_setPatrolVeh: %1 has a full position array, %2. Iterations: %3.",_driver, _posArray, _i] call SEN_fnc_log;*/};
        };
    };
} else {
    _height = 180;
    _buffer = 100;
    _veh flyInHeight _height;
    _pos1 = getposATL _veh;

    for "_i" from 1 to 100 do {
        _dir = random 360;
        _range = (ceil random _maxRange);
        _pos2 = [(_pos1 select 0) + (sin _dir) * _range, (_pos1 select 1) + (cos _dir) * _range, _height];
           if ({(_pos2 distance _x) < _minDist} count _posArray isEqualTo 0) then {_posArray pushBack _pos2};

        if (count _posArray isEqualTo 5) exitWith {/*[0,"fn_setPatrolVeh: %1 has a full position array, %2. Iterations: %3.",_driver, _posArray, _i] call SEN_fnc_log;*/};
    };
};

if (count _posArray < 2) exitWith {[2,"fn_setPatrolVeh position array count is too low for %1.",_driver] call SEN_fnc_log};

while {alive _driver && vehicle _driver isEqualTo _veh && !(isPlayer(_driver findNearestEnemy _driver)) && !(_driver getVariable ["SEN_patrol_exit",false])} do {
    _moveTo = _posArray select (random ((count _posArray) - 1));
    _driver doMove _moveTo;
    /*[0,"fn_setPatrolVeh: %1 moving to %2.",_driver, _moveTo] call SEN_fnc_log;*/
    waitUntil {
        _posCheck = getposATL _veh;
        uiSleep 10;
        (_veh distance _moveTo < _buffer || (getposATL _veh) distance _posCheck < 0.1 || !alive _driver || !(vehicle _driver isEqualTo _veh) || (isPlayer(_driver findNearestEnemy _driver)) || (_driver getVariable ["SEN_patrol_exit",false]))
    };

    if (_veh distance _moveTo < _buffer) then {/*[0,"fn_setPatrolVeh: %1 at %2.",_driver, _moveTo] call SEN_fnc_log;*/ uiSleep 20;};
    if (fuel _veh < 0.5) then {_veh setFuel 1};
};

_veh forceSpeed -1;

[0,format ["fn_setPatrolVeh: %1 exiting loop at %2.",typeOf _driver, getposATL _driver]] call SEN_fnc_log;