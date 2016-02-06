/*
Author: joko // Jonas

Description: Plane or Heli attack Player
__________________________________________________________________*/
scriptName "SEN_task_AirAttack";

JK_airAttackDone = false;
_target = allPlayers call BIS_fnc_selectRandom;
_pos = getPos _target;
if ([_pos,"SEN_safezone_mrk"] call SEN_fnc_checkInMarker) exitWith {
    [1,"Air Attack in Savezone"] call SEN_fnc_log;
    //sleep 2700;
    //[] spawn SEN_fnc_rebelTastCiv;
};

_taskID = format["%1_rebel_civ",time];
_taskText = "Air Priority Target";
_taskDescription = "A Air Priority Target is Entering our Air Area";

_class = SEN_airAttackPool call BIS_fnc_selectRandom;
_spawnPos = getmarkerPos (["JK_AirSpawn_1", "JK_AirSpawn_2", "JK_AirSpawn_3", "JK_AirSpawn_4", "JK_AirSpawn_5", "JK_AirSpawn_6", "JK_AirSpawn_7", "JK_AirSpawn_8", "JK_AirSpawn_9"] call BIS_fnc_selectRandom);
_spawnPos set [2, 4000];
_veh = createVehicle [_class, _spawnPos, [], 0, "FLY"];
createVehicleCrew _veh;
_vehCrew = crew _veh;
[_vehCrew] call SEN_fnc_setSide;
_grp = group (_vehCrew select 0);
{
    _unit = _x;
    {
        _unit reveal _x;
    } count allPlayers;
    nil
} count _vehCrew;

private ["_wp1", "_wp2"];

_wp1 = _grp addWaypoint [_pos, 0];
_wp1 setWaypointType "SAD"; // Seek And Destroy
[_grp, 1] setWaypointBehaviour "COMBAT";
[_grp, 1] setWaypointCombatMode "RED";
[_grp, 1] setWaypointCompletionRadius 75;
[_grp, 1] setWaypointStatements ["true", "(group this) setCurrentWaypoint [group this, 2]"];

_wp2 = _grp addWaypoint [_pos, 0];
_wp2 setWaypointType "LOITER";
[_grp, 2] setWaypointBehaviour "COMBAT";
[_grp, 2] setWaypointCombatMode "RED";
[_grp, 2] setWaypointCompletionRadius 75;
[_grp, 2] setWaypointLoiterRadius 75;
[_grp, 2] setWaypointStatements ["true", "(group this) setCurrentWaypoint [group this, 1]"];

_wp3 = _grp addWaypoint [_spawnPos, 0];
_wp3 setWaypointType "MOVE";
[_grp, 3] setWaypointBehaviour "COMBAT";
[_grp, 3] setWaypointCombatMode "RED";
[_grp, 3] setWaypointCompletionRadius 75;
[_grp, 3] setWaypointLoiterRadius 75;

waitUntil {
    sleep 10;
    {
        _unit = _x;
        {
            _unit reveal _x;
            } count allPlayers;
            nil
    } count _vehCrew;

    !alive _veh || !(([getPos _veh, 6000] call SEN_fnc_getNearPlayers) isEqualTo [])
};

[WEST, [_taskID], [_taskDescription, _taskText, ""], _pos, false, 2, true, "Destroy", false] call BIS_fnc_taskCreate;

[_grp] spawn {
    params ["_grp"];
    Sleep (1200 + (random 300));
    if !(isNull _grp || !JK_airAttackDone) then {
        _grp setCurrentWaypoint [_grp, 3];
    };
};

waitUntil {
    sleep 30;
    {
        _unit = _x;
        {
            _unit reveal _x;
        } count allPlayers;
        nil
    } count _vehCrew;
    !alive _veh || !(([getPos _veh, 2000] call SEN_fnc_getNearPlayers) isEqualTo [])
};
sleep 20;
waitUntil {
    sleep 30;
    {
        _unit = _x;
        {
            _unit reveal _x;
        } count allPlayers;
        nil
    } count _vehCrew;
    !alive _veh || ([getPos _veh, 2000] call SEN_fnc_getNearPlayers) isEqualTo []
};

if (!alive _veh) then {
    [_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
} else {
    [_taskID, "CANCELED"] call BIS_fnc_taskSetState;
    if !(isNull _grp) then {
        _grp setCurrentWaypoint [_grp, 3];
    };
};

JK_TicketSystem = JK_TicketSystem + 200;
publicVariable "JK_TicketSystem";

//SEN_approvalCiv = SEN_approvalCiv + 15;
//publicVariable "SEN_approvalCiv";

//sleep 2700;
JK_airAttackDone = true;
//[] spawn SEN_fnc_rebelTastCiv;
SEN_objectCleanup pushBack _veh;
SEN_objectCleanup append _vehCrew;
