/*
@file: QS_fnc_AOenemy.sqf
Author:

    Quiksilver (credits: Ahoyworld.co.uk. Rarek et al for AW_fnc_spawnUnits.)

Last modified:

        24/10/2014 ArmA 1.32 by Quiksilver

Description:

    AO enemies
__________________________________________________________________*/

//---------- CONFIG

#define INF_TEAMS "rhs_group_rus_msv_infantry_squad","rhs_group_rus_msv_infantry_fireteam","rhs_group_rus_msv_infantry_squad_2mg","rhs_group_rus_msv_infantry_squad_sniper","rhs_group_rus_msv_infantry_section_mg"
#define INF_URBANTYPE "rhs_msv_sergeant","rhs_msv_rifleman","rhs_msv_grenadier","rhs_msv_at","rhs_msv_strelok_rpg_assist","rhs_msv_aa"
#define MRAP_TYPE "rhs_gaz66_msv","rhs_gaz66o_msv"
#define VEH_TYPE "rhs_sprut_vdv", "RHS_BM21_MSV_01", "rhs_bmd1", "rhs_bmd2", "rhs_bmd4_vdv", "rhs_bmp1_XX", "rhs_bmp2e_XX", "rhs_brm1k_msv", "rhs_btr60_msv", "rhs_btr70_msv", "rhs_btr80_msv", "rhs_prp3_msv", "rhs_t72ba_tv", "rhs_t80", "rhs_zsu234_aa","rhs_tigr_msv", "rhs_gaz66_msv", "rhs_typhoon_vdv", "rhs_uaz_XX", "rhs_ural_XX", "rhs_ural_open_XX", "RHS_Ural_Fuel_XX_01"
#define AIR_TYPE "RHS_Ka52_vvs", "RHS_Mi24P_vdv", "RHS_Mi8AMT_vdv", "RHS_Mi8mt_vdv", "RHS_Su25SM_vvs"
#define STATIC_TYPE "rhs_weap_2p130", "rhs_weap_902a"

private ["_enemiesArray","_randomPos","_patrolGroup","_AOvehGroup","_AOveh","_AOmrapGroup","_AOmrap","_pos","_spawnPos","_overwatchGroup","_x","_staticGroup","_static","_aaGroup","_aa","_airGroup","_air","_sniperGroup","_staticDir"];
_pos = getMarkerPos (_this select 0);
_enemiesArray = [grpNull];
_x = 0;
//---------- AA VEHICLE

for "_x" from 1 to PARAMS_AAPatrol do {
    _aaGroup = createGroup east;
    _randomPos = [[[getMarkerPos currentAO, (PARAMS_AOSize / 2)],[]],["water","out"]] call BIS_fnc_randomPos;
    _aa = "O_APC_Tracked_02_AA_F" createVehicle _randomPos;
    waitUntil{!isNull _aa};
    _aa allowCrewInImmobile true;
        "O_engineer_F" createUnit [_randomPos,_aaGroup];
        "O_engineer_F" createUnit [_randomPos,_aaGroup];
        "O_engineer_F" createUnit [_randomPos,_aaGroup];
        ((units _aaGroup) select 0) assignAsDriver _aa;
        ((units _aaGroup) select 0) moveInDriver _aa;
        ((units _aaGroup) select 1) assignAsGunner _aa;
        ((units _aaGroup) select 1) moveInGunner _aa;
        ((units _aaGroup) select 2) assignAsCommander _aa;
        ((units _aaGroup) select 2) moveInCommander _aa;
    [_aaGroup, getMarkerPos currentAO, 500] call BIS_fnc_taskPatrol;
    _aa lock 3;

    _enemiesArray = _enemiesArray + [_aaGroup];
    sleep 0.1;
    _enemiesArray = _enemiesArray + [_aa];

    {
        _x addCuratorEditableObjects [[_aa], false];
        _x addCuratorEditableObjects [units _aaGroup, false];
    } foreach adminCurators;

};

//---------- INFANTRY PATROLS RANDOM

for "_x" from 1 to PARAMS_GroupPatrol do {
    _patrolGroup = createGroup east;
    _randomPos = [[[getMarkerPos currentAO, (PARAMS_AOSize / 1.2)],[]],["water","out"]] call BIS_fnc_randomPos;
    _patrolGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "MSV (BMP-1)" >> [INF_TEAMS] call BIS_fnc_selectRandom)] call BIS_fnc_spawnGroup;
    [_patrolGroup, getMarkerPos currentAO, 400] call BIS_fnc_taskPatrol;

    _enemiesArray = _enemiesArray + [_patrolGroup];

    {
        _x addCuratorEditableObjects [units _patrolGroup, false];
    } foreach adminCurators;

};

//---------- STATIC WEAPONS

