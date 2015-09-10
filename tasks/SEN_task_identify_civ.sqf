/*
Author: SENSEI

Last modified: 8/14/2015

Description: identify dead politician
__________________________________________________________________*/
if (!isServer) exitWith {};

_taskID = format["%1_identify_civ",SEN_taskCounterCiv];
_taskText = "ID Politician";
_taskDescription = "Another local politician was executed live on television a few hours ago. In the aftermath of the event, the government publically blamed us, but we have intel on the actual culprits. Your orders are to infiltrate their camp and identify the deceased politician.";

_pos = [];
_vehArray = [];
_radius = 1000;

_pos = [SEN_centerPos,SEN_range,70] call SEN_fnc_findRuralFlatPos;
if (_pos isEqualTo []) exitWith {
    [] call SEN_fnc_setTaskCiv;
};
_grpArray = [_pos,SEN_enemySide,5,.25,1] call SEN_fnc_spawnSquad;
_baseArray = _grpArray select 0;
_vehArray = _grpArray select 1;
_grp = _grpArray select 2;
_med = ((nearestObjects [_pos, ["Land_Medevac_house_V1_F"], 100]) select 0);
_med setvariable["ace_medical_isMedicalFacility", true, true];
for "_i" from 1 to 2 do {
    SEN_intelObjCiv = "ACE_bodyBagObject" createVehicle [0,0,0];
    SEN_intelObjCiv setDir getDir _med;
    SEN_intelObjCiv setposatl (_med modelToWorld [0 - _i,1.2,.6]);
    [SEN_intelObjCiv,false] call ace_dragging_fnc_setDraggable;
    _baseArray pushBack SEN_intelObjCiv;
};
publicVariable "SEN_intelObjCiv";

[_grp] spawn SEN_fnc_setPatrolGroup;
if !(count _vehArray isEqualTo 0) then {
    [group (_vehArray select 0),_pos,200] call BIS_fnc_taskPatrol;
};

[WEST,[_taskID],[_taskDescription, _taskText, ""],_pos,false,1,true,"C",false] call BIS_fnc_taskCreate;

waitUntil {sleep 10; SEN_taskSuccess isEqualTo 2};

[_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
SEN_approvalCiv = SEN_approvalCiv + (40 + random 25); publicVariable "SEN_approvalCiv";
SEN_objectCleanup append _baseArray;
sleep SEN_taskSleepCiv;
[] call SEN_fnc_setTaskCiv;
