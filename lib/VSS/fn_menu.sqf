/*
 * Author: CreedCoder, joko // Jonas
 * Create all for VSS Menu
 *
 * Arguments:
 * 0: Condition <Integer>
 *
 * Return Value:
 * None
 */

private ["_display", "_vehiclelist", "_filter", "_filterSelect", "_vehilceSelect", "_condition", "_prize", "_vehicleListIndex", "_vehicleList", "_vehdata", "_className"];
disableSerialization;
params [
    ["_condition",-1,[0]]
];
waitUntil{!isNull (findDisplay 18000)};
_display = findDisplay 18000;
_vehiclelist = _display displayCtrl 18001;
_filter = _display displayCtrl 18002;
_pricetag = _display displayCtrl 18004;
_filterSelect = lbData [18002,lbCurSel 18002];
_vehilceSelect = lbData [18001,lbCurSel 18001];


switch (_condition) do {
    case 0: {
        //Load Veh List
        if (isNil "JK_VSS_ListTickets") then {
          ["JK_VSS_ListTickets", player, "JK_VSS_fnc_load", true, 2] remoteExec ["db_fnc_load", 2, false];
        } else {
          [4] call JK_VSS_fnc_menu;
        };
    };
    case 1: {
        //Veh List Select
        if(_vehilceSelect != "") then {
            _pricetag ctrlSetText format["Price: %1 Tickets", (call compile format["%1",_vehilceSelect]) select 1];
        } else {
            _pricetag ctrlSetText "Select Vehicle!";
        };
    };
    case 2: {
        //Filter Select
        lbClear _vehiclelist;
        {
            if(_filterSelect in [(_x select 0), "Alle"]) then {
                _prize = (_x select 2);
                if (JK_VehClass in (_x select 3) || "All" in (_x select 3)) then {
                    {
                        _info = [_x] call JK_VSS_fnc_cfgInfo;
                        _vehicleListIndex = _vehicleList lbAdd (_info select 0);
                        _vehicleList lbSetPicture [_vehicleListIndex, (_info select 1)];
                        _vehicleList lbSetData [_vehicleListIndex,str([_x,_prize])];
                        nil;
                    } count (_x select 1);
                };
            };
            nil;
        } count JK_VSS_ListTickets;
    };
    case 3: {
        //Spawn Veh
        if (player getVariable ["SEN_inProgress",false]) exitWith {};
        player setVariable ["SEN_inProgress",true];
        if(_vehilceSelect != "") then {
            _vehdata = call compile format["%1",_vehilceSelect];
            if ((_vehdata select 1) <= JK_TicketSystem) then {
                [[(_vehdata select 0), (_vehdata select 1), getMarkerPos "SEN_vehSpawn_mrk", markerDir "SEN_vehSpawn_mrk"],"JK_VSS_fnc_spawnVSS", false, false, false] call BIS_fnc_MP;
                [[0,format ["fn_spawnVehicle: Player %1 Spawn the Vehicle %2 for %3", name player, str (_vehdata select 0), (_vehdata select 1)]], "SEN_fnc_log", false] call BIS_fnc_MP;
            };
        };
        player setVariable ["SEN_inProgress",false];
    };
    case 4: {
        //Update Filter
        lbClear _filter;
        _filter lbAdd "Alle";
        _filter lbSetData[(lbSize _filter)-1,"Alle"];
        {
            if (JK_VehClass in (_x select 3)) then {
                _filter lbAdd (_x select 0);
                _filter lbSetData[(lbSize _filter)-1,(_x select 0)];
            };
            nil;
        } count JK_VSS_ListTickets;
        _filter lbSetCurSel 0;
    };
    default {
        hint "Error!";
    };
};
