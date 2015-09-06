// Author: Quiksilver
// Eject vehicles crew

params ["_v"];
{
    _x action ["getOut",_v];
} count (crew _v);
