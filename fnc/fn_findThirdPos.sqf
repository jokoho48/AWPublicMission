/*
Author: SENSEI

Last modified: 12/28/2014

Description: finds third pos based on two given positions. positions create an equilateral triangle

             returns position
__________________________________________________________________*/
private ["_offset", "_dX", "_dY", "_pos3", "_mrk"];
params [["_pos1",[], [[]]], ["_pos2",[],[[]]]];

_pos1 params ["_pos1X", "_pos1Y"];
_pos2 params ["_pos2X", "_pos2Y"];

_dX = (_pos2X - _pos1X);
_dY = (_pos2Y - _pos1Y);
_pos3 = [((cos(60) * _dX - sin(60) * _dY) + _pos1X), (sin(60) * _dX + cos(60) * _dY) + _pos1Y];

_pos3
