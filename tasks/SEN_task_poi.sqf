/*
Author: SENSEI

Last modified: 8/14/2015

Description: Eliminate the Officer
__________________________________________________________________*/
scriptName "SEN_task_poi";
if (!isServer) exitWith {};

_taskID = "poi";
_taskText = "Eliminate Officer";
_taskDescription = "A high ranking enemy officer will be traveling to an occupied settlement today.<br/><br/>Find the officer and eliminate him.";

_poiRadius = 1200;
_posAdder = 10;
_unitType = selectRandom SEN_officerPool ;
_pos = [];

_pos = [SEN_centerPos,SEN_range,70] call SEN_fnc_findRuralFlatPos;
while {(([_pos, 3000] call SEN_fnc_getNearPlayers) isEqualTo [] && (surfaceIsWater _pos))} do {
    _pos = [SEN_centerPos,SEN_range,70 call SEN_fnc_findRuralFlatPos;
};
if (_pos isEqualTo []) exitWith {
    SEN_taskList pushBack _taskID;
    SEN_taskCounter = SEN_taskCounter - 1;
    [] call SEN_fnc_setTask;
};

_grpArray = [_pos,SEN_enemySide,8,.5,1] call SEN_fnc_spawnSquad;
_grpArray params ["_baseArray", "_vehArray", "_grp"];
_posPoi = getposATL selectRandom (((nearestObjects [_pos, ["Land_Cargo_HQ_V3_F"], 200]) select 0) buildingPos -1);
_target=(createGroup SEN_enemySide) createUnit [_unitType, _posPoi, [], 0, "NONE"];
_target disableAI "MOVE";

[_grp,100] spawn SEN_fnc_setPatrolGroup;
if !(count _vehArray isEqualTo 0) then {
    [group (_vehArray select 0),_pos,500] call BIS_fnc_taskPatrol;
};

_posMrk = [_pos,0,_poiRadius] call SEN_fnc_findRandomPos;

[WEST, [_taskID], [_taskDescription, _taskText, ""], _posMrk, false, 2, true, "Destroy", false] call CBA_fnc_taskCreate;

if(SEN_debug) then {
    [_taskID] call BIS_fnc_taskSetCurrent;
    [_taskID,_posPoi] call BIS_fnc_taskSetDestination;
};

waitUntil {sleep 10;! alive _target};


[_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;

JK_TicketSystem = JK_TicketSystem + 600;
publicVariable "JK_TicketSystem";

SEN_objectCleanup append _target;
SEN_objectCleanup append _baseArray;
[] call SEN_fnc_setTask;
