/*
Author: SENSEI

Last modified: 7/25/2015

Description: maintenance loop
__________________________________________________________________*/
if !(isServer) exitWith {};

if (SEN_HCPresent) then {[[[],"scripts\SEN_cleanup.sqf"],"BIS_fnc_execVM",(owner SEN_HC)] call BIS_fnc_MP}; // if headless client active run loop on HC as well

SEN_markerCleanup = [];
SEN_objectCleanup = [];

while {true} do {
    uiSleep 300;
    // groups
    {
        if (local _x && {(count units _x) isEqualTo 0}) then { // only local groups can be deleted
            deleteGroup _x;
        };
    } forEach allGroups;
    // markers
    if (count SEN_markerCleanup > 0) then {
        {
            deleteMarker _x;
            uiSleep 0.05;
            if (getMarkerColor _x isEqualTo "") then {SEN_markerCleanup = SEN_markerCleanup - [_x]};
        } forEach SEN_markerCleanup;
    };
    // objects
    if (count SEN_objectCleanup > 0) then {
        {
            if (_x isKindOf "LandVehicle" || {_x isKindOf "Air"} || {_x isKindOf "Ship"}) then {
                if ({isPlayer _x} count (crew _x) isEqualTo 0) then {
                    {deleteVehicle _x} forEach (crew _x);
                    deleteVehicle _x;
                };
            } else {
                if (count ([getPosATL _x,200] call SEN_fnc_getNearPlayers) isEqualTo 0) then {deleteVehicle _x};
            };
        } forEach SEN_objectCleanup;
        uiSleep 0.05;
        {if (isNull _x) then {SEN_objectCleanup = SEN_objectCleanup - [_x]}} forEach SEN_objectCleanup;
    };
    [0,"Cleanup."] call SEN_fnc_log;
};
