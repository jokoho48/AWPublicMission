/*
Author: SENSEI

Last modified: 8/14/2015

Description: rescue vip
__________________________________________________________________*/
if (!isServer) exitWith {};

private ["_houseArray","_posVIP"];

_taskID = "vip";
_taskText = "Rescue VIP";
_taskDescription = "We have intel that the son of a local elder has been taken hostage by enemy forces.<br/><br/>Locate the VIP and safely return him to headquarters at MOB Dodge.";

_houseArray = [];
_posVIP = [];

if (worldName isEqualTo "Chernarus" || {worldName isEqualTo "Chernarus_Summer"}) then {
    _posVIP = [SEN_centerPos,SEN_range,10] call SEN_fnc_findRuralFlatPos;
} else {
    _houseArray = [SEN_centerPos,SEN_range] call SEN_fnc_findRuralHousePos;
    _posVIP = (_houseArray select 1);
};

if (_posVIP isEqualTo []) exitWith {
    SEN_taskList pushBack _taskID;
    SEN_taskCounter = SEN_taskCounter - 1;
    [] call SEN_fnc_setTask;
};

_vipGrp = [_posVIP,0,1,RESISTANCE] call SEN_fnc_spawnGroup;
_vip = leader _vipGrp;
_vip allowDamage false;
_grpArray = [([_posVIP,5,30] call SEN_fnc_findRandomPos),SEN_enemySide,8,.25] call SEN_fnc_spawnSquad;
_vehArray = _grpArray select 1;
_grp = _grpArray select 2;
[_grp] spawn SEN_fnc_setPatrolGroup;
if !(count _vehArray isEqualTo 0) then {
    [group (_vehArray select 0),_posVIP,500] call BIS_fnc_taskPatrol;
};

[_vip] call SEN_fnc_setUnitHostage;
_vip allowDamage true;

_mrkPos = [_posVIP,0,300] call SEN_fnc_findRandomPos;
_mrkVip = createMarker ["SEN_vip_mrk",_mrkPos];
_mrkVip setMarkerColor "ColorCIV";
_mrkVip setMarkerShape "ELLIPSE";
_mrkVip setMarkerSize [350,350];
_mrkVip setMarkerAlpha 0.7;

[WEST,[_taskID], [_taskDescription, _taskText, ""], _mrkPos, false, 2, true, "Search", false] call BIS_fnc_taskCreate;

if(SEN_debug isEqualTo 1) then {
    [_taskID] call BIS_fnc_taskSetCurrent;
    [_taskID,getPosATL _vip] call BIS_fnc_taskSetDestination;
};

waitUntil {sleep 10; (_vip getVariable ["ace_captives_ishandcuffed", false])};

if (alive _vip) then {
    _taskText = "Escort VIP";

    [_taskID] call BIS_fnc_taskSetCurrent;
    [_taskID,[_taskDescription,_taskText,""]] call BIS_fnc_taskSetDescription;
    [_taskID,(getmarkerpos "SEN_hq_mrk")] call BIS_fnc_taskSetDestination;

    waitUntil {sleep 10; (((_vip distance (getmarkerpos "SEN_hq_mrk")) < 25 && (getposatl _vip select 2 < 2)) || !alive _vip)};
};

if (!alive _vip) exitWith {
    [_taskID, "FAILED"] call BIS_fnc_taskSetState;
    SEN_objectCleanup pushBack _vip;
    SEN_markerCleanup pushBack _mrkVip;
    [] call SEN_fnc_setTask;
};

[_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;

JK_TicketSystem = JK_TicketSystem + 2000;
publicVariable "JK_TicketSystem";

SEN_objectCleanup pushBack _vip;
SEN_markerCleanup pushBack _mrkVip;
[] call SEN_fnc_setTask;
