/*
Author: SENSEI

Last modified: 7/21/2015

Description: gets intel if player near intel item

        returns nothing
__________________________________________________________________*/
private ["_intel","_pos"];

player setVariable ["SEN_inProgress",true];
_intel = 0;

{
    if (_x isEqualTo SEN_intelObj && {!(_x isEqualTo objNull)}) exitWith {_intel = 1};
    if (_x isEqualTo SEN_intelObjCiv && {!(_x isEqualTo objNull)}) exitWith {_intel = 2};
    nil
} count (getposATL player nearObjects 4);
_pos = getposATL player;
hintsilent "Checking area for intel...";

[{
    params ["_pos", "_intel"];
    player setVariable ["SEN_inProgress",false];
    if (_intel isEqualTo 1) exitWith {
        if (getposATL player distance _pos < 1 && {vehicle player isEqualTo player}) then {
            SEN_taskSuccess = 1;
            publicVariableServer "SEN_taskSuccess";
            hintSilent "You found intel in the area.";
        } else {
            hintSilent "You must remain still while gathering intel.";
        };
    };
    if (_intel isEqualTo 2) exitWith {
        if (getposATL player distance _pos < 1 && {vehicle player isEqualTo player}) then {
            SEN_taskSuccess = 2;
            publicVariableServer "SEN_taskSuccess";
            hintSilent "You found intel in the area.";
        } else {
            hintSilent "You must remain still while gathering intel.";
        };

    };

    hintSilent "You did not find intel in the area.";
}, [_pos, _intel]] call ace_common_fnc_waitAndExecute;
