/*
Author: Peter Morrison (snYpir) & Philipp Pilhofer (raedor), Edited by SENSEI

Last modified: 1/10/2015

Description: Formats timer for tasks

             returns time
__________________________________________________________________*/
private ["_sec","_min"];
params ["_in"];

_sec = _in mod 1;
_min = _in - _sec;

format["%1:00",_min]
