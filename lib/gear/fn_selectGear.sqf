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
params [
    ["_code",{},[{}]]
];

if !(isNil 'JK_respawn_EVH') then {
    player removeEventHandler ['Respawn',JK_respawn_EVH];
};
JK_respawn_EVH = player addEventhandler['Respawn', _code];
[player] call _code;
