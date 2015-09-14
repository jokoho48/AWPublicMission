/*
    File: fn_openVVS.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Opens the VVS menu and fills in the blanks.
*/
params ["", "", "", ["_sp", ""]];
if (JK_buildNotDone) then {
    hint "Please Wait Vehicle list is in baking Process";
    waitUntil {!JK_buildNotDone};
    hint "baking Done";
};
if(typeName _sp isEqualTo "STRING") then {
    if(_sp isEqualTo "") exitWith {closeDialog 0};
    VVS_SP = _sp;
} else {
    if(typeName _sp isEqualTo "ARRAY") then {
        if(count _sp isEqualTo 0) exitWith {closeDialog 0;};
        VVS_SP = _sp select 0;
        VVS_Cfg = _sp select 1;
    };
};
disableSerialization;
if(!(createDialog "VVS_Menu")) exitWith {}; //Couldn't create the menu
