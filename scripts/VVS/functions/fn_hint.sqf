/*
    File: fn_hint.sqf
    Author: joko // Jonas
*/
private ["_cfgInfo", "_current", "_costs", "_text"];

_current = lnbData[38101,[(lnbCurSelRow 38101),0]];
_cfgInfo = [_current] call VVS_fnc_cfgInfo;

_index = [JK_VehicleTickets, _cfgInfo select 4] call BIS_fnc_findInPairs;
if (_index == -1) then {_index = [JK_VehicleTickets, "Default"] call BIS_fnc_findInPairs;};
_costs = (JK_VehicleTickets select _index) select 1;
_temp = JK_TicketSystem - _costs;
if (_temp <= 0) then {
    _text = format["You missing %1 tickets to this vehicle to spawn", _temp];
} else {
    _text = format ["The Vehicle Costs %1 tickets", _costs];
};

hintSilent _text;
