/*
Author: SENSEI

Last modified: 8/14/2015

Description: repair patrol vehicles
__________________________________________________________________*/
if (!isServer) exitWith {};

private ["_pos","_size","_town","_taskDescription"];

_taskID = "repair";
_taskText = "Airlift Supplies";
_array = [];

if (!(getMarkerColor "sen_fob_mrk" isEqualTo "") && {random 100 < 50}) then {
    _name = "FOB Pirelli";
    _size = getmarkersize "SEN_fob_border_mrk";
    _pos = [getmarkerpos "SEN_fob_mrk", (_size select 0) + 200, (_size select 0) + 400, 1, 0, 0.5, 0] call BIS_fnc_findSafePos;
    missionNameSpace setVariable ["SEN_fobLock", true];
    _taskDescription = format ["Intel from an enemy officer shows that enemy forces plan to attack %1 in the coming days. In response, Command has increased the frequency of patrols in the area. A friendly unit scouting around %1 is in need of repair supplies. Make sure our soldiers are in top shape and airlift the supplies to the patrol.",_name];
} else {
    _town = SEN_whitelistLocation select (random ((count SEN_whitelistLocation) - 1));
    _name = text _town;
    _pos = getpos _town;
    _size = size _town;
    _pos = [_pos, (_size select 0) + 200, (_size select 0) + 400, 1, 0, 0.5, 0] call BIS_fnc_findSafePos;
    _taskDescription = format ["Intel from an enemy officer shows that another local settlement will be occupied in the coming days. Command has increased the frequency of patrols in several key areas. A friendly unit scouting near %1 is in need of repair supplies. Make sure our soldiers are in top shape and airlift the supplies to the patrol.",_name];
};

for "_i" from 0 to 1 do {
    _repairVeh = (SEN_vehPoolWest select (random ((count SEN_vehPoolWest) - 1))) createVehicle _pos;
    _repairVeh setDir (random 360);
    _repairVeh setdamage 0.9;
    _repairVeh allowDamage false;
    _repairVeh lock true;
    _fx = "test_EmptyObjectForSmoke" createVehicle (_repairVeh modeltoworld [0,1,0.2]);
    _fx attachTo [_repairVeh,[0,0,0]];
    _array pushback _repairVeh;
};
_pos set [2,0];
_grp = [_pos,0,4,WEST] call SEN_fnc_spawnGroup;
_supplies = "B_Slingload_01_Repair_F" createVehicle (getMarkerPos "SEN_depotSpawn_mrk");
_supplies setVariable ["SEN_noClean", true];

[WEST,[_taskID],[_taskDescription, _taskText, ""],_pos,false,2,true,"Support",false] call BIS_fnc_taskCreate;

waitUntil {sleep 10; (_supplies distance _pos < 100 && (getposatl _supplies select 2) < 3) || (getposASL _supplies select 2) < -3 || damage _supplies > 0.9 || isNull _supplies};

if ((getposASL _supplies select 2) < -3 || damage _supplies > 0.9 || isNull _supplies) exitWith {
    [_taskID, "FAILED"] call BIS_fnc_taskSetState;
    SEN_objectCleanup append (units _grp);
    SEN_objectCleanup append _array;
    SEN_objectCleanup pushBack _supplies;
    {if (typeOf _x isEqualTo "#particlesource") then {deleteVehicle _x}} forEach (_pos nearObjects 300);
    missionNameSpace setVariable ["SEN_fobLock", false];
    [] call SEN_fnc_setTask;
};

[_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;

JK_TicketSystem = JK_TicketSystem + 300;
publicVariable "JK_TicketSystem";

SEN_objectCleanup append (units _grp);
SEN_objectCleanup append _array;
SEN_objectCleanup pushBack _supplies;
{if (typeOf _x isEqualTo "#particlesource") then {deleteVehicle _x}} forEach (_pos nearObjects 300);
missionNameSpace setVariable ["SEN_fobLock", false];
[] call SEN_fnc_setTask;
