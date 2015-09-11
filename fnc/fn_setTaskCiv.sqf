/*
Author: SENSEI

Last modified: 9/11/2014

Description: sets civilians task

        returns nothing
__________________________________________________________________*/
if (!isServer) exitWith {};

private "_task";
params [["_override","",[""]]];

uiSleep 15;
SEN_intelObjCiv = objNull; publicVariable "SEN_intelObjCiv";
SEN_taskSuccess = 0;
SEN_taskCounterCiv = SEN_taskCounterCiv + 1;
if !(_override isEqualTo "") exitWith { [] spawn compile preprocessFileLineNumbers format ["tasks\SEN_task_%1_civ.sqf", _override]; };
_task = SEN_taskListCiv select (random ((count SEN_taskListCiv) - 1));
spawn compile preprocessFileLineNumbers format ["tasks\SEN_task_%1_civ.sqf", _task];
