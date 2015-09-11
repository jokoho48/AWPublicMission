/*
Author: SENSEI

Last modified: 9/11/2014

Description: sets task

         returns nothing
__________________________________________________________________*/
if (!isServer) exitWith {};

private "_task";
params [["_override","",[""]]];

uiSleep 15;
if (count SEN_taskList isEqualTo 0) exitWith {[2,"Task list is empty!"] call SEN_fnc_log};
SEN_intelObj = objNull; publicVariable "SEN_intelObj";
SEN_taskSuccess = 0;
if (SEN_taskCounter isEqualTo SEN_totalTaskCount) exitWith {[] call compile preprocessFileLineNumbers "tasks\SEN_debriefing.sqf"};
SEN_taskCounter = SEN_taskCounter + 1;
if !(_override isEqualTo "") exitWith {[] spawn compile preprocessFileLineNumbers format ["tasks\SEN_task_%1.sqf", _override]};
_task = SEN_taskList select (random ((count SEN_taskList) - 1));
[] spawn compile preprocessFileLineNumbers format ["tasks\SEN_task_%1.sqf", _task];
SEN_taskList = SEN_taskList - [_task];
