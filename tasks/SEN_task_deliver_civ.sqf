/*
Author: SENSEI

Last modified: 8/14/2015

Description: deliver supplies to town
__________________________________________________________________*/
if (!isServer) exitWith {};

private "_grp";

_targetTown = SEN_whitelistLocation select (random ((count SEN_whitelistLocation) - 1));
_pos1 = [(getpos _targetTown),0,90] call SEN_fnc_findRandomPos;
while {(([_pos1, 3000] call SEN_fnc_getNearPlayers) isEqualTo [])} do {
    _targetTown = SEN_whitelistLocation select (random ((count SEN_whitelistLocation) - 1));
    _pos1 = [(getpos _targetTown),0,90] call SEN_fnc_findRandomPos;
};

_taskID = format["%1_deliver_civ",SEN_taskCounterCiv];
_taskText = "Deliver Supplies";
_taskDescription = format["The enemy occupation has left the locals in distress. The townspeople of %1 (%2) desparately need medical supplies.<br/><br/>Collect the supply vehicle from the MOB Depot and deliver the supplies to %1.",text _targetTown,mapGridPosition (getpos _targetTown)];

_spawnMrk = "SEN_depotSpawn_mrk";
_aidArray = [];
_grp = grpNull;


_aid = "rhsusf_M1083A1P2_B_M2_d_Medical_fmtv_usarmy" createVehicle (getMarkerPos _spawnMrk);
_aid setDir (markerDir _spawnMrk);
_aid setVariable ["SEN_noClean", true];
clearItemCargoGlobal _aid;
clearMagazineCargoGlobal _aid;

_halfway = (_aid distance _pos1)/2;

[WEST,[_taskID],[_taskDescription, _taskText, ""],_pos1,false,1,true,"C",false] call BIS_fnc_taskCreate;

waitUntil {sleep 10; _aid distance _pos1 < _halfway};

if (((getposatl _aid) select 2) < 10) then { // if aid not in air
    if (random 100 < 40) then {
        "R_TBG32V_F" createVehicle (_aid modeltoworld [(-5 + random 10),(25 + random 8),-3]);
        sleep 1;
        "R_TBG32V_F" createVehicle (_aid modeltoworld [(-5 + random 10),(13 + random 5),-3]);
        [[_aid,["motor",1]],"setHit",_aid] call BIS_fnc_MP;
        // [_aid,["motor",1]] remoteExecCall ["setHit", owner _aid, false];
        _grp = [([getposATL _aid,200,300] call SEN_fnc_findRandomPos),0,((call SEN_fnc_setStrength) max 5) min 10] call SEN_fnc_spawnGroup;
        _wp = _grp addWaypoint [getPosATL _aid, 0];
        _wp setWaypointType "SAD";
        _wp setWaypointSpeed "FULL";
        _wp setWaypointCombatMode "RED";
    };
};

waitUntil {sleep 10; ((_aid distance _pos1 < 50) || (({_x distance _aid < 20} count (units _grp)) > 0) || (damage _aid > 0.95))};

if (({_x distance _aid < 20} count (units _grp)) > 0) exitWith {
    {
        if (_x distance _aid < 20) exitWith {
            _x playMoveNow "AinvPknlMstpSlayWrflDnon_medic";
            sleep 2;
            createVehicle ["R_TBG32V_F", getposATL _aid,[],0,"CAN_COLLIDE"];
            sleep 0.5;
            createVehicle ["R_TBG32V_F", getposATL _aid,[],0,"CAN_COLLIDE"];
            _aid setDamage 1;

            [_taskID, "FAILED"] call BIS_fnc_taskSetState;
            SEN_objectCleanup pushBack _aid;
            sleep SEN_taskSleepCiv;
            [] call SEN_fnc_setTaskCiv;
        };
    } forEach (units _grp);
};

if (damage _aid > 0.95) exitWith {
    [_taskID, "FAILED"] call BIS_fnc_taskSetState;
    SEN_objectCleanup pushBack _aid;
    sleep SEN_taskSleepCiv;
    [] call SEN_fnc_setTaskCiv;
};

waitUntil {sleep 1; speed _aid < 2};

if (random 1 < 0.35) then {[(getposATL _aid),SEN_enemySide,200,2000] spawn SEN_fnc_spawnReinforcements};

for "_i" from 1 to 3 do {
    _pos1 = (getposATL _aid) isFlatEmpty [1, 15, 1, 1, 0, false, objNull];
    if (count _pos1 > 0) then {
        _cargo = "Box_IND_AmmoVeh_F" createVehicle [0,0,0];
        _cargo setPosATL _pos1;
        _cargo setVectorUp [0,0,1];
        _cargo setObjectTextureGlobal [0, "#(rgb,8,8,3)color(1,1,1,1)"];
        _cargo setObjectTextureGlobal [1, "#(rgb,8,8,3)color(0.9,0.05,0.05,1)"];
        _aidArray pushBack _cargo;
    };
    sleep 0.15;
};

[_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;

JK_TicketSystem = JK_TicketSystem + 400;
publicVariable "JK_TicketSystem";

SEN_approvalCiv = SEN_approvalCiv + (30 + random 15);
publicVariable "SEN_approvalCiv";
sleep 10;
SEN_objectCleanup append _aidArray;
SEN_objectCleanup pushBack _aid;
sleep SEN_taskSleepCiv;
[] call SEN_fnc_setTaskCiv;
