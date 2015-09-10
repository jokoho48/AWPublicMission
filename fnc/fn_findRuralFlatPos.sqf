/*
Author: SENSEI

Last modified: 6/26/2015

Description: finds a flat rural position

        returns position
__________________________________________________________________*/
private ["_center","_range","_dist","_counter","_posFound","_s","_pos"];

_center = _this select 0;
_range = _this select 1;
_dist = _this select 2;

_counter = 100;
_posFound = false;

for "_s" from 0 to _counter do {
    _pos = [_center,0,_range] call SEN_fnc_findRandomPos;
    if !([_pos, "SEN_safezone_mrk"] call SEN_fnc_checkInMarker) then {
        if (count (_pos isFlatEmpty [1, 0, 0.3, 30, 0, false, objNull]) != 0 && {count (_pos isFlatEmpty [1, 0, 0.12, _dist min 300, 0, false, objNull]) != 0}) then {
            if (count (nearestObjects [_pos, ["house"], _dist*1.7]) isEqualTo 0) then {
                _dummypad = createVehicle ["Land_HelipadEmpty_F", _pos, [], 0, "CAN_COLLIDE"];
                if !(surfaceIsWater (_dummypad modelToWorld [0,-100,0]) || {surfaceIsWater (_dummypad modelToWorld [0,100,0])} || {surfaceIsWater (_dummypad modelToWorld [100,0,0])} || {surfaceIsWater (_dummypad modelToWorld [-100,0,0])}) then {
                    _posFound = true;
                };
                deleteVehicle _dummypad;
            };
        };
    };

    if (_posFound) exitWith {};
    if (_s isEqualTo _counter) exitWith {_pos = []};
};

_pos
