/*
 * Author: CreedCoder, joko // Jonas
 * set Variable and add Entry to VSS List
 *
 * Arguments:
 * Vehicle Array list <Array>
 *
 * Return Value:
 * None
 */
disableSerialization;
private ["_display", "_filter", "_array"];
waitUntil{!isNull (findDisplay 18000)};
_display = findDisplay 18000;
_filter = _display displayCtrl 18002;

JK_VSS_ListTickets = +_this;
publicVariable "JK_VSS_ListTickets";
lbClear _filter;
_filter lbAdd "Alle";
_filter lbSetData[(lbSize _filter)-1,"Alle"];
{
    if(JK_VehClass == (_x select 3)) then {
        _filter lbAdd (_x select 0);
        _filter lbSetData[(lbSize _filter)-1,(_x select 0)];
    };
    nil;
} count JK_VSS_ListTickets;
_filter lbSetCurSel 0;
