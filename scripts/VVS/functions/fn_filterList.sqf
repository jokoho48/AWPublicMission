/*
    File: fn_filterList.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Refreshes the filtering list.
*/
private["_control","_filter","_row"];
params ["" ,"_curSel"];
if(_curSel isEqualTo -1) exitWith {};

_filter = lbData[38102,_curSel];

_control = ((findDisplay 38100) displayCtrl 38101);
if((lnbSize 38101) select 0 > -1) then {
    lnbClear _control;
};

_vehicleList = [_filter] call VVS_fnc_filterType;
_row = 0;
{
    private ["_cfgInfo", "_sideName", "_costs"];
    _cfgInfo = [_x] call VVS_fnc_cfgInfo;
    if !(_cfgInfo isEqualTo []) then {
        _costs = (JK_VehicleTickets find (_cfgInfo select 4)) + 1;
        if (_costs == 0) then {_costs = (JK_VehicleTickets find "Default") + 1;};
        _costs = format ["%1 Tickets" ,JK_VehicleTickets select _costs];
        _sideName = ["EAST", "WEST", "GUER", "CIV"] select (_cfgInfo select 5);
        if (isNil "_sideName") then {_sideName = "UNKNOWN"};
        _control lnbAddRow["", _cfgInfo select 3, _sideName, _costs];
        _control lnbSetPicture[[_row, 0], _cfgInfo select 2];
        _control lnbSetData[[_row, 0], _x];
        _control lnbSetData[[_row, 1], (_cfgInfo select 3)];
        _row = _row + 1;
    };
} foreach _vehicleList;
