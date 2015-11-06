/*
    File: fn_cfgInfo.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Used in returning information about a vehicle from Config >> "CfgVehicles"

    Return:
    0: picture
    1: displayname
*/
private["_scope","_picture","_displayName","_vehicleClass","_side","_faction","_superClass"];
params [["_class", "", [""]]];
if(_class isEqualTo "") exitWith {[]}; //Bad class passed.
_cfgPath = (configFile >> "CfgVehicles" >> _class);
if(!isClass _cfgPath) exitWith {["", ""]}; //Class doesn't exist in CfgVehicles

//Fetch
_displayName = getText(_cfgPath >> "displayName");
_picture = getText(_cfgPath >> "picture");

//Return
[_displayName, _picture];