for "_x" from 1 to PARAMS_StaticMG do {
    _staticGroup = createGroup east;
    _randomPos = [getMarkerPos currentAO, 200, 10, 10] call BIS_fnc_findOverwatch;
    _static = [STATIC_TYPE] call BIS_fnc_selectRandom createVehicle _randomPos;
    waitUntil{!isNull _static};
    _static setDir random 360;
        "O_support_MG_F" createUnit [_randomPos,_staticGroup];
        ((units _staticGroup) select 0) assignAsGunner _static;
        ((units _staticGroup) select 0) moveInGunner _static;
    _staticGroup setBehaviour "COMBAT";
    _staticGroup setCombatMode "RED";
    _static setVectorUp [0,0,1];
    _static lock 3;

    _enemiesArray = _enemiesArray + [_staticGroup];
    sleep 0.1;
    _enemiesArray = _enemiesArray + [_static];

    {
        _x addCuratorEditableObjects [[_static], false];
        _x addCuratorEditableObjects [units _staticGroup, false];
    } foreach adminCurators;
};

//---------- INFANTRY OVERWATCH

for "_x" from 1 to PARAMS_Overwatch do {
    _overwatchGroup = createGroup east;
    _randomPos = [getMarkerPos currentAO, 600, 50, 10] call BIS_fnc_findOverwatch;
    _overwatchGroup = [_randomPos, East, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> [INF_URBANTYPE] call BIS_fnc_selectRandom)] call BIS_fnc_spawnGroup;
    [_overwatchGroup, _randomPos, 100] call BIS_fnc_taskPatrol;

    _enemiesArray = _enemiesArray + [_overwatchGroup];

    {
        _x addCuratorEditableObjects [units _overwatchGroup, false];
    } foreach adminCurators;

};

//--------- MRAP

for "_x" from 0 to 1 do {
    _AOmrapGroup = createGroup east;
    _randomPos = [[[getMarkerPos currentAO, PARAMS_AOSize],[]],["water","out"]] call BIS_fnc_randomPos;
    _AOmrap = [MRAP_TYPE] call BIS_fnc_selectRandom createVehicle _randomPos;
    waitUntil {!isNull _AOmrap};
        "O_engineer_F" createUnit [_randomPos,_AOmrapGroup];
        "O_engineer_F" createUnit [_randomPos,_AOmrapGroup];
        "O_engineer_F" createUnit [_randomPos,_AOmrapGroup];
        ((units _AOmrapGroup) select 0) assignAsDriver _AOmrap;
        ((units _AOmrapGroup) select 0) moveInDriver _AOmrap;
        ((units _AOmrapGroup) select 1) assignAsGunner _AOmrap;
        ((units _AOmrapGroup) select 1) moveInGunner _AOmrap;
        ((units _AOmrapGroup) select 2) assignAsCargo _AOmrap;
        ((units _AOmrapGroup) select 2) moveInCargo _AOmrap;
    [_AOmrapGroup, getMarkerPos currentAO, 600] call BIS_fnc_taskPatrol;
    _AOmrap lock 3;
    if (random 1 >= 0.3) then {
        _AOmrap allowCrewInImmobile true;
    };

    _enemiesArray = _enemiesArray + [_AOmrapGroup];
    sleep 0.1;
    _enemiesArray = _enemiesArray + [_AOmrap];

    {
        _x addCuratorEditableObjects [[_AOmrap], false];
        _x addCuratorEditableObjects [units _AOmrapGroup, false];
    } foreach adminCurators;


};

//---------- GROUND VEHICLE RANDOM

for "_x" from 0 to (3 + (random 2)) do {
    _AOvehGroup = createGroup east;
    _randomPos = [[[getMarkerPos currentAO, PARAMS_AOSize],[]],["water","out"]] call BIS_fnc_randomPos;
    _AOveh = [VEH_TYPE] call BIS_fnc_selectRandom createVehicle _randomPos;
    waitUntil{!isNull _AOveh};
    if (random 1 >= 0.25) then {
        _AOveh allowCrewInImmobile true;
    };
        "O_engineer_F" createUnit [_randomPos,_AOvehGroup];
        "O_engineer_F" createUnit [_randomPos,_AOvehGroup];
        "O_engineer_F" createUnit [_randomPos,_AOvehGroup];
        ((units _AOvehGroup) select 0) assignAsDriver _AOveh;
        ((units _AOvehGroup) select 0) moveInDriver _AOveh;
        ((units _AOvehGroup) select 1) assignAsGunner _AOveh;
        ((units _AOvehGroup) select 1) moveInGunner _AOveh;
        ((units _AOvehGroup) select 2) assignAsCommander _AOveh;
        ((units _AOvehGroup) select 2) moveInCommander _AOveh;
    [_AOvehGroup, getMarkerPos currentAO, 400] call BIS_fnc_taskPatrol;
    _AOveh lock 3;

    _enemiesArray = _enemiesArray + [_AOvehGroup,_AOveh];
    sleep 0.1;
    _enemiesArray = _enemiesArray + [_AOveh];

    {
        _x addCuratorEditableObjects [[_AOveh], false];
        _x addCuratorEditableObjects [units _AOvehGroup, false];
    } foreach adminCurators;

};

//---------- HELICOPTER

