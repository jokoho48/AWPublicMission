/*
Author: SENSEI

Last modified: 8/8/2015

Description:  sends request for FOB control
__________________________________________________________________*/
if (getMarkerColor "sen_fob_mrk" isEqualTo "") exitWith {
	hintSilent "You must deploy FOB Pirelli before requesting control.";
};

if (player isEqualTo (getAssignedCuratorUnit SEN_curatorFOB)) exitWith {
	hintSilent "You already control FOB Pirelli.";
};

//player setVariable ["SEN_inProgress",true];

if (isNull (getAssignedCuratorUnit SEN_curatorFOB)) exitWith {
	missionNamespace setVariable ["SEN_fobRequest",[player,1]];
	publicVariableServer "SEN_fobRequest";
};

missionNamespace setVariable ["SEN_fobRequest",[player]];
publicVariableServer "SEN_fobRequest";