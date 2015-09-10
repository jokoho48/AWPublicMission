/*
    Author: joko // Jonas

    Description:
    Take Unit and String and Call it

    Parameter(s):
    0: Unit
    1: Class as String
    Returns:
    - Nothing

    Example:
    [player,"GearName"] call JK_loadOut_fnc_selectGear;
*/
params["_unit", "_class"];

if (rating _unit >= 400) then {
    _unit addrating (floor (rating - 600));
};
_side = side _unit;
if !(str(_side) in ["WEST","EAST","GUER"]) then {
    _side = playerSide;
    if !(str(_side) in ["WEST","EAST","GUER"]) then {
        _side = "WEST";
    };
};
call Compile format ["if (isNil 'jk_loadOut_fnc_%2%3') then {jk_loadOut_fnc_%2%3 = {hint 'Critical Error';}}; [%1] call jk_loadOut_fnc_%2%3; if !(isNil 'JK_respawn_EVH') then { %1 removeEventHandler ['Respawn',JK_respawn_EVH]; }; JK_respawn_EVH = %1 addEventhandler['Respawn',{ if !(%1 getVariable ['BIS_revive_incapacitated',true]) then { _this call jk_loadOut_fnc_%2%3 }; }];",_unit, _class,_side];
if (true) exitWith {};
