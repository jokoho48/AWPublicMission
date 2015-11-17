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
    private "_var";
    _var = [_this, 1] call db_fnc_load;
    _var call JK_crate_fnc_crateCreate;
};
