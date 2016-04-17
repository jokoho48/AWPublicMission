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
    _this remoteExecCall ["JK_crate_fnc_loadDB", 2, false];
} else {
    params ["_key", "_marker"];
    _key = [_key, 6] call db_fnc_load;
    [_key, _marker] call JK_crate_fnc_createCrate;
};
