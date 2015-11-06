/*
 * Author: joko // Jonas
 * Load
 *
 * Arguments:
 * 0: Vehicle Classname <String>
 *
 * Return Value:
 * 0: Displayname <String>
 * 1: Picture Path <String>
 */
private ["_cfgPath", "_displayName", "_picture"];
params [["_class", "", [""]]];
if(_class isEqualTo "") exitWith {["", ""]}; //Bad class passed.
_cfgPath = (configFile >> "CfgVehicles" >> _class);
if(!isClass _cfgPath) exitWith {["", ""]}; //Class doesn't exist in CfgVehicles

_displayName = getText(_cfgPath >> "displayName");
_picture = getText(_cfgPath >> "picture");

//Return
[_displayName, _picture]
