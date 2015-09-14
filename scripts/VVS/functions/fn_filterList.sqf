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
if((lnbSize 38101) select 0 > -1) then
{
    lnbClear _control;
};

_vehicleList = [_filter] call VVS_fnc_filterType;
_row = 0;
{
    _cfgInfo = [_x] call VVS_fnc_cfgInfo;
    if(count _cfgInfo > 0) then
    {
        _sideName = ["EAST", "WEST", "GUER", "CIV"] select (_cfgInfo select 5);
        if (isNil "_sideName") then {_sideName = "UNKNOWN"};
        _control lnbAddRow["",_cfgInfo select 3,_sideName,_cfgInfo select 4];
        _control lnbSetPicture[[_row,0],_cfgInfo select 2];
        _control lnbSetData[[_row,0],_x];
        _control lnbSetData[[_row,1],(_cfgInfo select 3)];
        _row = _row + 1;
    };
} foreach _vehicleList;
