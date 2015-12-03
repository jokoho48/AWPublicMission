/*
Author: SENSEI

Last modified: 8/14/2015

Description: defend supply cache
__________________________________________________________________*/
if (!isServer) exitWith {};

private ["_townName", "_townPos", "_townSize", "_avgTownSize", "_task", "_defendTown", "_cachePool", "_posCache", "_roads", "_cacheArray", "_vehArray", "_c", "_cache", "_pos", "_dir", "_transport", "_grpWest", "_e", "_posEnemy", "_grp", "_vehEnemy", "_count", "_taskDescription"];

_taskID = "defend";
_taskText = "Defend Cache";

if !(getMarkerColor "sen_fob_mrk" isEqualTo "") then {
    _townName = "FOB Pirelli";
    _townPos = [getmarkerpos "SEN_fob_mrk",10,25] call SEN_fnc_findRandomPos;
    _townSize = getmarkersize "SEN_fob_border_mrk";
    _avgTownSize = (((_townSize select 0) + (_townSize select 1))/2);
    missionNameSpace setVariable ["SEN_fobLock", true];
    _taskDescription = format ["A few hours ago, Command dispatched a convoy to %1. Upon arrival, the convoy was attacked by enemy forces. We have intel that our soldiers are holding out, but we're sending your team in to assist. Protect the supply cache and minimize friendly casualties.",_townName];
} else {
    _defendTown = SEN_whitelistLocation call BIS_fnc_selectRandom;
    _townPos = getpos _defendTown;
    while {(([_townPos, 3000] call SEN_fnc_getNearPlayers) isEqualTo [])} do {
        _defendTown = SEN_whitelistLocation call BIS_fnc_selectRandom;
        _townPos = getpos _defendTown;
    };
    _townName = text _defendTown;
    _townSize = size _defendTown;
    _avgTownSize = (((_townSize select 0) + (_townSize select 1))/2);
    _taskDescription = format ["Yesterday, FOB Falken sent in a request for supplies. A few hours ago, Command dispatched a convoy enroute to Falken. Somewhere in %1, the convoy was attacked by enemy forces. We have intel that our soldiers are holding out, but we're sending your team in to assist. Protect the supply cache and minimize friendly casualties.",_townName];
};


_townPos set [2,0];
_cachePool = ["Box_FIA_Wps_F","Box_NATO_AmmoVeh_F"];
_posCache = [_townPos,0,(_avgTownSize/2)] call SEN_fnc_findRandomPos;
_roads = _posCache nearRoads 50;
_cacheArray = [];
_vehArray = [];

for "_c" from 0 to 2 do {
    _cache = (_cachePool call BIS_fnc_selectRandom) createVehicle _posCache;
    _cache allowDamage false;
    _cache setVectorUp [0,0,1];
    _cacheArray pushBack _cache;

    if (count _roads isEqualTo 0) then {
        _pos = [_posCache, 5, 50, 3, 0, 0.5, 0] call BIS_fnc_findSafePos;
        _dir = random 360;
    } else {
        _pos = getposATL (_roads select _c);
        _dir = getDir (_roads select _c);
    };
    _transport = "B_Truck_01_box_F" createVehicle [0,0,0];
    _transport setDir _dir;
    _transport setpos _pos;
    _transport lock true;
    _vehArray pushBack _transport;
};

_grpWest = [_posCache,0,4,WEST] call SEN_fnc_spawnGroup;
[_grpWest] spawn SEN_fnc_setPatrolGroup;

[WEST,[_taskID],[_taskDescription, _taskText, ""],_posCache,false,2,true,"Defend",false] call BIS_fnc_taskCreate;

waitUntil {sleep 10; (({_x distance _posCache < 50 && (getposATL _x select 2) < 2} count (call SEN_fnc_getPlayers)) > 0)};

sleep 30;

for "_e" from 3 to 1 step -1 do {
    _posEnemy = [_posCache,300,400] call SEN_fnc_findRandomPos;
    _grp = [_posEnemy,0,((call SEN_fnc_setStrength) max 5) min (round (25/_e)),SEN_enemySide] call SEN_fnc_spawnGroup;

    if (_e isEqualTo 1) then {
        _vehEnemy = [_posEnemy,1,1,SEN_enemySide] call SEN_fnc_spawnGroup;
        (group (_vehEnemy select 0)) move _posCache;
        (vehicle (_vehEnemy select 0)) forceSpeed ((vehicle (_vehEnemy select 0)) getSpeed "SLOW");
        _vehArray pushBack (_vehEnemy select 0);
    };

    _wp = _grp addWaypoint [_posCache, 0];
    _wp setWaypointType "SAD";
    _wp setWaypointSpeed "FULL";
    _wp setWaypointCombatMode "RED";
    _count = ceil ((count (units _grp))*0.30);

    [0,"Defend Supply Cache: Remaining waves %1, Wave count: %2, Wave threshold: %3",abs (1 - _e),count (units _grp), _count] call SEN_fnc_log;

    waitUntil {sleep 10; (({alive _x} count (units _grp)) <= _count) || (({_x distance _posCache < 20} count (units _grp)) > 0)};

    if (({_x distance _posCache < 20} count (units _grp)) > 0) exitWith {};
};

if (({_x distance _posCache < 20} count (units _grp)) > 0) exitWith {
    {
        if (_x distance _posCache < 20) exitWith {
            _x playMoveNow "AinvPknlMstpSlayWrflDnon_medic";
            sleep 2;
            createVehicle ["R_TBG32V_F", _posCache,[],0,"CAN_COLLIDE"];
            sleep 0.5;
            createVehicle ["R_TBG32V_F", _posCache,[],0,"CAN_COLLIDE"];
        };
        nil
    } count (units _grp);

    missionNameSpace setVariable ["SEN_fobLock", false];
    [_taskID, "FAILED"] call BIS_fnc_taskSetState;
    {
        deleteVehicle _x;
        nil
    } count _cacheArray;
    SEN_objectCleanup append _vehArray;
    SEN_objectCleanup append (units _grp);
    SEN_objectCleanup append (units _grpWest);
    [] call SEN_fnc_setTask;
};

missionNameSpace setVariable ["SEN_fobLock", false];
[_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;

JK_TicketSystem = JK_TicketSystem + 400;
publicVariable "JK_TicketSystem";

SEN_objectCleanup append _cacheArray;
SEN_objectCleanup append _vehArray;
SEN_objectCleanup append (units _grp);
SEN_objectCleanup append (units _grpWest);
[] call SEN_fnc_setTask;
