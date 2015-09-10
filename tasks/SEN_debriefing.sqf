/*
Author: SENSEI

Last modified: 8/14/2015

Description: debrief task
__________________________________________________________________*/
_taskID = "debriefing";
_taskText = "Debriefing (Mission Complete)";
_taskDescription = "Return to MOB Dodge and assess the mission outcome.";

[[SEN_mob_laptop,["<t color='#FFFFFF'>End Mission</t>",{[["SEN_end",true,true],"BIS_fnc_endMission",true,false] call BIS_fnc_MP;},[],110,false]],"addAction",true,false,true] call BIS_fnc_MP;

[WEST,[_taskID],[_taskDescription, _taskText, ""],getPosATL SEN_mob_laptop,false,2,true,"Default",false] call BIS_fnc_taskCreate;