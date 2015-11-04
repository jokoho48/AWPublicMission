/*
Author: SENSEI

Last modified: 7/19/2015

Description: finds an interior house position outside a town

        returns array [house, position in house]
__________________________________________________________________*/
private ["_counter","_s","_return","_startPos","_houseArray"];
params ["_center", "_range"];
_counter = 100;

for "_s" from 0 to _counter do {
    _return = [0,0,0];
    _startPos = [_center,0,_range] call SEN_fnc_findRandomPos;
    if !([_startPos,"SEN_safezone_mrk"] call SEN_fnc_checkInMarker) then {
        {
            if (_startPos distance _x < 700) exitWith {_return = [];};
        } count (SEN_occupiedLocation + SEN_whitelistLocation);

        if !(count _return isEqualTo 0) then {
            _houseArray = [_startPos,500] call SEN_fnc_findHousePos;
            if (count (_houseArray select 1) isEqualTo 0) exitWith {_return = [];};
            _return = _houseArray;
        };
    };
    if (count _return isEqualTo 2) exitWith {};
    if (_s isEqualTo _counter) exitWith {[2,"fn_findRuralHousePos: Cannot find a suitable house position."] call SEN_fnc_log; _return = [objNull,[0,0,0]]; _return};
};

_return
