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
    private _count = count allPlayers;
    {
        _centerPos = _centerPos vectorAdd ((getPos _x) vectorMultiply (1/_count));
        true
    } count allPlayers;
    SEN_HC setPos _centerPos;
}, 10] call CBA_fnc_addPerFrameHandler;
