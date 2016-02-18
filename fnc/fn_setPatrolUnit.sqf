/*
Author: SENSEI

Last modified: 7/18/2015

Description: set unit on patrol

             returns nothing
__________________________________________________________________*/
private ["_minDist", "_posArray", "_pos1", "_house", "_housePosArray", "_pos2", "_dir", "_range", "_moveTo", "_posCheck", "_houses","_wp","_wpindex", "_waypointsrange"];
params ["_grp", "_maxRange"];
_minDist = _maxRange * 0.30;
_waypointsrange = 5;
_posArray = [];
_pos1 = getposATL (leader _grp);
_wpindex = 0;

for "_i" from 1 to 50 do {
    if ((count _this > 2) && {random 1 < 0.6}) then {
        _houses = _this select 2;
        _house = selectRandom _houses;
        _housePosArray = [_house] call JK_Core_fnc_buildingPositions;
        _houses = _houses - [_house];
        if (count _housePosArray > 1) then {
            _pos2 = getPos _house;
            _posArray pushBack _pos2;
            _wpindex = _wpindex + 1;
            _wp = _grp addWaypoint [_pos2, 0];
            _wp setWaypointType (selectRandom ["MOVE", "LOITER"]);
            _wp waypointAttachObject _house;
            [_grp, _wpindex] setWaypointHousePosition floor(random(count _housePosArray));
            [_grp, _wpindex] setWaypointBehaviour "SAFE";
            [_grp, _wpindex] setWaypointCombatMode "RED";
            [_grp, _wpindex] setWaypointCompletionRadius _waypointsrange;
            [_grp, _wpindex] setWaypointLoiterRadius _waypointsrange;
            [_grp, _wpindex] setWaypointTimeout [2,20,6];
        };
    } else {
        _dir = random 360;

        _range = (ceil random _maxRange);
        _pos2 = [(_pos1 select 0) + (sin _dir) * _range, (_pos1 select 1) + (cos _dir) * _range, 0];
        if !(surfaceIsWater _pos2) then {
            if ({(_pos2 distance _x) < _minDist} count _posArray isEqualTo 0) then {
                _posArray pushBack _pos2;
                _wpindex = _wpindex + 1;
                _wp = _grp addWaypoint [_pos2, 0];
                _wp setWaypointType (selectRandom ["MOVE", "LOITER"]);
                [_grp, _wpindex] setWaypointBehaviour "SAFE";
                [_grp, _wpindex] setWaypointCombatMode "RED";
                [_grp, _wpindex] setWaypointCompletionRadius _waypointsrange;
                [_grp, _wpindex] setWaypointLoiterRadius _waypointsrange;
                [_grp, _wpindex] setWaypointTimeout [2,20,6];
            };
        };
    };
    if (count _posArray isEqualTo 5) exitWith {
        [_grp, _wpindex] setWaypointStatements ["true", "(group this) setCurrentWaypoint [group this, 1];"];
    };
};
