/*
@filename: aoReinforcementJet.sqf
Author:

    Quiksilver

Last modified:

    26/10/2014 ArmA 1.32 by Quiksilver

Description:

    Spawn an enemy CAS jet
______________________________________________________*/

private ["_aoPos","_spawnPos","_jetSelect","_casArray","_jetLimit","_jetPilot","_jetActual","_new"];

_casArray = ["RHS_Su25SM_vvs"];

_jetLimit = 1;

_new = false;

if ((count enemyCasArray) < _jetLimit) then {

    if ((count enemyCasArray) < 1) then {_new = true;} else {_new = false;};

    _spawnPos = [(random 30000),(random 30000),3000];
    _aoPos = getMarkerPos currentAO;
    if (isNull enemyCasGroup) then {enemyCasGroup = createGroup east;};

    _jetPilot = enemyCasGroup createUnit ["O_pilot_F",[0,0,(1000 + (random 1000))],[],0,"NONE"];
    _jetSelect = _casArray select (floor (random (count _casArray)));
    _jetActual = createVehicle [_jetSelect,_spawnPos,[],0,"NONE"];
    waitUntil {!isNull _jetActual};
    _jetActual engineOn true;
    _jetActual allowCrewInImmobile true;
    _jetActual flyInHeight 1000;
    _jetActual lock 2;
    _jetPilot assignAsDriver _jetActual;
    _jetPilot moveInDriver _jetActual;

    if (_new) then {_jetPilot setRank "COLONEL";} else {_jetPilot setRank "MAJOR";};
    enemyCasGroup setCombatMode "RED";
    enemyCasGroup setBehaviour "COMBAT";
    enemyCasGroup setSpeedMode "FULL";
    [(units enemyCasGroup)] call QS_fnc_setSkill2;
    [enemyCasGroup,_aoPos] call BIS_fnc_taskAttack;

    {_x addCuratorEditableObjects [[_jetPilot],false];} count allCurators;
    {_x addCuratorEditableObjects [[_jetActual],false];} count allCurators;

    0 = enemyCasArray pushBack _jetActual;

    [_jetActual,_jetPilot] spawn {
        private ["_jetActual","_jetPos","_targetList"];
        _jetActual = _this select 0;
        _jetPilot = _this select 1;

        while {(alive _jetActual)} do {
            _jetActual setVehicleAmmo 1;
            _jetActual flyInHeight (200 + (random 850));
            _jetPos = getPosATL _jetActual;
            _targetList = _jetPos nearEntities [["Air"],7500];
            {
                enemyCasGroup reveal [_x,4];
            } count _targetList;
            sleep 60;
        };
        showNotification = ["EnemyJet","Feindlicher CAS wurde vernichtet. Gute Arbeit!"]; publicVariable "showNotification";
        enemyCasArray = enemyCasArray - [_jetActual];
        sleep 30;
        if (!isNull _jetActual) then {deleteVehicle _jetActual;};
        if (!isNull _jetPilot) then {deleteVehicle _jetPilot;};
    };

    showNotification = ["EnemyJet","Feindlicher Jet im Anflug!"];
    publicVariable "showNotification";
    [{
        private ["_targetList"];
        (_this select 0) params ["_jetActual","_jetPilot"];
        if (alive _jetActual) then {
            _jetActual setVehicleAmmo 1;
            _jetActual flyInHeight (200 + (random 850));
            _jetPos = getPosATL _jetActual;
            _targetList = _jetPos nearEntities [["Air"],7500];
            {
                enemyCasGroup reveal [_x,4];
            } count _targetList;
        } else {
            showNotification = ["EnemyJet","Feindlicher CAS wurde vernichtet. Gute Arbeit!"];
            publicVariable "showNotification";
            enemyCasArray = enemyCasArray - [_jetActual];
            [{
                params ["_jetActual","_jetPilot"];
                if (!isNull _jetActual) then {deleteVehicle _jetActual;};
                if (!isNull _jetPilot) then {deleteVehicle _jetPilot;};
            }, 30, [_jetActual, _jetPilot]] call ace_common_fnc_waitAndExecute;
        };
    }, 60, [_jetActual, _jetPilot]] call CBA_fnc_addPerFrameHandler;
};
