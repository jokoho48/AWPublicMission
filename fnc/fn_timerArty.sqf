/*
Author: SENSEI, sargentekin

Last modified: 1/2/2015

Description: runs timer for arty task

             returns nothing
__________________________________________________________________*/
if !(isServer) exitWith {};

private ["_gunnerArray","_time","_targetPos","_i","_gunnerCount","_gunner","_hintCounter"];

_gunnerArray = _this select 0;
_targetPos = _this select 1;
_time = _this select 2;

_hintCounter = 60;

while {_time > 0 && {!SEN_defused}} do {
    _time = _time - 1;
    _hintCounter = _hintCounter - 1;

    if (_hintCounter isEqualTo 0) then {
        _timeDisplay = [((_time)/60)+.01] call SEN_fnc_setTimer;
        ["Artillery firing in " + _timeDisplay + " minutes.", "hintSilent"] call BIS_fnc_MP;
        //("Artillery firing in " + _timeDisplay + " minutes.") remoteExecCall ["hintSilent", 0, false];
        _hintCounter = 60;
    };

    if (_time < 1) then {
        for "_i" from 0 to ((count _gunnerArray) - 1) do {
            _gunner = _gunnerArray select _i;
            //_gunner enableSimulationGlobal true;
            _gunner doArtilleryFire [_targetPos, "32Rnd_155mm_Mo_shells", 10];
        };
        SEN_armed = true;
    };

    uiSleep 1;
};