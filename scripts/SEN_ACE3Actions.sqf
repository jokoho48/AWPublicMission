/*
Author: SENSEI

Last modified: 7/21/2015

Description:  creates actions for ACE3 interaction menu
__________________________________________________________________*/
if !(hasInterface) exitWith {};

private _action = ['SEN_DCG','DCG Actions','',{},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ['SEN_Civ','Civilian','',{},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","SEN_DCG"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ['JK_Tickets','Check Tickets','',{hintSilent format ["Currently are %1 Tickets avaiable", JK_TicketSystem];},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","SEN_DCG"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ['SEN_Approval','Check Civilian Approval','',{call SEN_fnc_checkApproval;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","SEN_DCG", "SEN_Civ"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ['SEN_Intel','Gather Intel','',{[] spawn SEN_fnc_getIntel;},{(vehicle player isEqualTo player) && {!(player getVariable ["SEN_inProgress",false])}}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","SEN_DCG"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ['SEN_Question','Question Nearby Civilians','',{call SEN_fnc_onCivQuestion;},{(vehicle player isEqualTo player)}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "SEN_DCG", "SEN_Civ"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ['SEN_Disarm','Disarm Detonator','',{createDialog 'KeypadDefuse';},{!isNull SEN_defuseObj && {player distance SEN_defuseObj < 3}}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","SEN_DCG"], _action] call ace_interact_menu_fnc_addActionToObject;
