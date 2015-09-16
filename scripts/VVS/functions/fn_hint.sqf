/*
    File: fn_hint.sqf
    Author: joko // Jonas
*/
private ["_cfgInfo", "_current", "_costs", "_text"];

_current = lnbData[38101,[(lnbCurSelRow 38101),0]];
_cfgInfo = [_current] call VVS_fnc_cfgInfo;

_costs = (JK_VehicleTickets find (_cfgInfo select 4)) + 1;
if (_costs == 0) then {_costs = (JK_VehicleTickets find "Default") + 1;};
_costs = JK_VehicleTickets select _costs;

if ((JK_TicketSystem - _costs) <= 0) then {
    _text = format["You missing %1 tickets to this vehicle to spawn", _costs];
} else {
    _text = format ["The Vehicle Costs %1 tickets", _costs];
};

hintSilent _text;
