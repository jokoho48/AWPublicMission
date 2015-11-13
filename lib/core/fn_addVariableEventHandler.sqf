/*
 * Author: joko // Jonas
 * add a Variable Eventhandler that get triggerd if the Variable change
 *
 * Arguments:
 * 0: Variable Name or Array with Variable Names <STRING, ARRAY>
 * 1: Code that get Executed if the Variable Executed <CODE>
 * 2: Object/Namespace/Controll/Group/Team_Member/Task/Location to from where the variable get Readed (default: missionNamespace) <OBJECT, NAMESPACE, Control, Group, Team_Member, Task, Location>
 *
 * Return Value:
 * None
 *
 * Note:
 * Local Variables Dont work with that System
 *
 * Example:
 * ["JK_TestVariable", {hint _this;}, currentNamespace] call JK_Core_fnc_addVariableEventHandler;
 *
 * Public: Yes
 */
private "_variable";
params ["_varNames", "_code", ["_namespace", missionNameSpace, [missionNamespace, objNull, controlNull, grpNull, taskNull, locationNull]]];

if (typeName _varNames != "ARRAY") then {
    _varNames = [_varNames];
};

{
    _variable = _namespace getVariable [_x, "hudlehudlehudlehudlehudlehudlehudle"];
    JK_VariableEventhandler pushBack [_x, _namespace, _variable, _code];
    nil
} count _varNames;

if (isNil "JK_varEHPFHID") then {
    call JK_fnc_addEHLoop;
};
nil
