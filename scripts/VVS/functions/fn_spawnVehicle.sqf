/*
    File: fn_spawnVehicle.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Spawns the selected vehicle, if a vehicle is already on the spawn point
    then it deletes the vehicle from the spawn point.
*/

disableSerialization;
private["_position","_direction","_className","_displayName","_spCheck","_cfgInfo","_spClear"];
if(lnbCurSelRow 38101 isEqualTo -1) exitWith {hint "You did not select a vehicle to spawn!"};

if (player getVariable ["SEN_inProgress",false]) exitWith {};
player setVariable ["SEN_inProgress",true];

_className = lnbData[38101,[(lnbCurSelRow 38101),0]];
_displayName = lnbData[38101,[(lnbCurSelRow 38101),1]];
_position = getMarkerPos VVS_SP;
_direction = markerDir VVS_SP;
if(isNil "_position") exitWith {hint "The spawn position marker doesn't exist?"; player setVariable ["SEN_inProgress",false];};

closeDialog 0;
player setVariable ["SEN_inProgress",false];
[[_className,_position,_direction],"SEN_fnc_spawnVVS",false] call BIS_fnc_MP;
