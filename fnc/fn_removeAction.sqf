/*
Author: SENSEI

Last modified: 7/22/2014

Description: removes multiple actions

        returns nothing
__________________________________________________________________*/
private ["_obj","_id"];

_obj = _this select 0;
_id = _this select 1;

{_obj removeAction _x} count _id;