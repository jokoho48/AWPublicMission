/*
Author: SENSEI

Last modified: 8/5/2015
__________________________________________________________________*/

JK_TicketSystem = profileNameSpace getVariable ["JK_TicketSystem", 2000];
publicVariable "JK_TicketSystem";

SEN_approvalCiv = profileNamespace getVariable ["SEN_approvalCiv", -150];
publicVariable "SEN_approvalCiv";

missionNameSpace setVariable ["SEN_transportReady", 1];
if (isClass (configfile >> "CfgPatches" >> "task_force_radio")) then {call compile preprocessFileLineNumbers "scripts\SEN_tfrSettings.sqf"};
[2000,0,false,100,2600,2600] call compile preprocessFileLineNumbers "scripts\zbe_cache\main.sqf";

if !(getMarkerColor "SEN_med_mrk" isEqualTo "") then {
    _med = ["Land_Hospital_main_F", "Land_Hospital_side2_F", "Land_Hospital_side1_F", "Land_Medevac_house_V1_F", "Land_Medevac_HQ_V1_F"];
    {
        if ((typeOf _x) in _med) then {_x setvariable["ace_medical_isMedicalFacility", true, true]};
    } forEach ((getMarkerPos "SEN_med_mrk") nearObjects ["House", 100]);
};

waitUntil {sleep 1; SEN_complete isEqualTo 2};

[] call compile preprocessFileLineNumbers "scripts\SEN_occupyTrg.sqf";
[] spawn compile preprocessFileLineNumbers "tasks\SEN_taskHandler.sqf";
[((SEN_range*0.04) max 400),false] call compile preprocessFileLineNumbers "scripts\SEN_civ.sqf";
[((SEN_range*0.04) max 400),((ceil (SEN_range/512)) max 10) min 25] spawn compile preprocessFileLineNumbers "scripts\SEN_animal.sqf";

"SEN_approvalCiv" addPublicVariableEventHandler {
    profileNameSpace setVariable ["SEN_approvalCiv", _this select 1];
    saveProfileNamespace;
};

"JK_TicketSystem" addPublicVariableEventHandler {
    profileNamespace setVariable ["JK_TicketSystem", _this select 1];
    saveProfileNamespace;
};
addMissionEventHandler ["Ended", {
    profileNamespace setVariable ["JK_TicketSystem", JK_TicketSystem];
    saveProfileNamespace;
}];
