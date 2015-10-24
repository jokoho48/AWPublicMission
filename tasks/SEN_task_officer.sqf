/*
Author: SENSEI

Last modified: 8/13/2015

Description: officer task
__________________________________________________________________*/
if (!isServer) exitWith {};

private ["_mrk","_unitType"];

_taskID = "officer";
_taskText = "Locate Officer";
_taskDescription = "A high ranking enemy officer will be traveling to an occupied settlement today.<br/><br/>Find the officer and gather any relevant intel.";

_town = SEN_occupiedLocation select (random ((count SEN_occupiedLocation) - 1));
_townMarker = SEN_occupiedLocation select (random ((count SEN_occupiedLocation) - 1));
_unitType = SEN_officerPool select (random ((count SEN_officerPool) - 1));
_officerTown = getpos _town;
_officerTown set [2,0];
SEN_intelObj = (createGroup SEN_enemySide) createUnit [_unitType, _officerTown, [], 0, "NONE"];
publicVariable "SEN_intelObj";
removeFromRemainsCollector [SEN_intelObj];

SEN_intelObj addEventHandler ["hit", {
    (_this select 0) removeAllEventHandlers "hit";
    if (alive (_this select 0)) then {
        [(_this select 0)] call SEN_fnc_setUnitSurrender;
    };
}];
[group SEN_intelObj,90] spawn SEN_fnc_setPatrolGroup;

[WEST, [_taskID], [_taskDescription, _taskText, ""], getPos _townMarker, false, -1, true, "Search", false] call BIS_fnc_taskCreate;

if(SEN_debug isEqualTo 1) then {
    [_taskID] call BIS_fnc_taskSetCurrent;
    [_taskID,getPosATL SEN_intelObj] call BIS_fnc_taskSetDestination;
};

waitUntil {sleep 10; SEN_taskSuccess isEqualTo 1};

JK_TicketSystem = JK_TicketSystem + 500;
publicVariable "JK_TicketSystem";

[_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
deleteVehicle SEN_intelObj;
[] call SEN_fnc_setTask;
