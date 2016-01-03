/*
Author: SENSEI

Last modified: 8/14/2015

Description: debrief task
__________________________________________________________________*/
scriptName "SEN_task_debriefing";
_taskID = "debriefing";
_taskText = "Debriefing (Mission Complete)";
_taskDescription = "Return to MOB Dodge and assess the mission outcome.";

_pos = getPos SEN_mob_laptop;
_dir = getDir SEN_mob_laptop;
deleteVehicle SEN_mob_laptop;
_veh = "Land_Laptop_F" createVehicle _pos;

_veh setDir _dir;

[[_veh,["<t color='#FFFFFF'>End Mission</t>",{
    [["SEN_end",true,true],"BIS_fnc_endMission",true,false] call BIS_fnc_MP;
},[],110,false]],"addAction",true,false,true] call BIS_fnc_MP;
JK_TicketSystem = JK_TicketSystem + 500;
publicVariable "JK_TicketSystem";

[WEST,[_taskID],[_taskDescription, _taskText, ""],getPosATL _veh,false,2,true,"Default",false] call BIS_fnc_taskCreate;
