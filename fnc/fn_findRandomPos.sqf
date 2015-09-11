/*
Author: SENSEI

Last modified: 8/11/2015

Description: finds random position from center

             returns position
__________________________________________________________________*/
private ["_range","_dir","_dMin","_dMax","_pos"];
params [["_center",[],[[]]],["_min",0,[0]],["_max",100,[0]],["_dirArray",[],[[]]]];

if (count _dirArray isEqualTo 0) then {
    _dir = random 360
} else {
    _dirArray params ["_dMin", "_dMax"];
    _dir = (_dMin + random _dMax) min _dMax;
};
_range = (ceil (random _max)) max _min;
_pos = [(_center select 0) + (sin _dir) * _range, (_center select 1) + (cos _dir) * _range, 0];

_pos
