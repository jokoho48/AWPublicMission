/*
Author: SENSEI

Last modified: 8/14/2015

Description: spawns rebel force on player or FOB
__________________________________________________________________*/
if (!isServer) exitWith {};

_taskID = format["%1_rebel_civ",time];
_taskText = "Defend FOB Against Rebel Attack";
_taskDescription = "Aerial reconnaissance shows several hostile civilians advancing towards FOB Pirelli. Defend the FOB against the rebel attack!";

_sleep = 2700;
if (isNil "SEN_fnc_rebelTastCiv") then {
    SEN_fnc_rebelTastCiv = compile preprocessFileLineNumbers "tasks\SEN_task_rebel_civ.sqf";
};

if (random 100 < ((call SEN_fnc_getApproval) select 1)) exitWith {
    [0,"Rebel task skipped."] call SEN_fnc_log;
    sleep _sleep;
    [] spawn SEN_fnc_rebelTastCiv;
};

if (!(getMarkerColor "sen_fob_mrk" isEqualTo "") && random 100 < 40) then {
    _targetPos = getPosATL SEN_flagFOB;
    _spawnPos = [_targetPos,1000,1200] call SEN_fnc_findRandomPos;

    if !(([_spawnPos,800] call SEN_fnc_getNearPlayers) isEqualTo [] && !(surfaceIsWater _spawnPos)) then {
        while {(([_spawnPos,800] call SEN_fnc_getNearPlayers) isEqualTo [] && !(surfaceIsWater _spawnPos))} do {
            _spawnPos = [_targetPos,1000,1200] call SEN_fnc_findRandomPos;
        };
    };

    if ([_spawnPos,"SEN_safezone_mrk"] call SEN_fnc_checkInMarker) exitWith {
        [1,"Rebel spawn or target position in safezone."] call SEN_fnc_log;
        sleep _sleep;
        [] spawn SEN_fnc_rebelTastCiv;
    };

    _rebelGrp = [_spawnPos,0,((call SEN_fnc_setStrength) max 5) min 1,RESISTANCE] call SEN_fnc_spawnGroup;
    _rebelGrp = [units _rebelGrp] call SEN_fnc_setSide;

    if(SEN_debug isEqualTo 1) then {
        _mrkPatrol = createMarker [format["SEN_rebel_%1",time],getposATL leader _rebelGrp];
        _mrkPatrol setMarkerType "o_unknown";
        _mrkPatrol setMarkerColor "ColorCIV";
        _mrkPatrol setMarkerText "rebel";
    };
    _wp = _rebelGrp addWaypoint [_targetPos, 0];
    _wp setWaypointType "SAD";
    _wp setWaypointSpeed "FULL";
    _wp setWaypointCombatMode "RED";

    [0,"Rebel target: FOB Pirelli: POSITION: %1",_targetPos] call SEN_fnc_log;
    [WEST,[_taskID],[_taskDescription, _taskText, ""],_targetPos,false,2,true,"C",false] call BIS_fnc_taskCreate;

    waitUntil {sleep 10; {alive _x} count units _rebelGrp isEqualTo 0 || ((leader _rebelGrp) distance _targetPos < 20)};

    if ((leader _rebelGrp) distance _targetPos < 20) exitWith {
        (leader _rebelGrp) playMoveNow "AinvPknlMstpSlayWrflDnon_medic";
        sleep 2;
        createVehicle ["R_TBG32V_F", _targetPos,[],0,"CAN_COLLIDE"];
        {if (random 1 > 0.5) then {createVehicle ["R_TBG32V_F", getposATL _x,[],0,"CAN_COLLIDE"]}; _x setDamage 1} foreach (curatorEditableObjects SEN_curatorFOB);
        sleep 8;
        call SEN_fnc_fobDelete;
        [_taskID, "FAILED"] call BIS_fnc_taskSetState;
        SEN_objectCleanup append (units _rebelGrp);
        sleep _sleep;
        [] spawn SEN_fnc_rebelTastCiv;
    };

    [_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;

    JK_TicketSystem = JK_TicketSystem + 100;
    publicVariable "JK_TicketSystem";

    SEN_approvalCiv = SEN_approvalCiv + 10; publicVariable "SEN_approvalCiv";
    sleep _sleep;
    [] spawn SEN_fnc_rebelTastCiv;
} else {
    private "_tar";

    _taskText = "Defend Against Rebel Attack";
    _taskDescription = "Aerial reconnaissance shows several hostile civilians advancing towards your position. Defend yourself against the rebel attack!";
    _playerArray = [];

    {if (alive _x) then {_playerArray pushBack _x}} forEach (call SEN_fnc_getPlayers);

    if (count _playerArray isEqualTo 0) exitWith {
        [2,"Rebel target array is empty."] call SEN_fnc_log;
        sleep _sleep;
        [] spawn SEN_fnc_rebelTastCiv;
    };
    _tar = _playerArray select (random ((count _playerArray) - 1));

    if (isNull _tar || {(getposATL _tar select 2) > 5}) exitWith {
        [2,"Rebel target is unsuitable."] call SEN_fnc_log;
        sleep _sleep;
        [] spawn SEN_fnc_rebelTastCiv;
    };
    _spawnPos = [getposATL _tar,1000,1200] call SEN_fnc_findRandomPos;
    if !(([_spawnPos,800] call SEN_fnc_getNearPlayers) isEqualTo [] && !(surfaceIsWater _spawnPos)) then {
        while {(([_spawnPos,800] call SEN_fnc_getNearPlayers) isEqualTo [])&& !(surfaceIsWater _spawnPos)} do {
            _spawnPos = [getposATL _tar,1000,1200] call SEN_fnc_findRandomPos;
        };
    };
    if ([_spawnPos,"SEN_safezone_mrk"] call SEN_fnc_checkInMarker || {[getposATL _tar,"SEN_safezone_mrk"] call SEN_fnc_checkInMarker}) exitWith {
        [1,"Rebel spawn or target position in safezone."] call SEN_fnc_log;
        sleep _sleep;
        [] spawn SEN_fnc_rebelTastCiv;
    };
    _rebelGrp = [_spawnPos,0,((call SEN_fnc_setStrength) max 5) min 12,RESISTANCE] call SEN_fnc_spawnGroup;
    _rebelGrp = [units _rebelGrp] call SEN_fnc_setSide;

    if(SEN_debug isEqualTo 1) then {
        _mrkPatrol = createMarker [format["SEN_rebel_%1",time],getposATL leader _rebelGrp];
        _mrkPatrol setMarkerType "o_unknown";
        _mrkPatrol setMarkerColor "ColorCIV";
        _mrkPatrol setMarkerText "rebel";
    };

    _wp = _rebelGrp addWaypoint [getposATL _tar, 0];
    _wp setWaypointType "SAD";
    _wp setWaypointSpeed "FULL";
    _wp setWaypointCombatMode "RED";

    [0,"Rebel target: %1",name _tar] call SEN_fnc_log;
    [WEST,[_taskID],[_taskDescription, _taskText, ""],getposATL _tar,false,2,true,"C",false] call BIS_fnc_taskCreate;

    waitUntil {sleep 10; isNull _tar || {alive _x} count units _rebelGrp isEqualTo 0 || ((getposATL _tar distance getposATL (leader _rebelGrp) > 1000) && !(isPlayer((leader _rebelGrp) findNearestEnemy (leader _rebelGrp))))};

    if (((getposATL _tar distance getposATL (leader _rebelGrp) > 1000) && !(isPlayer((leader _rebelGrp) findNearestEnemy (leader _rebelGrp)))) || {isNull _tar}) exitWith {
        [_taskID, "CANCELED"] call BIS_fnc_taskSetState;
        SEN_objectCleanup append (units _rebelGrp);
        sleep _sleep;
        [] spawn SEN_fnc_rebelTastCiv;
    };

    [_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;

    JK_TicketSystem = JK_TicketSystem + 200;
    publicVariable "JK_TicketSystem";

    SEN_approvalCiv = SEN_approvalCiv + 15;
    publicVariable "SEN_approvalCiv";
    sleep _sleep;
    [] spawn SEN_fnc_rebelTastCiv;
};
