/*
Author: SENSEI

Last modified: 8/5/2014

Description: transfers objects to a requested owner

        returns nothing
__________________________________________________________________*/
if (!isServer) exitWith {};

params ["_obj","_transferTo"];

if (_obj isEqualType []) then {
    {
        _x setOwner _transferTo;
        [0,"Transferring OBJECT: %1 to CLIENT: %2.",_x,_transferTo] call SEN_fnc_log;
    } count _obj;
} else {
    _obj setOwner _transferTo;
    [0,"Transferring OBJECT: %1 to CLIENT: %2.",_obj,_transferTo] call SEN_fnc_log;
};
