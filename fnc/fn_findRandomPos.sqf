/*
Author: SENSEI

Last modified: 8/11/2015

Description: finds random position from center

             returns position
__________________________________________________________________*/
private ["_center","_min","_max","_dirArray","_range","_dir","_dMin","_dMax","_pos"];

_center = param [0,[],[[]]];
_min = param [1,0,[0]];
_max = param [2,100,[0]];
_dirArray = param [3,[],[[]]];

if (count _dirArray isEqualTo 0) then {
    _dir = random 360
} else {
    _dMin = _dirArray select 1;
    _dMax = _dirArray select 2;
    _dir = (_dMin + random _dMax) min _dMax;
};
_range = (ceil (random _max)) max _min;
_pos = [(_center select 0) + (sin _dir) * _range, (_center select 1) + (cos _dir) * _range, 0];

_pos
