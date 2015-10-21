/*
Author: SENSEI

Last modified: 7/21/2015

Description:  creates actions for ACE3 interaction menu
__________________________________________________________________*/
if !(hasInterface) exitWith {};
private "_action";
JK_Names = [];

JK_fnc_isGroup = {
    private "_oldName";
    params ["_name"];
    _oldName = player getVariable ["JK_Name", ""];
    _name != _oldName
};

JK_fnc_setGroup = {
    private "_oldName";
    params ["_name"];
    _oldName = player getVariable ["JK_Name", ""];
    if !(_name in JK_Names) then {
        JK_Names deleteAt (JK_Names find _oldName);
        player setVariable ["JK_Name", _name, true];
        JK_Names pushBack _name;
        publicVariable "JK_Names";
        hintC format ["Your Squad Name is now %1", _name];
    };
};

_action = ['SEN_DCG','DCG Actions','',{},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ['JK_Group','Set Group Name','',{},{player == leader player}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","SEN_DCG"], _action] call ace_interact_menu_fnc_addActionToObject;

if (true) then {
    _action = ['JK_GroupAD','Alpha - Delta','',{},{true}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group"], _action] call ace_interact_menu_fnc_addActionToObject;
    //1
    _action = ['JK_GroupA','Alpha','',{["Alpha"] call JK_fnc_setGroup;},{["Alpha"] call JK_fnc_isGroup;}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group", "JK_GroupAD"], _action] call ace_interact_menu_fnc_addActionToObject;

    _action = ['JK_GroupB','Bravo','',{["Bravo"] call JK_fnc_setGroup;},{["Bravo"] call JK_fnc_isGroup;}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group", "JK_GroupAD"], _action] call ace_interact_menu_fnc_addActionToObject;

    _action = ['JK_GroupC','Charly','',{["Charly"] call JK_fnc_setGroup;},{["Charly"] call JK_fnc_isGroup;}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group", "JK_GroupAD"], _action] call ace_interact_menu_fnc_addActionToObject;

    _action = ['JK_GroupD','Delta','',{["Delta"] call JK_fnc_setGroup;},{["Delta"] call JK_fnc_isGroup;}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group", "JK_GroupAD"], _action] call ace_interact_menu_fnc_addActionToObject;
};

if (true) then {
    _action = ['JK_GroupEH','Echo - Hotel','',{},{true}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group"], _action] call ace_interact_menu_fnc_addActionToObject;
    //2
    _action = ['JK_GroupE','Echo','',{["Echo"] call JK_fnc_setGroup;},{["Echo"] call JK_fnc_isGroup;}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group", "JK_GroupEH"], _action] call ace_interact_menu_fnc_addActionToObject;

    _action = ['JK_GroupF','Foxtrot','',{["Foxtrot"] call JK_fnc_setGroup;},{["Foxtrot"] call JK_fnc_isGroup;}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group", "JK_GroupEH"], _action] call ace_interact_menu_fnc_addActionToObject;

    _action = ['JK_GroupG','Golf','',{["Golf"] call JK_fnc_setGroup;},{["Golf"] call JK_fnc_isGroup;}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group", "JK_GroupEH"], _action] call ace_interact_menu_fnc_addActionToObject;

    _action = ['JK_GroupH','Hotel','',{["Hotel"] call JK_fnc_setGroup;},{["Hotel"] call JK_fnc_isGroup;}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group", "JK_GroupEH"], _action] call ace_interact_menu_fnc_addActionToObject;
};

if (true) then {
    _action = ['JK_GroupIM','India - Mike','',{},{true}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group"], _action] call ace_interact_menu_fnc_addActionToObject;
    //3
    _action = ['JK_GroupI','India','',{["India"] call JK_fnc_setGroup;},{["India"] call JK_fnc_isGroup;}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group", "JK_GroupIM"], _action] call ace_interact_menu_fnc_addActionToObject;

    _action = ['JK_GroupK','Kilo','',{["Kilo"] call JK_fnc_setGroup;},{["Kilo"] call JK_fnc_isGroup;}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group", "JK_GroupIM"], _action] call ace_interact_menu_fnc_addActionToObject;

    _action = ['JK_GroupL','Lima','',{["Lima"] call JK_fnc_setGroup;},{["Lima"] call JK_fnc_isGroup;}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group", "JK_GroupIM"], _action] call ace_interact_menu_fnc_addActionToObject;

    _action = ['JK_GroupM','Mike','',{["Mike"] call JK_fnc_setGroup;},{["Mike"] call JK_fnc_isGroup;}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group", "JK_GroupIM"], _action] call ace_interact_menu_fnc_addActionToObject;
};

if (true) then {
    _action = ['JK_GroupNQ','November - Quebec','',{},{true}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group"], _action] call ace_interact_menu_fnc_addActionToObject;
    //4
    _action = ['JK_GroupN','November','',{["November"] call JK_fnc_setGroup;},{["November"] call JK_fnc_isGroup;}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group", "JK_GroupNQ"], _action] call ace_interact_menu_fnc_addActionToObject;

    _action = ['JK_GroupO','Oscar','',{["Oscar"] call JK_fnc_setGroup;},{["Oscar"] call JK_fnc_isGroup;}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group", "JK_GroupNQ"], _action] call ace_interact_menu_fnc_addActionToObject;

    _action = ['JK_GroupP','Papa','',{["Papa"] call JK_fnc_setGroup;},{["Papa"] call JK_fnc_isGroup;}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group", "JK_GroupNQ"], _action] call ace_interact_menu_fnc_addActionToObject;

    _action = ['JK_GroupQ','Quebec','',{["Quebec"] call JK_fnc_setGroup;},{["Quebec"] call JK_fnc_isGroup;}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group", "JK_GroupNQ"], _action] call ace_interact_menu_fnc_addActionToObject;
};

if (true) then {
    _action = ['JK_GroupRU','Romeo - Uniform','',{},{true}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group"], _action] call ace_interact_menu_fnc_addActionToObject;
    //5
    _action = ['JK_GroupR','Romeo','',{["Romeo"] call JK_fnc_setGroup;},{["Romeo"] call JK_fnc_isGroup;}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group", "JK_GroupRU"], _action] call ace_interact_menu_fnc_addActionToObject;

    _action = ['JK_GroupS','Sierra','',{["Sierra"] call JK_fnc_setGroup;},{["Sierra"] call JK_fnc_isGroup;}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group", "JK_GroupRU"], _action] call ace_interact_menu_fnc_addActionToObject;

    _action = ['JK_GroupT','Tango','',{["Tango"] call JK_fnc_setGroup;},{["Tango"] call JK_fnc_isGroup;}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group", "JK_GroupRU"], _action] call ace_interact_menu_fnc_addActionToObject;

    _action = ['JK_GroupU','Uniform','',{["Uniform"] call JK_fnc_setGroup;},{["Uniform"] call JK_fnc_isGroup;}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group", "JK_GroupRU"], _action] call ace_interact_menu_fnc_addActionToObject;
};

if (true) then {
    _action = ['JK_GroupVY','Victor - Yankee','',{},{true}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group"], _action] call ace_interact_menu_fnc_addActionToObject;
    //6
    _action = ['JK_GroupV','Victor','',{["Victor"] call JK_fnc_setGroup;},{["Victor"] call JK_fnc_isGroup;}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group", "JK_GroupVY"], _action] call ace_interact_menu_fnc_addActionToObject;

    _action = ['JK_GroupW','Whiskey','',{["Whiskey"] call JK_fnc_setGroup;},{["Whiskey"] call JK_fnc_isGroup;}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group", "JK_GroupVY"], _action] call ace_interact_menu_fnc_addActionToObject;

    _action = ['JK_GroupX','XRay','',{["X-Ray"] call JK_fnc_setGroup;},{["X-Ray"] call JK_fnc_isGroup;}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group", "JK_GroupVY"], _action] call ace_interact_menu_fnc_addActionToObject;

    _action = ['JK_GroupY','Yankee','',{["Yankee"] call JK_fnc_setGroup;},{["Yankee"] call JK_fnc_isGroup;}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group", "JK_GroupVY"], _action] call ace_interact_menu_fnc_addActionToObject;
};

if (true) then {
    _action = ['JK_GroupZO','Zulu - OPZ','',{},{true}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group"], _action] call ace_interact_menu_fnc_addActionToObject;
    //7
    _action = ['JK_GroupZ','Zulu','',{["Zulu"] call JK_fnc_setGroup;},{["Zulu"] call JK_fnc_isGroup;}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group", "JK_GroupZO"], _action] call ace_interact_menu_fnc_addActionToObject;

    _action = ['JK_GroupBa','Buffalo','',{["Buffalo"] call JK_fnc_setGroup;},{["Buffalo"] call JK_fnc_isGroup;}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group", "JK_GroupZO"], _action] call ace_interact_menu_fnc_addActionToObject;

    _action = ['JK_GroupGu','Guardian','',{["Guardian"] call JK_fnc_setGroup;},{["Guardian"] call JK_fnc_isGroup;}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group", "JK_GroupZO"], _action] call ace_interact_menu_fnc_addActionToObject;

    _action = ['JK_GroupOPZ','OPZ','',{["OPZ"] call JK_fnc_setGroup;},{["OPZ"] call JK_fnc_isGroup;}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions","SEN_DCG", "JK_Group", "JK_GroupZO"], _action] call ace_interact_menu_fnc_addActionToObject;
};

_action = ['SEN_Civ','Civilian','',{},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","SEN_DCG"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ['SEN_FOB','Foward Operating Base','',{},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","SEN_DCG"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ['SEN_Transport','Request Transport','',{},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","SEN_DCG"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ['JK_Tickets','Check Tickets','',{hintSilent format ["Currently are %1 Tickets avaiable", JK_TicketSystem];},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","SEN_DCG"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ['SEN_Approval','Check Civilian Approval','',{call SEN_fnc_checkApproval;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","SEN_DCG", "SEN_Civ"], _action] call ace_interact_menu_fnc_addActionToObject;
/////////////////

_action = ['SEN_Intel','Gather Intel','',{[] spawn SEN_fnc_getIntel;},{(vehicle player isEqualTo player) && {!(player getVariable ["SEN_inProgress",false])}}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","SEN_DCG"], _action] call ace_interact_menu_fnc_addActionToObject;

//_action = ['SEN_FOB_create','Deploy FOB Pirelli','',{[] spawn SEN_fnc_fobCreate;},{(vehicle player isEqualTo player) && {!(player getVariable ["SEN_inProgress",false])} && {(speed player < 1)} && {(getMarkerColor "sen_fob_mrk" isEqualTo "")}}] call ace_interact_menu_fnc_createAction;
//[player, 1, ["ACE_SelfActions","SEN_DCG","SEN_FOB"], _action] call ace_interact_menu_fnc_addActionToObject;

//_action = ['SEN_FOB_request','Request FOB Pirelli Control','',{call SEN_fnc_fobRequest;},{(vehicle player isEqualTo player) && {!(player getVariable ["SEN_inProgress",false])}}] call ace_interact_menu_fnc_createAction;
//[player, 1, ["ACE_SelfActions","SEN_DCG","SEN_FOB"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ['SEN_Question','Question Nearby Civilians','',{call SEN_fnc_onCivQuestion;},{(vehicle player isEqualTo player)}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "SEN_DCG", "SEN_Civ"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ['SEN_Disarm','Disarm Detonator','',{createDialog 'KeypadDefuse';},{!isNull SEN_defuseObj && {player distance SEN_defuseObj < 3}}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","SEN_DCG"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ['SEN_Manual','Open Field Manual','',{[] spawn {(findDisplay 46) createDisplay "RscDisplayFieldManual"}},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","SEN_DCG"], _action] call ace_interact_menu_fnc_addActionToObject;

[] spawn {
    waitUntil {!isNil "SEN_airPoolWest"};
    {
        _action = ['SEN_Transport',format ['Call in %1',getText (configfile >> "CfgVehicles" >> _x >> "displayName")],'',{[_this select 2] call SEN_fnc_transportRequest;},{(vehicle player isEqualTo player)},{},_x] call ace_interact_menu_fnc_createAction;
        [player, 1, ["ACE_SelfActions","SEN_DCG","SEN_Transport"], _action] call ace_interact_menu_fnc_addActionToObject;
    } forEach SEN_airPoolWest;
};