if((random 10 <= PARAMS_AirPatrol)) then {
    _airGroup = createGroup east;
    _randomPos = [[[getMarkerPos currentAO, PARAMS_AOSize],_dt],["water","out"]] call BIS_fnc_randomPos;
    _air = [AIR_TYPE] call BIS_fnc_selectRandom createVehicle [_randomPos select 0,_randomPos select 1,1000];
    waitUntil{!isNull _air};
    _air engineOn true;
    _air setPos [_randomPos select 0,_randomPos select 1,300];

    _air spawn
    {
        private["_x"];
        for [{_x=0},{_x<=200},{_x=_x+1}] do
        {
            _this setVelocity [0,0,0];
            sleep 0.1;
        };
    };

        "O_helipilot_F" createUnit [_randomPos,_airGroup];
        ((units _airGroup) select 0) assignAsDriver _air;
        ((units _airGroup) select 0) moveInDriver _air;
        "O_helipilot_F" createUnit [_randomPos,_airGroup];
        ((units _airGroup) select 1) assignAsGunner _air;
        ((units _airGroup) select 1) moveInGunner _air;

    [_airGroup, getMarkerPos currentAO, 800] call BIS_fnc_taskPatrol;
    [(units _airGroup)] call QS_fnc_setSkill2;
    _air flyInHeight 300;
    _airGroup setCombatMode "RED";
    _air lock 3;

    _enemiesArray = _enemiesArray + [_airGroup];
    sleep 0.1;
    _enemiesArray = _enemiesArray + [_air];

    {
        _x addCuratorEditableObjects [[_air], false];
        _x addCuratorEditableObjects [units _airGroup, false];
    } foreach adminCurators;

};

//---------- SNIPERS

for "_x" from 1 to PARAMS_SniperTeamsPatrol do {
    _sniperGroup = createGroup east;
    _randomPos = [getMarkerPos currentAO, 1200, 100, 10] call BIS_fnc_findOverwatch;
    _sniperGroup = [_randomPos, EAST,(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OI_SniperTeam")] call BIS_fnc_spawnGroup;
    _sniperGroup setBehaviour "COMBAT";
    _sniperGroup setCombatMode "RED";

    _enemiesArray = _enemiesArray + [_sniperGroup];

    {
        _x addCuratorEditableObjects [units _sniperGroup, false];
    } foreach adminCurators;

};

//============== JTAC, disabled temporarily

/*
jtacEASTGroup = createGroup east;
for "_x" from 1 to 3 do {
    _randomPos = [_pos,1200,500,10] call BIS_fnc_findOverwatch;

    "O_recon_JTAC_F" createUnit [_randomPos,jtacEASTGroup];

    jtacEASTGroup setBehaviour "COMBAT";
    jtacEASTGroup setCombatMode "RED";
    jtacEASTGroup setSpeedMode "FULL";
};
[(units jtacEASTGroup)] call QS_fnc_setSkill4;
_enemiesArray set [count _enemiesArray,jtacEASTGroup];
{_x setRank "COLONEL";} count (units jtacEASTGroup);
{_x addCuratorEditableObjects [units jtacEASTGroup,false];} count allCurators;
*/

//=========== ENEMIES IN BUILDINGS

if (PARAMS_EnemiesInBuildings != 0) then {
    _town = _pos nearObjects ["House",500];
    if ((count _town) > 6) then {
        _indArray = getArray (missionConfigFile >> "faction" >> "ind" >> "units");
        _toSpawn = [];
        for [{_i = 0}, {_i < PARAMS_EnemiesInBuildings}, {_i = _i + 1}] do {
            _randomUnit = _indArray select (floor (random (count _indArray)));
            0 = _toSpawn pushBack _randomUnit;
        };
        _AOgarrisonGroup = createGroup resistance;
        _AOgarrisonGroup = [_pos,RESISTANCE,_toSpawn] call BIS_fnc_spawnGroup;
        0 = [_pos,units _AOgarrisonGroup,500,0,[0,20],true,true] call SHK_fnc_buildingPos02;
        [(units _AOgarrisonGroup)] call QS_fnc_setSkill2;

        {_x addCuratorEditableObjects [(units _AOgarrisonGroup),false];} count allCurators;

        _enemiesArray set [count _enemiesArray,_AOgarrisonGroup];
    };
};

//---------- COMMON

[(units _patrolGroup)] call QS_fnc_setSkill1;
[(units _overwatchGroup)] call QS_fnc_setSkill2;
[(units _AOvehGroup)] call QS_fnc_setSkill2;
if (random 1 >= 0.5) then {
    [(units _sniperGroup)] call QS_fnc_setSkill4;
} else {
    [(units _sniperGroup)] call QS_fnc_setSkill3;
};
[(units _staticGroup)] call QS_fnc_setSkill3;
[(units _aaGroup)] call QS_fnc_setSkill4;

//---------- GARRISON FORTIFICATIONS

{
    _newGrp = [_x] call QS_fnc_garrisonFortEAST;
    if (!isNull _newGrp) then {
        _enemiesArray = _enemiesArray + [_newGrp];
    };
    {
        _x addCuratorEditableObjects [units _newGrp, false];
    } forEach adminCurators;
} forEach (getMarkerPos currentAO nearObjects ["House", 800]);

_enemiesArray;
