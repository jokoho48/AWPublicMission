/*
Author: SENSEI

Last modified: 7/18/2015

Description: set vehicles on patrol

             returns nothing
__________________________________________________________________*/
private ["_driver","_maxRange","_isAir","_veh","_posArray","_minDist","_buffer","_roads","_pos1","_dir","_range","_pos2","_road","_height","_moveTo","_posCheck","_wpindex","_grp","_waypointsrange"];
params ["_driver", "_maxRange", "_isAir"];

if (_maxRange > 1000) then {_maxRange = 1000};
_driver setVariable ["SEN_patrol_exit",false];
_driver setBehaviour "SAFE";
_veh = vehicle _driver;
_grp = group _driver;
_wpindex = 0;
_waypointsrange = 5;
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
                if ({(_pos2 distance _x) < _minDist} count _posArray isEqualTo 0) then {
                  _posArray pushBack _pos2;
                  _wpindex = _wpindex + 1;
                  _wp = _grp addWaypoint [_pos2, 0];
                  _wp setWaypointType "MOVE";
                  [_grp, _wpindex] setWaypointBehaviour "SAFE";
                  [_grp, _wpindex] setWaypointCombatMode "RED";
                  [_grp, _wpindex] setWaypointCompletionRadius _waypointsrange;
                  [_grp, _wpindex] setWaypointLoiterRadius _waypointsrange;
                  [_grp, _wpindex] setWaypointTimeout [2,20,6];
                };
            };

            if (count _posArray isEqualTo 5) exitWith {
                [_grp, _wpindex] setWaypointStatements ["true", "(group this) setCurrentWaypoint [group this, 1];"];
            };
        };
    } else {
        for "_i" from 1 to 50 do {
            _road = _roads call BIS_fnc_selectRandom;
               if ({(_road distance _x) < _minDist} count _posArray isEqualTo 0) then {
                 _posArray pushBack (getposATL _road);
                 _wpindex = _wpindex + 1;
                 _wp = _grp addWaypoint [(getposATL _road), 0];
                 _wp setWaypointType "MOVE";
                 [_grp, _wpindex] setWaypointBehaviour "SAFE";
                 [_grp, _wpindex] setWaypointCombatMode "RED";
                 [_grp, _wpindex] setWaypointCompletionRadius _waypointsrange;
                 [_grp, _wpindex] setWaypointLoiterRadius _waypointsrange;
                 [_grp, _wpindex] setWaypointTimeout [2,20,6];
               };

            if (count _posArray isEqualTo 5) exitWith {
                [_grp, _wpindex] setWaypointStatements ["true", "(group this) setCurrentWaypoint [group this, 1];"];
            };
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
           if ({(_pos2 distance _x) < _minDist} count _posArray isEqualTo 0) then {
             _posArray pushBack _pos2;
             _wpindex = _wpindex + 1;
             _wp = _grp addWaypoint [_pos2, 0];
             _wp setWaypointType "MOVE";
             [_grp, _wpindex] setWaypointBehaviour "SAFE";
             [_grp, _wpindex] setWaypointCombatMode "RED";
             [_grp, _wpindex] setWaypointCompletionRadius _waypointsrange;
             [_grp, _wpindex] setWaypointLoiterRadius _waypointsrange;
         };

        if (count _posArray isEqualTo 5) exitWith {
            [_grp, _wpindex] setWaypointStatements ["true", "(group this) setCurrentWaypoint [group this, 1];"];
        };
    };
};
