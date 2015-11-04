/*
Author: SENSEI

Last modified: 8/14/2015

Description: stabilize injured civilians and transport to medical station
__________________________________________________________________*/
if (!isServer) exitWith {};

private ["_roads","_part","_size","_count","_civ","_ambush","_rebelWeapon","_rebelMag","_pos","_grp","_vehPos","_damage","_town"];

_ambush = false;
_wreckArray = ["Land_Wreck_Truck_dropside_F","Land_Wreck_Truck_F","Land_Wreck_UAZ_F","Land_Wreck_Ural_F","Land_Wreck_Van_F","Land_Wreck_Skodovka_F","Land_Wreck_CarDismantled_F","Land_Wreck_Car3_F","Land_Wreck_Car_F"];
_town = SEN_whitelistLocation select (random ((count SEN_whitelistLocation) - 1));
_pos = [getpos _town,300,1000] call SEN_fnc_findRandomPos;
while {(([_pos, 2000] call SEN_fnc_getNearPlayers) isEqualTo [] && !(surfaceIsWater _pos))} do {
    _town = SEN_whitelistLocation select (random ((count SEN_whitelistLocation) - 1));
    _pos = [getpos _town,300,1000] call SEN_fnc_findRandomPos;
};

_taskID = format["%1_stabilize_civ",SEN_taskCounterCiv];
_taskText = "Stabilize Civilian";
_taskDescription = format["Aerial reconnaissance shows a civilian was attacked by enemy sympathizers at grid (%1) near %2. Local officials request that we provide immediate medical attention and transport the civilian to Dodge Medical Center. This is an important task that will get the local population on our side.",mapGridPosition _pos, text _town];

_vehType = _wreckArray select (random ((count _wreckArray) - 1));
_roads = _pos nearRoads 50;
if !(count _roads isEqualTo 0) then {_vehPos = getposATL (_roads select 0);} else {_vehPos = [_pos,8,35] call SEN_fnc_findRandomPos;};
_veh = _vehType createVehicle _vehPos;
_veh setDir random 360;
_veh setVectorUp surfaceNormal position _veh;
_fx = "test_EmptyObjectForFireBig" createVehicle (getposATL _veh);
_fx attachTo [_veh,[0,0,0]];
_civ = (createGroup CIVILIAN) createUnit [SEN_unitPoolCiv select (random ((count SEN_unitPoolCiv) - 1)),_pos, [], 0, "NONE"];
_civ setBehaviour "CARELESS";
_civ setDir random 360;
_civ switchMove "AinjPpneMstpSnonWrflDnon";
_civ disableAI "ANIM";

if (random 1 < 0.7) then {
    _ambush = true;
    _grp = [([_pos,200,300] call SEN_fnc_findRandomPos),0,((call SEN_fnc_setStrength) max 5) min 15,RESISTANCE,true] call SEN_fnc_spawnGroup;
    _grp = [units _grp] call SEN_fnc_setSide;
};

[WEST,[_taskID],[_taskDescription, _taskText, ""],_vehPos,false,1,true,"C",false] call BIS_fnc_taskCreate;

waitUntil {sleep 10; (({_x distance _pos < 50 && (getposATL _x select 2) < 2} count (call SEN_fnc_getPlayers)) > 0)};

if (ace_medical_level isEqualTo 1) then {
    _part = [
        "HitHead",
        "HitBody",
        "HitLeftArm",
        "HitRightArm",
        "HitLeftLeg",
        "HitRightLeg"
    ];
    for "_i" from 0 to ceil random 2 do {
        _damage = 0.3 + (random 0.65);
        [_civ, (_part select (random ((count _part) - 1))), _damage] call ace_medical_fnc_setHitPointDamage;
    };
    [_civ,true,10,true] call ace_medical_fnc_setUnconscious;
} else {
    [_civ,true,10,true] call ace_medical_fnc_setUnconscious; // can't force unconsciousness through cardiacArrest, so need to set unconscious first
    [_civ] call ace_medical_fnc_setCardiacArrest;
};

if (_ambush) then {
    {_x setUnitPos "UP";} foreach units _grp;
    _wp = _grp addWaypoint [_pos, 0];
    _wp setWaypointType "SAD";
    _wp setWaypointSpeed "FULL";
    _wp setWaypointCombatMode "RED";
};

waitUntil {sleep 10; (!alive _civ || (_civ getVariable ["ace_captives_ishandcuffed", false]))};

if (alive _civ) then {
    _taskText = "Escort Civilian";

    [_taskID] call BIS_fnc_taskSetCurrent;
    [_taskID,[_taskDescription,_taskText,""]] call BIS_fnc_taskSetDescription;
    [_taskID,(getmarkerpos "SEN_med_mrk")] call BIS_fnc_taskSetDestination;

    waitUntil {sleep 10; (!alive _civ || ((_civ distance (getmarkerpos "SEN_med_mrk") < 25) && (alive _civ) && ([_civ] call ace_common_fnc_isAwake)))};
};

if !(alive _civ) exitWith {
    [_taskID, "FAILED"] call BIS_fnc_taskSetState;
    {if (typeOf _x isEqualTo "#particlesource") then {deleteVehicle _x}} forEach (_vehPos nearObjects 100);
    SEN_objectCleanup append [_civ,_veh];
    sleep SEN_taskSleepCiv;
    [] call SEN_fnc_setTaskCiv;
};

[_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;

JK_TicketSystem = JK_TicketSystem + 200;
publicVariable "JK_TicketSystem";

SEN_approvalCiv = SEN_approvalCiv + (15 + random 5);
publicVariable "SEN_approvalCiv";

{if (typeOf _x isEqualTo "#particlesource") then {deleteVehicle _x}} forEach (_vehPos nearObjects 100);
SEN_objectCleanup append [_civ,_veh];
sleep SEN_taskSleepCiv;
[] call SEN_fnc_setTaskCiv;
