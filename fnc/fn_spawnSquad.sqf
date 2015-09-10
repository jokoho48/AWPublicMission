/*
Author: SENSEI

Last modified: 7/16/2015

Description: spawns squad

        returns array, [[base objects],[driver array],grp]
__________________________________________________________________*/
private ["_pos","_side","_minCount","_vehChance","_baseType","_uncache","_return","_base","_vehArray","_grp"];

_pos = param [0,[0,0,0],[[]]];
_side = param [1,SEN_enemySide];
_minCount = param [2,0,[0]];
_vehChance = param [3,0,[0]];
_baseType = param [4,0,[0]];
_uncache = param [5,false];

_return = [];

call {
    if (_baseType isEqualTo 1) exitWith {_base = [_pos] call SEN_fnc_spawnBaseSmall; _return pushBack _base};
    if (_baseType isEqualTo 2) exitWith {_base = [_pos] call SEN_fnc_spawnBase; _return pushBack _base};
    _return pushBack [];
};

if (random 1 < _vehChance) then {
    _vehArray = [([_pos, 80, 150, 2, 0, 1, 0] call BIS_fnc_findSafePos),1,1,_side,_uncache] call SEN_fnc_spawnGroup;
    _return pushBack _vehArray;
} else {
    _return pushBack [];
};

_grp = [_pos,0,(_minCount max (call SEN_fnc_setStrength)),_side,_uncache] call SEN_fnc_spawnGroup;
_return pushBack _grp;

_return