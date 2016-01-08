/*
 * Author: joko // Jonas
 * Flatten Array for Classnames
 *
 * Arguments:
 * Array
 *
 * Return Value:
 * Flatten Array
 *
 * Example:
 * [["classname1", 2], ["className2", 3]] call SEN_fnc_flattenSpawnArrays;
 *
 * Public: Yes
 */

private _ret = [];
{
    if (_x isEqualType []) then {
        _x params ["_className", "_count"];
        for "_i" from 0 to _count do {
            _ret pushBack _className;
        };
    } else {
        _ret pushBack _x;
    };
    nil
} count _this;
for "_s" from floor(random 10) to 0 step -1 do {
    _ret = [_ret] call CBA_fnc_shuffle;
};
_ret
