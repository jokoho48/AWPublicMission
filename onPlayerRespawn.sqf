/*
@filename: onPlayerRespawn.sqf
Author:

    Quiksilver

Last modified:

    29/10/2014 ArmA 1.32 by Quiksilver

Description:

    Client scripts that should execute after respawn.
______________________________________________________*/

private "_iampilot";
params ["_unit"];

//=========================== Fatigue setting

if (PARAMS_Fatigue == 0) then {player enableFatigue true;};

//=========================== PILOTS ONLY

_pilots = ["rhsusf_army_ocp_helipilot"];
_iampilot = ({typeOf player == _x} count _pilots) > 0;
if (_iampilot) then {
    //===== FAST ROPE
    if (PARAMS_HeliRope != 0) then {
        player addAction ["Toss Ropes",zlt_fnc_createropes, [], -1, false, false, '','[] call zlt_fnc_ropes_cond'];
        player addAction ["Cut Ropes",zlt_fnc_removeropes, [], 98, false, false, '','not zlt_mutexAction and count ((vehicle player) getvariable ["zlt_ropes", []]) != 0'];
    };
    //===== HELI SLING
    if (PARAMS_HeliSling != 0) then {
        player addAction ["Sling vehicle",QS_fnc_slingAttach,[],20,true,true,'','[] call QS_fnc_conditionSlingAttach'];
        player addAction ["Drop slung vehicle",QS_fnc_slingDetach,[],0,false,false,'','[] call QS_fnc_conditionSlingDetach'];
    };
    //===== HELI SUPPLY DROP
    if (PARAMS_HeliDrop != 0) then {
        player addAction ["Drop supply crate",QS_fnc_airDrop,[],0,false,true,'','[] call QS_fnc_conditionAirDrop'];
    };
    //===== UH-80 TURRETS
    if (PARAMS_UH80TurretControl != 0) then {
        inturretloop = false;
        UH80TurretAction = player addAction ["Turret Control",QS_fnc_uh80TurretControl,[],-95,false,false,'','[] call QS_fnc_conditionUH80TurretControl'];
    };
};

//============================= UAV

_uavop = ["B_soldier_UAV_F"];
_iamuavop = ({typeOf player == _x} count _uavop) > 0;

if (_iamuavop) then {
    player addAction ["Load new UAV software",QS_fnc_actionUAVSoftware,[],20,true,true,'','[] call QS_fnc_conditionUAVSoftware'];
};

//============================= non-pilots units fastrope

if (PARAMS_HeliRope != 0) then {
    player addAction ["Fast Rope (Press Space)", zlt_fnc_fastrope, [], 99, false, false, '','!zlt_mutexAction and count ((vehicle player) getvariable ["zlt_ropes", []]) != 0 and player != driver vehicle player'];
};

//============================= Mobile arsenal/Mobile Vas

if (PARAMS_MobileArmory != 0) then {
    if (PARAMS_MobileArmory == 1) then {
        player addAction ["Mobile Armory","scripts\VAS\open.sqf",[],10,false,false,'','[] call QS_fnc_conditionMobileArmory'];
    };
    if (PARAMS_MobileArmory == 2) then {
        /* ARSENAL */
    };
    if (PARAMS_MobileArmory == 3) then {
        player addAction ["Mobile Armory","scripts\VAS\open.sqf",[],10,false,false,'','[] call QS_fnc_conditionMobileArmory'];
    };
};

//====================== Seating and Clear vehicle inventory stuff

saving_inventory = false;
inventory_cleared = false;
player setVariable ["seated",false];
player addAction ["Clear vehicle inventory",QS_fnc_actionClearInventory,[],-97,false,false,'','[] call QS_fnc_conditionClearInventory'];

//======================= Add players to Zeus

{_x addCuratorEditableObjects [[player],false];} count allCurators;

//======================= Loadouts
switch (player getVariable "loadout") do {

    case ("teamlead"):{
        call compile preprocessfilelinenumbers "scripts\loadouts\teamlead.sqf";
    };
    case ("rifleman"):{
        call compile preprocessfilelinenumbers "scripts\loadouts\rifleman.sqf";
    };
    case ("medic"):{
        call compile preprocessfilelinenumbers "scripts\loadouts\medic.sqf";
    };
    case ("helipilot"):{
        call compile preprocessfilelinenumbers "scripts\loadouts\helipilot.sqf";
    };
    case ("tankcrew"):{
        call compile preprocessfilelinenumbers "scripts\loadouts\tankcrew.sqf";
    };
    default {
        call compile preprocessfilelinenumbers "scripts\loadouts\rifleman.sqf";
    };
};

//======================= Prevent inventory interaction

//======================= Unlimited personal aid kits in medic facility
player addEventHandler ["Take", {
        _container = _this select 1;

        if (_container == medickiste) then {
                _container addItemCargoGlobal ["ACE_personalAidKit",1];
        };

}];
