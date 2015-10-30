/*
 * Author: joko // Jonas
 * Add Action to unit
 *
 * Arguments:
 * 0: Target <Object>
 * 1: Title <String>
 * 2: Code or String that gets executed <Code, String>
 * 3: Condition <Code, String>
 * 4: Arguments <Any>
 * 5: Index <Integer>
 * 6: Distance <Float>
 *
 * Return Value:
 * Index <Integer>
 *
 * Example:
 * [player, "test", {test}, {"test" == "test"}, [], 12, 12] call JK_Core_fnc_addAction
 *
 * Public: No
 */

params [
    ["_target", objNull , [objNull]],
    ["_text", "", ["STRING"]],
    ["_code", "", ["STRING", {}]],
    ["_condition", "true", ["STRING", {true}]],
    ["_args", []],
    ["_index", 0],
    ["_distance", 5, [5]]
];
_condition = [_condition] call ace_common_fnc_codeToString;
_condition = format ["%1 && player distance _target < %2", _condition, _distance];
_target addAction [_text, _code, _args, _index, false, false, "", _condition];
