/*
 * Author: joko // Jonas
 * Find a Save Postion for a Unit, this function every return a Position
 *
 * Arguments:
 * 0: Postion <Array>
 * 1: Radius <Float>
 * 2: Vehicle Class <String> (Optional)
 *
 * Return Value:
 * Save Position <Array>
 *
 * Example:
 * [getPos player, 10] call SEN_fnc_findSavePosition;
 */
params ["_pos", "_radius", "_type"];

_retPos = if (isNil "_type") then {
    _pos findEmptyPosition [0, _radius];
} else {
    _pos findEmptyPosition [0, _radius, _type];
};

if (_retPos isEqualTo []) exitWith {
    if (isNil "_type") then {
        [_pos, _radius + 10] call SEN_fnc_findSavePosition;
    } else {
        [_pos, _radius + 10, _type] call SEN_fnc_findSavePosition;
    };
};

_retPos
