/*
 * Author: joko // Jonas
 * Load the Datebase files
 *
 * Arguments:
 * CrateKey <String>
 *
 * Return Value:
 * None
 *
 * Public: No
 */
if !(isServer) then {
    [_this,"JK_crate_fnc_loadDB", false] call BIS_fnc_MP;
} else {
    params ["_key", "_marker"];
    _key = [_key, 1] call db_fnc_load;
    [_key, _marker] call JK_crate_fnc_createCrate;
};
