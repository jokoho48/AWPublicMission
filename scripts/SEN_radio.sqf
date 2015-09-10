/*
Author: SENSEI

Last modified: 6/25/2015

Description:  adds radios to player inventory
__________________________________________________________________*/
if (!hasInterface) exitWith {};

if (SEN_acreEnabled) exitWith {
    call SEN_fnc_setAcreRadio;
};

if (SEN_tfrEnabled) exitWith {
    call SEN_fnc_setTfrRadio;
};

hintSilent "Cannot issue radio. You do not have ACRE2 or TFR enabled.";
