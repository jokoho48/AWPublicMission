/*
Author: SENSEI

Last modified: 11/3/2014

Description: handles civilian functionality
__________________________________________________________________*/
if (!isServer) exitWith {};

private ["_unitCount","_vehCount","_cond"];
params ["_dist", "_air"];

{
    _townPos = getpos _x;
    _townPos set [2,0];
    call {
        if ((type _x) isEqualTo "NameCity") exitWith {_unitCount = 6; _vehCount = 3};
        if ((type _x) isEqualTo "NameCityCapital") exitWith {_unitCount = 10; _vehCount = 2};
        _unitCount = 4;
        _vehCount = 1;
    };
    _trg = createTrigger ["EmptyDetector",_townPos];
    _trg setTriggerArea [_dist,_dist,0,FALSE];
    _trg setTriggerActivation ["WEST","PRESENT",true];
    _trg setTriggerTimeout [10, 10, 10, true];
    if (_air) then {
        _cond = format["{(getposATL (vehicle _x) distance %1 < %2)} count allPlayers > 0",(getposATL _trg),_dist];
    } else {
        _cond = format["{(getposATL (vehicle _x) distance %1 < %2 && {((getposATL _x) select 2) < 30})} count allPlayers > 0",(getposATL _trg),_dist];
    };
    _trgVar = format ["SEN_%1_civ_trg", text _x];
    _trgAct = format ["[%1,%2,%3,%4] spawn SEN_fnc_spawnCiv;",_townPos,_unitCount,_vehCount,str _trgVar];
    _trgDe = format ["missionNameSpace setvariable [%1,false]",str _trgVar];
    _trg setTriggerStatements [_cond,_trgAct,_trgDe];

    if (SEN_debug) then {
        [0,"Creating civilian trigger at %1.", text _x] call SEN_fnc_log;
        _mrk = createMarker [format["%1_DEBUG",_trgVar],getposATL _trg];
        _mrk setMarkerColor "ColorBlack";
        _mrk setMarkerShape "ELLIPSE";
        _mrk setMarkerAlpha 0.5;
        _mrk setMarkerSize [_dist,_dist];
    };
    nil
} count SEN_whitelistLocation;
