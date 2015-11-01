/*
Author: SENSEI

Last modified: 8/14/2015

Description: steal intel from device
__________________________________________________________________*/
if (!isServer) exitWith {};

private "_mrkDebug";

_taskID = "steal";
_taskText = "Steal Intel";
_taskDescription = "We have intel that the enemey have created a highly advanced weapons device. We cannot allow the opposition to gain the upper hand. Find the device and retrieve information from its onboard computer.";

if (worldName isEqualTo "Stratis") exitWith { // Stratis is too hilly
    SEN_taskList pushBack _taskID;
    SEN_taskCounter = SEN_taskCounter - 1;
    [] call SEN_fnc_setTask;
};

_pos = [];
_radius = 1200;

_pos = [SEN_centerPos,SEN_range,140] call SEN_fnc_findRuralFlatPos;
if (_pos isEqualTo []) exitWith {
    SEN_taskList pushBack _taskID;
    SEN_taskCounter = SEN_taskCounter - 1;
    [] call SEN_fnc_setTask;
};

_grpArray = [_pos,SEN_enemySide,8,.5,2] call SEN_fnc_spawnSquad;
_baseArray = _grpArray select 0;
_vehArray = _grpArray select 1;
_grp = _grpArray select 2;
SEN_intelObj = (nearestObjects [_pos, ["Land_Device_assembled_F"], 100]) select 0; publicVariable "SEN_intelObj";
[_grp,150] spawn SEN_fnc_setPatrolGroup;
if !(count _vehArray isEqualTo 0) then {
    [group (_vehArray select 0),_pos,500] call BIS_fnc_taskPatrol;
};

_posMrk = [_pos,0,_radius] call SEN_fnc_findRandomPos;
_mrk = createMarker ["SEN_steal_AO",_posMrk];
_mrk setMarkerColor "ColorRED";
_mrk setMarkerShape "ELLIPSE";
_mrk setMarkerAlpha 0.7;
_mrk setMarkerSize [_radius,_radius];

[WEST,[_taskID],[_taskDescription, _taskText, ""], _posMrk,false,2,true,"Search",false] call BIS_fnc_taskCreate;

if(SEN_debug) then {
    [_taskID] call BIS_fnc_taskSetCurrent;
    [_taskID,getPosATL SEN_intelObj] call BIS_fnc_taskSetDestination;
};

waitUntil {sleep 10; SEN_taskSuccess isEqualTo 1};

JK_TicketSystem = JK_TicketSystem + 200;
publicVariable "JK_TicketSystem";

[_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
SEN_objectCleanup append _baseArray;
SEN_markerCleanup pushBack _mrk;
[] call SEN_fnc_setTask;
