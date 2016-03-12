/*
 * Author: joko // Jonas
 * Add Action for Selling Vehicles
 *
 * Arguments:
 * Vehicle Array list <Array>
 *
 * Return Value:
 * None
 */
JK_fnc_isSellable = {
    vehicle player != player &&
    {(player distance JK_sellingPoint) < 10} &&
    {!(isNil {(vehicle player) getVariable "JK_VSS_Cost"})} &&
    {!(isEngineOn (vehicle player))}
};

JK_fnc_Sell = {
    private ["_vehicle", "_costs", "_allHitPoints", "_damages", "_damages", "_count", "_earnBack"];
    _vehicle = vehicle Player;

    _costs = _vehicle getVariable ["JK_VSS_Cost", 0];

    _allHitPoints = getAllHitPointsDamage _vehicle;
    _damages = _allHitPoints select 2;
    _damage = 0;
    _count = {
        _damage = _damage + _x;
        true
    } count _damages;

    _earnBack = round ((1 - _damage/_count) * _costs);
    JK_TicketSystem = JK_TicketSystem + _earnBack;
    publicVariable "JK_TicketSystem";

    hint format ["The Vehicle Costs %1 Tickets", _earnBack];

    doGetOut player;
    {
        deleteVehicle _vehicle;
        nil
    } count (_vehicle getVariable ["ace_cargo_loaded", []]);
    deleteVehicle _vehicle;
};
[] spawn {
    waitUntil {!isNull player};
    [player, "Sell Vehicle", JK_fnc_Sell, JK_fnc_isSellable] call JK_Core_fnc_addAction;
    player addEventHandler["Respawn", {
        [player, "Sell Vehicle", JK_fnc_Sell, JK_fnc_isSellable] call JK_Core_fnc_addAction;
    }];
}
