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

_vehicleList = (JK_allVVSVars select (JK_allVVSNames find _filter))
if(_vehicleList isEqualTo []) exitWith {hintSilent "You dont have any Vehicle you can Spawn!"; 38100 closeDisplay 0;};

{
    private ["_cfgInfo", "_costs"];
    _cfgInfo = [_x] call VVS_fnc_cfgInfo;
    _costs = format ["%1 Tickets" ,_x select 1];
    _control lnbAddRow ["",_costs];
    if !((_cfgInfo select 2) isEqualTo "pictureThing") then {
        _control lnbSetPicture [[_forEachIndex, 0], _cfgInfo select 1];
    };
    _control lnbSetData[[_forEachIndex, 0], (_cfgInfo select 0)]; //Set the displayName to index/column 1
} foreach _vehicleList;
