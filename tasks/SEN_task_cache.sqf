/*
Author: SENSEI

Last modified: 8/14/2015

Description: destroy ammo cache
__________________________________________________________________*/
if (!isServer) exitWith {};

_taskID = "cache";
_taskText = "Destroy Cache";
_taskDescription = "According to intel, a small enemy camp is housing an ammunitions cache that is critical to the opposition's efforts. Your team is tasked with destorying the cache.";

_pos = [];
_cacheArray = [];
_radius = 1000;

_pos = [SEN_centerPos,SEN_range,70] call SEN_fnc_findRuralFlatPos;
if (_pos isEqualTo []) exitWith {
    SEN_taskList pushBack _taskID;
    SEN_taskCounter = SEN_taskCounter - 1;
    [] call SEN_fnc_setTask;
};
_grpArray = [_pos,SEN_enemySide,8,.25,1] call SEN_fnc_spawnSquad;
_grpArray params ["_baseArray", "_vehArray", "_grp"];
_hq = nearestObjects [_pos, ["Land_Cargo_HQ_V3_F"], 100];
_hq = (_hq select (random ((count _hq) - 1)));

for "_i" from 0 to 2 step 2 do {
    _ammo = "O_supplyCrate_F" createVehicle [0,0,0];
    _ammo setDir getDir _hq;
    _ammo setposatl (_hq modelToWorld [4,1 + _i,-2.6]);
    _ammo addEventHandler ["HandleDamage", {if ((_this select 4) isKindof "PipeBombBase" && {(_this select 2) > 0.6}) then {(_this select 0) setdamage 1};}];
    _cacheArray pushBack _ammo;
};

[_grp] spawn SEN_fnc_setPatrolGroup;
if !(count _vehArray isEqualTo 0) then {
    [group (_vehArray select 0),_pos,200] call BIS_fnc_taskPatrol;
};

_posMrk = [_pos,100,_radius] call SEN_fnc_findRandomPos;
_mrk = createMarker ["SEN_cache_AO",_posMrk];
_mrk setMarkerColor "ColorRED";
_mrk setMarkerShape "ELLIPSE";
_mrk setMarkerAlpha 0.7;
_mrk setMarkerSize [_radius,_radius];

[WEST, [_taskID], [_taskDescription, _taskText, ""], _mrk, false, 2, true, "Destroy", false] call BIS_fnc_taskCreate;

if(SEN_debug) then {
    [_taskID] call BIS_fnc_taskSetCurrent;
    [_taskID,_pos] call BIS_fnc_taskSetDestination;
};

waitUntil {sleep 10; {(damage _x) > 0.95} forEach _cacheArray};

[_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;

JK_TicketSystem = JK_TicketSystem + 500;
publicVariable "JK_TicketSystem";

{deleteVehicle _x} forEach _cacheArray;
SEN_objectCleanup append _baseArray;
SEN_markerCleanup pushBack _mrk;
[] call SEN_fnc_setTask;
