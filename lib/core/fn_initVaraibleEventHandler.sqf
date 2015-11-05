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

JK_fnc_addEHLoop = {
    JK_varEHPFHID = [{
        if (JK_VariableEventhandler isEqualTo []) then exitWith {
            [JK_varEHPFHID] call CBA_fnc_removePerFrameHandler;
            JK_varEHPFHID = nil;
        };
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
};
