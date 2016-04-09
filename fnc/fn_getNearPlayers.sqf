/*
Author: SENSEI

Last modified: 7/16/2015

Description: gets near players

        returns array
__________________________________________________________________*/
params ["_pos","_range"];
private _players = [];

{
    if (_x distance _pos <= _range && {alive _x}) then {_players pushBack _x};
    nil
} count (call SEN_fnc_getPlayers);

_players
