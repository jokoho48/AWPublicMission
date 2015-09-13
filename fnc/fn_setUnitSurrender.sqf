/*
Author: SENSEI

Last modified: 7/27/2015

Description: set unit in surrender stance

        returns boolean
__________________________________________________________________*/
private ["_obj","_driver"];
params [["_obj", objNull, [objNull]]];

if (typeOf _obj isKindOf "Air") exitWith {[1,"fn_setUnitSurrender: Object is AIR type. Can't surrender."] call SEN_fnc_log;};

if (typeOf _obj isKindOf "LandVehicle" || {typeOf _obj isKindOf "Ship"}) exitWith {
    if (typeOf _obj isKindOf "StaticWeapon") then {
        {
            moveOut _x;
            _x setBehaviour "CARELESS";
            [_x,true] call ace_captives_fnc_setSurrendered;
            [0,"%1 surrenders.",typeOf _x] call SEN_fnc_log;
        } forEach (crew _obj);

    } else {
        _driver = driver _obj;
        _driver setVariable ["SEN_patrol_exit",true];
        _obj limitSpeed 0;
        sleep 2;
        group _driver leaveVehicle _obj;
        sleep 5;
        {
            _x setBehaviour "CARELESS";
            doStop _x;
            [_x,true] call ace_captives_fnc_setSurrendered;
            [0,"%1 surrenders.",typeOf _x] call SEN_fnc_log;
        } forEach units (group _driver);
    };
    true
};

_obj setVariable ["SEN_patrol_exit",true];
_obj setBehaviour "CARELESS";
doStop _obj;
[_obj,true] call ace_captives_fnc_setSurrendered;
[0,"%1 surrenders.",typeOf _obj] call SEN_fnc_log;
true
