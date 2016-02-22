/*
 * Author: joko // Jonas
 * Set HC Position in the Center of Players
 */
if (isNull SEN_HC) exitWith {};
[{
    if (isNull SEN_HC) exitWith {
        [_this select 1] call CBA_fnc_removePerFrameHandler;
    };

    private _centerPos = [0,0,0];
    private _count = {
        _centerPos = _centerPos vectorAdd (getPos _x);
        true
    } count allPlayers;
    if (_count != 1) then {
        _centerPos = _centerPos apply {_x/_count};
    };
    JK_HCTestPos = _centerPos;
    publicVariable "JK_HCTestPos";
}, 10] call CBA_fnc_addPerFrameHandler;
