/*
Author: SENSEI

Last modified: 8/14/2015

Description: rescue civilians and escort to town safely.
__________________________________________________________________*/
if (!isServer) exitWith {};

private ["_pos","_houseArray"];

_wreckArray = ["Land_Wreck_Truck_dropside_F","Land_Wreck_Truck_F","Land_Wreck_UAZ_F","Land_Wreck_Ural_F","Land_Wreck_Van_F","Land_Wreck_Skodovka_F","Land_Wreck_CarDismantled_F","Land_Wreck_Car3_F","Land_Wreck_Car_F"];
_vehPos = [];
_pos = [];
_houseArray = [];
_returnTown = SEN_whitelistLocation call BIS_fnc_selectRandom;
_returnPos = getpos _returnTown;
_returnPos set [2,0];
if (worldName isEqualTo "Chernarus" || {worldName isEqualTo "Chernarus_Summer"}) then {
    _pos = [SEN_centerPos,SEN_range,10] call SEN_fnc_findRuralFlatPos;
} else {

    _houseArray = [SEN_centerPos,SEN_range] call SEN_fnc_findRuralHousePos;
    _pos = (_houseArray select 1);
    while {(([_pos, 3000] call SEN_fnc_getNearPlayers) isEqualTo [] && !(surfaceIsWater _pos))} do {
        _houseArray = [SEN_centerPos,SEN_range] call SEN_fnc_findRuralHousePos;
        _pos = (_houseArray select 1);
    };
};

if (_pos isEqualTo []) exitWith {
    [] call SEN_fnc_setTaskCiv;
};

_taskID = format["%1_rescue_civ",SEN_taskCounterCiv];
_taskText = "Rescue Hostage";
_taskDescription = format["We have intel that a civilian was taken hostage by enemy sympathizers at grid (%1). Local officials request that we rescue the civilian and escort him to %2. This is an important task that will get the local population on our side.",mapGridPosition _pos, text _returnTown];

_vehType = _wreckArray call BIS_fnc_selectRandom;
_roads = _pos nearRoads 50;

if !(count _roads isEqualTo 0) then {_vehPos = getposATL (_roads select 0);} else {_vehPos = [_pos,20,50,5,0,0.5,0] call BIS_fnc_findSafePos;};

_veh = _vehType createVehicle _vehPos;
_veh setDir random 360;
_veh setVectorUp surfaceNormal position _veh;
_fx = "test_EmptyObjectForFireBig" createVehicle (getposATL _veh);
_fx attachTo [_veh,[0,0,0]];
_hostage = (createGroup CIVILIAN) createUnit [SEN_unitPoolCiv call BIS_fnc_selectRandom,_pos, [], 0, "NONE"];
_hostage allowdamage false;
_hostage setDir random 360;
_pos set [2,0];
_grp = [_pos,0,((call SEN_fnc_setStrength) max 4) min 15,RESISTANCE,true] call SEN_fnc_spawnGroup;
_grp = [units _grp] call SEN_fnc_setSide;
[_grp,90] spawn SEN_fnc_setPatrolGroup;

sleep 3;

[_hostage] call SEN_fnc_setUnitHostage;
_hostage allowdamage true;

[WEST,[_taskID],[_taskDescription, _taskText, ""],_pos,false,1,true,"C",false] call BIS_fnc_taskCreate;

waitUntil {sleep 10; (_hostage getVariable ["ace_captives_ishandcuffed", false])};

if (alive _hostage) then {
    _taskText = "Escort Hostage";

    [_taskID] call BIS_fnc_taskSetCurrent;
    [_taskID,[_taskDescription,_taskText,""]] call BIS_fnc_taskSetDescription;
    [_taskID,_returnPos] call BIS_fnc_taskSetDestination;

    waitUntil {sleep 10; (((_hostage distance _returnPos) < 25 && (getposatl _hostage select 2 < 2)) || !alive _hostage)};
};

if (!alive _hostage) exitWith {
    [_taskID, "FAILED"] call BIS_fnc_taskSetState;
    {if (typeOf _x isEqualTo "#particlesource") then {deleteVehicle _x}} forEach (_vehPos nearObjects 100);
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

{if (typeOf _x isEqualTo "#particlesource") then {deleteVehicle _x}} forEach (_vehPos nearObjects 100);
SEN_objectCleanup pushBack _hostage;
SEN_objectCleanup pushBack _veh;
sleep SEN_taskSleepCiv;
[] call SEN_fnc_setTaskCiv;
