/*
Author: SENSEI

Last modified: 8/14/2015

Description: Search and Rescue a Helicopter Crew that got shoot down
__________________________________________________________________*/
scriptName "SEN_task_SAR_civ";
if (!isServer) exitWith {};

private ["_pos","_houseArray"];

_wreckArray = ["CUP_B_AH64D_USA", "CUP_B_AH64D_NO_USA", "CUP_B_AH64D_ES_USA"];
_vehPos = [];
_pos = [];
_houseArray = [];
_returnTown = selectRandom SEN_whitelistLocation;
_returnPos = getpos _returnTown;
_returnPos set [2,0];

_pos = [_returnPos, SEN_range, 10] call SEN_fnc_findRuralFlatPos;
while {(([_pos, 3000] call SEN_fnc_getNearPlayers) isEqualTo [] && (surfaceIsWater _pos))} do {
    _pos = [_returnPos, SEN_range, 10] call SEN_fnc_findRuralFlatPos;
};

if (_pos isEqualTo []) exitWith {
    [] call SEN_fnc_setTaskCiv;
};

_taskID = format["%1_SAR_civ", SEN_taskCounterCiv];
_taskText = "Search and Rescue";

_vehType = selectRandom _wreckArray;
_vehName = getText (configFile >> "CfgVehicles" >> _vehType >> "displayName");
_taskDescription = format["It was shot down a %3 near %1 (%2). The pilots had loud statements of defense, minister critical information with them and must Found and rescued.", mapGridPosition _pos, text _returnTown, _vehName];

_vehPos = [_pos, 20, 50, 5, 0, 0.5, 0] call BIS_fnc_findSafePos;

_veh = _vehType createVehicle _vehPos;
_veh setDir random 360;
_veh setVectorUp (surfaceNormal (position _veh));
_veh setDamage 1;
_veh setVariable ["SEN_noClean", true];

_fx = "test_EmptyObjectForFireBig" createVehicle (getposATL _veh);
_fx attachTo [_veh, [0, 0, 0]];
_fx setVariable ["SEN_noClean", true];

_hostage = (createGroup CIVILIAN) createUnit ["CUP_B_US_Pilot", _pos, [], 0, "NONE"];
_hostage allowdamage false;
_hostage setDir random 360;
_hostage setVariable ["SEN_noClean", true];
_hostage setCaptive true;

_pos set [2,0];
_grp = [_pos, 0, ((call SEN_fnc_setStrength) max 8) min 20, RESISTANCE, true] call SEN_fnc_spawnGroup;
_grp = [units _grp] call SEN_fnc_setSide;
[_grp,90] spawn SEN_fnc_setPatrolGroup;

sleep 3;

[_hostage] call SEN_fnc_setUnitHostage;
_hostage allowdamage true;

[WEST, [_taskID], [_taskDescription, _taskText, ""], _pos, false, 1, true, "C", false] call BIS_fnc_taskCreate;

waitUntil {sleep 10; !alive _hostage || (_hostage getVariable ["ace_captives_ishandcuffed", false])};

if (alive _hostage) then {
    _taskText = "Escort Wounded Pilot";

    [_taskID] call BIS_fnc_taskSetCurrent;
    [_taskID, [_taskDescription, _taskText, ""]] call BIS_fnc_taskSetDescription;
    [_taskID, getMarkerPos "SEN_med_mrk_1"] call BIS_fnc_taskSetDestination;

    waitUntil {sleep 10; (((_hostage distance2D (getMarkerPos "SEN_med_mrk_1")) < 5) || !alive _hostage)};
};

if (!alive _hostage) exitWith {
    [_taskID, "FAILED"] call BIS_fnc_taskSetState;
    {
        if ((typeOf _x) isEqualTo "#particlesource") then {
            deleteVehicle _x;
        };
        nil
    } count (_vehPos nearObjects 100);
    SEN_objectCleanup pushBack _hostage;
    SEN_objectCleanup pushBack _veh;
    sleep SEN_taskSleepCiv;
    [] call SEN_fnc_setTaskCiv;
};

[_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;

JK_TicketSystem = JK_TicketSystem + 300;
publicVariable "JK_TicketSystem";

SEN_approvalCiv = SEN_approvalCiv + (10 + random 5);
publicVariable "SEN_approvalCiv";

{
    if (typeOf _x isEqualTo "#particlesource") then {
        deleteVehicle _x;
    };
    nil
} count (_vehPos nearObjects 100);

SEN_objectCleanup pushBack _hostage;
SEN_objectCleanup pushBack _veh;

sleep SEN_taskSleepCiv;
[] call SEN_fnc_setTaskCiv;
