/*
Author: SENSEI

Last modified: 8/14/2015

Description: destroy artillery before time expires
__________________________________________________________________*/
if (!isServer) exitWith {};

_taskID = "arty";
_taskText = "Eliminate Artillery";
_taskDescription = "There is an imminent artillery barrage targeting MOB Dodge. Command is evacuating the base, but your team needs to disable the artillery immediately!";

if (worldName isEqualTo "Stratis") exitWith { // Stratis is too hilly
    SEN_taskList pushBack _taskID;
    SEN_taskCounter = SEN_taskCounter - 1;
    [] call SEN_fnc_setTask;
};

SEN_defused = false;
SEN_armed = false;
_artyRadius = 1200;
_artyArray = [];
_gunnerArray = [];
_posAdder = 10;
_gunnerGrp = createGroup SEN_enemySide;
_gunnerGrp setBehaviour "CARELESS";
_unitType = SEN_unitPool select 0;
_pos = [];

_pos = [SEN_centerPos,SEN_range,140] call SEN_fnc_findRuralFlatPos;
while {(([_pos, 2000] call SEN_fnc_getNearPlayers) isEqualTo [] && !(surfaceIsWater _pos))} do {
    _pos = [SEN_centerPos,SEN_range,140] call SEN_fnc_findRuralFlatPos;
};
if (_pos isEqualTo []) exitWith {
    SEN_taskList pushBack _taskID;
    SEN_taskCounter = SEN_taskCounter - 1;
    [] call SEN_fnc_setTask;
};

_grpArray = [_pos,SEN_enemySide,8,.5,2] call SEN_fnc_spawnSquad;
_grpArray params ["_baseArray", "_vehArray", "_grp"];
_posArty = getposATL ((nearestObjects [_pos, ["Land_DuctTape_F"], 200]) select 0);

for "_j" from 1 to 3 do {
    _arty = "rhs_2s3_tv" createVehicle [0,0,0];
    _arty allowDamage false;
    _arty setDir (getDir _arty - 70);
    if (count _artyArray > 0) then {
        _posArty = ((_artyArray select (count _artyArray - 1)) modelToWorld [10,0,0]);
        _posArty set [2,0];
        _arty setPosATL _posArty;
    } else {
        _arty setPosATL _posArty;
    };
    _arty setFuel 0;
    _arty lock true;
    _arty allowCrewInImmobile true;
    _arty addEventHandler ["HandleDamage", {if ((_this select 4) isKindof "PipeBombBase" && {(_this select 2) > 0.6}) then {(_this select 0) setdamage 1;}}];
    _artyArray pushBack _arty;
    _gunner = _gunnerGrp createUnit [_unitType, _pos, [], 0, "NONE"];
    _gunnerArray pushBack _gunner;
    _gunner assignAsGunner _arty;
    _gunner moveInGunner  _arty;
    _gunner setFormDir (getDir _arty);
    _gunner setDir (getDir _arty);
    _gunner doWatch (_gunner modelToWorld [0,100,30]);
    _gunner disableAI "MOVE";
    _gunner disableAI "ANIM";
    _gunner disableAI "FSM";
    _gunner disableAI "TARGET";
    _gunner disableAI "AUTOTARGET";
    _gunner disableAI "AIMINGERROR";
    _gunner disableAI "SUPPRESSION";
    sleep 1;
    _arty allowDamage true;
};

[_grp,100] spawn SEN_fnc_setPatrolGroup;
if !(count _vehArray isEqualTo 0) then {
    [group (_vehArray select 0),_pos,500] call BIS_fnc_taskPatrol;
};

_posMrk = [_pos,0,_artyRadius] call SEN_fnc_findRandomPos;
_mrkArty = createMarker ["SEN_arty_AO",_posMrk];
_mrkArty setMarkerColor "ColorRED";
_mrkArty setMarkerShape "ELLIPSE";
_mrkArty setMarkerAlpha 0.7;
_mrkArty setMarkerSize [_artyRadius,_artyRadius];

[WEST, [_taskID], [_taskDescription, _taskText, ""], _posMrk, false, 2, true, "Destroy", false] call BIS_fnc_taskCreate;

if(SEN_debug) then {
    [_taskID] call BIS_fnc_taskSetCurrent;
    [_taskID,_posArty] call BIS_fnc_taskSetDestination;
};

[_gunnerArray,getMarkerPos "respawn_west",3600] spawn SEN_fnc_timerArty;

waitUntil {sleep 10; SEN_armed || (({alive _x} count _artyArray) isEqualTo 0)};

if (SEN_armed) exitWith {
    [_taskID, "FAILED"] call BIS_fnc_taskSetState;

    for "_t" from 0 to 5 do {
        playSound3D ["A3\Sounds_F\sfx\alarm_independent.wss", SEN_alarmMOB];
        sleep 10;
    };

    SEN_objectCleanup append _artyArray;
    SEN_objectCleanup append _baseArray;
    SEN_markerCleanup pushBack _mrkArty;
    [] call SEN_fnc_setTask;
};

[_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
SEN_defused = true;

JK_TicketSystem = JK_TicketSystem + 600;
publicVariable "JK_TicketSystem";

SEN_objectCleanup append _artyArray;
SEN_objectCleanup append _baseArray;
SEN_markerCleanup pushBack _mrkArty;
[] call SEN_fnc_setTask;
