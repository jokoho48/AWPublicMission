/*
Author: SENSEI

Last modified: 8/9/2015

Description: send reinforcements to position

        returns boolean
__________________________________________________________________*/
private ["_unitPool","_veh","_lz","_pos","_grp","_pilot","_patrolGrp","_helipad","_wp","_time"];
params [["_startPos",[0,0,0],[[]]],["_side",SEN_enemySide],["_minDist",600,[0]],["_spawnDist",2500,[0]],["_patrolOnWP",false]];

call {
    if (_side isEqualTo WEST) exitWith {
        _unitPool = SEN_unitPoolWest;
        _veh = "B_Heli_Light_01_F";


    };
    _unitPool = SEN_unitPool;
    _veh = "O_Heli_Light_02_F";
};

for "_s" from 1 to 15 do {
    _lz = [_startPos,_minDist,_minDist+200] call SEN_fnc_findRandomPos;
    _isEmpty = _lz isFlatEmpty [10, 0, 0.6, 10, 0, false, objNull];
    if (count _isEmpty != 0) exitWith {};
    sleep 0.1;
};

if (count _lz isEqualTo 0) exitWith {[2,"fn_spawnReinforcements: LZ undefined."] call SEN_fnc_log; false};
_lz set [2,0];
_pos = [_lz,_spawnDist,_spawnDist+500] call SEN_fnc_findRandomPos;
_grp = createGroup _side;
_grp setBehaviour "CARELESS";
_veh = createVehicle [_veh,_pos,[],0,"FLY"];
_veh addEventHandler ["engine", {if (!(_this select 1) && {damage (_this select 0) > 0.94}) then {SEN_objectCleanup pushBack (driver (_this select 0)); SEN_objectCleanup pushBack (_this select 0);}}];
_pilot = _grp createUnit [(selectRandom _unitPool),_pos, [], 0, "NONE"];
_pilot moveInDriver _veh;
_pilot disableAI "TARGET";
_pilot disableAI "AUTOTARGET";
_pilot allowfleeing 0;
_veh flyInHeight 100;
_veh lock 3;
_patrolGrp = [_pos,0,(_veh emptyPositions "cargo"),_side] call SEN_fnc_spawnGroup;
{_x assignAsCargoIndex [_veh, _forEachIndex]; _x moveInCargo _veh} forEach (units _patrolGrp);
_helipad = createVehicle ["Land_HelipadEmpty_F", _lz, [], 0, "CAN_COLLIDE"];
_veh doMove _lz;
[0,"fn_spawnReinforcements: enbound."] call SEN_fnc_log;

waitUntil {sleep 1; (unitReady _pilot || !(alive _veh))};

if !(alive _veh) exitWith {deleteVehicle _helipad; SEN_objectCleanup pushBack _veh; SEN_objectCleanup pushBack _pilot; SEN_objectCleanup append (units _patrolGrp); false};

_veh land "LAND";

waitUntil {sleep 1; (isTouchingGround _veh)};

_time = time;
_veh engineOn true;
_patrolGrp leaveVehicle _veh;

waitUntil {sleep 1; {(_x in _veh)} count (units _patrolGrp) isEqualTo 0};

deleteVehicle _helipad;
_patrolGrp setCombatMode "RED";
_wp = _patrolGrp addWaypoint [_startPos, 0];
_wp setWaypointType "SAD";
_wp setWaypointSpeed "FULL";
if (_patrolOnWP) then {
    _wp setWaypointStatements ["true", "[group this, 90] spawn SEN_fnc_setPatrolGroup"];
} else {
    _wp setWaypointStatements ["true", "if !(isPlayer(this findNearestEnemy this)) then {SEN_objectCleanup append (units (group this))}"];
};

_wp = _grp addWaypoint [[0,0,0], 0];
_wp setWaypointSpeed "FULL";
_grp setBehaviour "CARELESS";

waitUntil {sleep 1; (_pilot distance _lz > 100 || time > (_time + 180))};

SEN_objectCleanup pushBack _veh;
[0,"fn_spawnReinforcements: complete."] call SEN_fnc_log;
true
