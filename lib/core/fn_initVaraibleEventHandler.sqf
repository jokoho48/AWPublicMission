/*
 * Author: joko // Jonas
 * Initalize the Variable Event handler
 *
 * Arguments:
 *
 * Return Value:
 *
 * Example:
 * [] call JK_Core_fnc_initVariableEventHandler;
 *
 * Public: No
 */
if (isNil "JK_VariableEventhandler") then {
    JK_VariableEventhandler = [];
};

[{
    {
        private ["_variable"];
        _x params ["_varName", "_namespace", "_variableOld", "_code"];
        _variable = _namespace getVariable _varName;
        if !(_variable isEqualTo _variableOld) then {
            [_varName, _variable, _namespace] call _code;
            _x set [2, _variable];
        };
        nil
    } count JK_VariableEventhandler;
}, 0, []] call CBA_fnc_addPerFrameHandler;
