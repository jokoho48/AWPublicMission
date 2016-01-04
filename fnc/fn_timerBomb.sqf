/*
Author: SENSEI, sargentekin

Last modified: 1/2/2015

Description: runs timer for defuse explosive task

             returns nothing
__________________________________________________________________*/
if !(isServer) exitWith {};

private ["_hintCounter", "_houses", "_timeDisplay", "_splosion"];
params ["_pos", "_time"];

_hintCounter = 60;
_houses = (nearestObjects [_pos, ["house"], 150]);

while {_time > 0 && {!SEN_defused}} do {
    _time = _time - 1;
    _hintCounter = _hintCounter - 1;

    if (_hintCounter isEqualTo 0) then {
        _timeDisplay = [((_time)/60)+.01] call SEN_fnc_setTimer;
        (format ["Explosive detonation in %1 minutes.", _timeDisplay]) remoteExecCall ["hintSilent", 0, false];
        _hintCounter = 60;
    };

    if (SEN_armed) then {
        _time = 3;
        SEN_armed = false;
    };

    if (_time < 1) then {
        SEN_armed = true;
        "Bo_GBU12_LGB_MI10" createVehicle (getposATL SEN_defuseObj); // create explosion at detonator
        for "_i" from 0 to ((ceil(count _houses)*0.5) min 15) do { // create explosions at various buildings
            _splosion = _houses call BIS_fnc_selectRandom;
            "Bo_GBU12_LGB_MI10" createVehicle (getposATL _splosion);

            uiSleep (0.5 + random 1.25);
        };
    };
    uiSleep 1;
};
