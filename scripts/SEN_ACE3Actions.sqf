/*
Author: SENSEI

Last modified: 7/21/2015

Description:  creates actions for ACE3 interaction menu
__________________________________________________________________*/
if !(hasInterface) exitWith {};

_action = ['SEN_DCG','DCG Actions','',{},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ['SEN_FOB','Foward Operating Base','',{},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","SEN_DCG"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ['SEN_Civ','Civilians','',{},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","SEN_DCG"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ['SEN_Transport','Request Transport','',{},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","SEN_DCG"], _action] call ace_interact_menu_fnc_addActionToObject;

/////////////////

_action = ['SEN_Intel','Gather Intel','',{[] spawn SEN_fnc_getIntel;},{(vehicle player isEqualTo player) && {!(player getVariable ["SEN_inProgress",false])}}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","SEN_DCG"], _action] call ace_interact_menu_fnc_addActionToObject;

//_action = ['SEN_FOB_create','Deploy FOB Pirelli','',{[] spawn SEN_fnc_fobCreate;},{(vehicle player isEqualTo player) && {!(player getVariable ["SEN_inProgress",false])} && {(speed player < 1)} && {(getMarkerColor "sen_fob_mrk" isEqualTo "")}}] call ace_interact_menu_fnc_createAction;
//[player, 1, ["ACE_SelfActions","SEN_DCG","SEN_FOB"], _action] call ace_interact_menu_fnc_addActionToObject;

//_action = ['SEN_FOB_request','Request FOB Pirelli Control','',{call SEN_fnc_fobRequest;},{(vehicle player isEqualTo player) && {!(player getVariable ["SEN_inProgress",false])}}] call ace_interact_menu_fnc_createAction;
//[player, 1, ["ACE_SelfActions","SEN_DCG","SEN_FOB"], _action] call ace_interact_menu_fnc_addActionToObject;

//_action = ['SEN_Question','Question Nearby Civilians','',{call SEN_fnc_onCivQuestion;},{(vehicle player isEqualTo player)}] call ace_interact_menu_fnc_createAction;
//[player, 1, ["ACE_SelfActions", "SEN_DCG","SEN_Civ"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ['SEN_Approval','Check Civilian Approval','',{call SEN_fnc_checkApproval;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","SEN_DCG","SEN_Civ"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ['SEN_Disarm','Disarm Detonator','',{createDialog 'KeypadDefuse';},{!isNull SEN_defuseObj && {player distance SEN_defuseObj < 3}}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","SEN_DCG"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ['SEN_Manual','Open Field Manual','',{[] spawn {(findDisplay 46) createDisplay "RscDisplayFieldManual"}},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","SEN_DCG"], _action] call ace_interact_menu_fnc_addActionToObject;

{
    _action = ['SEN_Transport',format ['Call in %1',getText (configfile >> "CfgVehicles" >> _x >> "displayName")],'',{[_this select 2] call SEN_fnc_transportRequest;},{(vehicle player isEqualTo player)},{},_x] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG","SEN_Transport"], _action] call ace_interact_menu_fnc_addActionToObject;
} forEach SEN_airPoolWest;


_action = ['JK_Ticked','Check Tickeds','',{},{hintSilent format ["Currently are %1 Ticked avaiable", JK_TicketSystem];}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","SEN_DCG"], _action] call ace_interact_menu_fnc_addActionToObject;
