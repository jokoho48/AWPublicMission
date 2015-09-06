/*
@filename: airbaseDefense.sqf
Author:

    Quiksilver

Last modified:

    25/04/2014

Description:

    Spawns a friendly AA vehicle to protect the airbase from OPFOR air assets, for a short time.
    Activated via a laptop addAction.

    Benefits of doing it this way = dont need an AI vehicle sitting there at all times eating server resources,
    and hands over interactive control to players from server.

__________________________________________________________________________*/

private ["_loopTimeout","_activeTimer","_inactiveTimer","_airdefenseGroup","_defensePos"];

_loopTimeout = 10 + (random 10);

AIRBASEDEFENSE_SWITCH = false; publicVariable "AIRBASEDEFENSE_SWITCH";

while { true } do {

    if (AIRBASEDEFENSE_SWITCH) then {

        hqSideChat = "Luftverteidigung des HQ aktiviert!"; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;

        //---------- Useful stuff

        _activeTimer = 300;                                        // How long will it remain active for, in seconds. 300 = 5 minutes
        _inactiveTimer = 600;                                    // Shortest time between activations, in seconds. 900 = 15 minutes
        _defensePos = getMarkerPos "airbaseDefense";
        _defensePos2 = getMarkerPos "airbaseDefense_2";
        _defensePos3 = getMarkerPos "airbaseDefense_3";
        _defensePos4 = getMarkerPos "airbaseDefense_4";
        _airdefenseGroup = createGroup west;
        _airdefenseGroup2 = createGroup west;
        _airdefenseGroup3 = createGroup west;
        _airdefenseGroup4 = createGroup west;

        //---------- Spawn vehicle

        defender = createVehicle ["RHS_M6",_defensePos,[],0,"NONE"];
        waitUntil {!isNull defender};
        defender allowDamage false;
        defender setDir 135;
        defender lock 3;

        defender2 = createVehicle ["RHS_M6",_defensePos2,[],0,"NONE"];
        waitUntil {!isNull defender2};
        defender2 allowDamage false;
        defender2 setDir 135;
        defender2 lock 3;

        defender3 = createVehicle ["RHS_M6",_defensePos3,[],0,"NONE"];
        waitUntil {!isNull defender3};
        defender3 allowDamage false;
        defender3 setDir 135;
        defender3 lock 3;

        defender4 = createVehicle ["RHS_M6",_defensePos4,[],0,"NONE"];
        waitUntil {!isNull defender4};
        defender4 allowDamage false;
        defender4 setDir 135;
        defender4 lock 3;

        //---------- Spawn crew

        "rhsusf_army_ocp_combatcrewman" createUnit [_defensePos,_airdefenseGroup];
        "rhsusf_army_ocp_combatcrewman" createUnit [_defensePos,_airdefenseGroup];
        ((units _airdefenseGroup) select 0) assignAsGunner defender;
        ((units _airdefenseGroup) select 0) moveInGunner defender;
        ((units _airdefenseGroup) select 1) assignAsCommander defender;
        ((units _airdefenseGroup) select 1) moveInCommander defender;
        sleep 0.1;
        defenderCrew1 = ((units _airdefenseGroup) select 0); defenderCrew1 allowDamage false;
        defenderCrew2 = ((units _airdefenseGroup) select 1); defenderCrew2 allowDamage false;
        sleep 0.1;

        "rhsusf_army_ocp_combatcrewman" createUnit [_defensePos2,_airdefenseGroup2];
        "rhsusf_army_ocp_combatcrewman" createUnit [_defensePos2,_airdefenseGroup2];
        ((units _airdefenseGroup2) select 0) assignAsGunner defender2;
        ((units _airdefenseGroup2) select 0) moveInGunner defender2;
        ((units _airdefenseGroup2) select 1) assignAsCommander defender2;
        ((units _airdefenseGroup2) select 1) moveInCommander defender2;
        sleep 0.1;
        defenderCrew12 = ((units _airdefenseGroup2) select 0); defenderCrew12 allowDamage false;
        defenderCrew22 = ((units _airdefenseGroup2) select 1); defenderCrew22 allowDamage false;
        sleep 0.1;

        "rhsusf_army_ocp_combatcrewman" createUnit [_defensePos3,_airdefenseGroup3];
        "rhsusf_army_ocp_combatcrewman" createUnit [_defensePos3,_airdefenseGroup3];
        ((units _airdefenseGroup3) select 0) assignAsGunner defender3;
        ((units _airdefenseGroup3) select 0) moveInGunner defender3;
        ((units _airdefenseGroup3) select 1) assignAsCommander defender3;
        ((units _airdefenseGroup3) select 1) moveInCommander defender3;
        sleep 0.1;
        defenderCrew13 = ((units _airdefenseGroup3) select 0); defenderCrew13 allowDamage false;
        defenderCrew23 = ((units _airdefenseGroup3) select 1); defenderCrew23 allowDamage false;
        sleep 0.1;

        "rhsusf_army_ocp_combatcrewman" createUnit [_defensePos4,_airdefenseGroup4];
        "rhsusf_army_ocp_combatcrewman" createUnit [_defensePos4,_airdefenseGroup4];
        ((units _airdefenseGroup4) select 0) assignAsGunner defender4;
        ((units _airdefenseGroup4) select 0) moveInGunner defender4;
        ((units _airdefenseGroup4) select 1) assignAsCommander defender4;
        ((units _airdefenseGroup4) select 1) moveInCommander defender4;
        sleep 0.1;
        defenderCrew14 = ((units _airdefenseGroup4) select 0); defenderCrew14 allowDamage false;
        defenderCrew24 = ((units _airdefenseGroup4) select 1); defenderCrew24 allowDamage false;
        sleep 0.1;

        //---------- Configure

        [(units _airdefenseGroup)] call QS_fnc_setSkill4;
        _airdefenseGroup setBehaviour "COMBAT";
        _airdefenseGroup setCombatMode "RED";
        sleep 0.1;

        [(units _airdefenseGroup2)] call QS_fnc_setSkill4;
        _airdefenseGroup2 setBehaviour "COMBAT";
        _airdefenseGroup2 setCombatMode "RED";
        sleep 0.1;

        [(units _airdefenseGroup3)] call QS_fnc_setSkill4;
        _airdefenseGroup3 setBehaviour "COMBAT";
        _airdefenseGroup3 setCombatMode "RED";
        sleep 0.1;

        [(units _airdefenseGroup4)] call QS_fnc_setSkill4;
        _airdefenseGroup4 setBehaviour "COMBAT";
        _airdefenseGroup4 setCombatMode "RED";
        sleep 0.1;

        //---------- Auto-cannon only, no rockets. Unlimited cannon ammo.

        defender addEventHandler ["Fired",   {    defender setVehicleAmmo 1}  ];
        defender addEventHandler ["Fired",   {    defender2 setVehicleAmmo 1}  ];
        defender addEventHandler ["Fired",   {    defender3 setVehicleAmmo 1}  ];
        defender addEventHandler ["Fired",   {    defender4 setVehicleAmmo 1}  ];

        //---------- Active time

        sleep _activeTimer;

        //---------- Delete after use

        defender removeEventHandler ["Fired", 0];
        { deleteVehicle _x } forEach [defenderCrew1,defenderCrew2,defender];

        defender2 removeEventHandler ["Fired", 0];
        { deleteVehicle _x } forEach [defenderCrew12,defenderCrew22,defender2];

        defender3 removeEventHandler ["Fired", 0];
        { deleteVehicle _x } forEach [defenderCrew13,defenderCrew23,defender3];

        defender4 removeEventHandler ["Fired", 0];
        { deleteVehicle _x } forEach [defenderCrew14,defenderCrew24,defender4];

        //---------- Cool-off period before next use

        sleep _inactiveTimer;
        AIRBASEDEFENSE_SWITCH = false; publicVariable "AIRBASEDEFENSE_SWITCH";
        hqSideChat = "Luftverteidigung im HQ verfügbar."; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;

    };

    sleep _loopTimeout;

};
