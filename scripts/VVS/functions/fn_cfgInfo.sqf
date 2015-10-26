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
if(!isClass (configFile >> "CfgVehicles" >> _class)) exitWith {[]}; //Class doesn't exist in CfgVehicles

//Predefine some stuff.
_picture = "";
_displayName = "";

//Fetch
_picture = getText(configFile >> "CfgVehicles" >> _class >> "picture");
_displayName = getText(configFile >> "CfgVehicles" >> _class >> "displayName");

//Return
[_displayName, _picture];
