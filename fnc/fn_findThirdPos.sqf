/*
Author: SENSEI

Last modified: 12/28/2014

Description: finds third pos based on two given positions. positions create an equilateral triangle

             returns position
__________________________________________________________________*/
private ["_pos1","_pos2","_offset","_dX","_dY","_pos3","_mrk"];

_pos1 = param [0,[],[[]]];
_pos2 = param [1,[],[[]]];
// _offset = [_this, 2, 1, [0]] call BIS_fnc_param;

_dX = ((_pos2 select 0) - (_pos1 select 0));
_dY = ((_pos2 select 1) - (_pos1 select 1));
_pos3 = [((cos(60) * _dX - sin(60) * _dY) + (_pos1 select 0)), (sin(60) * _dX + cos(60) * _dY) + (_pos1 select 1)];

/*if (SEN_debug isEqualTo 1) then {
    _mrk = createMarker [format["%1",_pos1],_pos1];
    _mrk setMarkerType "mil_dot";
    _mrk setMarkerText "POS1";
    _mrk = createMarker [format["%1",_pos2],_pos2];
    _mrk setMarkerType "mil_dot";
    _mrk setMarkerText "POS2";
    _mrk = createMarker [format["%1",_pos3],_pos3];
    _mrk setMarkerType "mil_dot";
    _mrk setMarkerText "POS3";
};*/

_pos3
