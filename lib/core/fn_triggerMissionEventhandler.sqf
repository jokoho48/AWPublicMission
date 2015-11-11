/*
 * Name: triggerMissionEvent
 *
 * Author: joko // Jonas
 *
 * Discription: Trigger a Event that is defined in the Mission
 *
 * Parameter:
 *  N:
 *    0: EventName as STRING
 *    1: Target as Object or Boolean or Array
 *
 */

{
    private ["_eventCode", "_eventVariable"];

    _x params ["_name" ,"_target"];
    // get Event Content
    _eventVariable = missionNamespace getVariable [_name, [{ hint "Error Event Not Found"; },[],0]];

    _eventVariable params ["_eventFunction","_eventParameter","_eventCall","_times"];
    _eventCode = {};
    // Check if Count for Execute
    if !(_times == 0) exitWith {};

    _times = _times - 1;
    //Debug
    if (!isNil "JK_Debug") then {
        hint format["Event %1 Start Now", _x];
    };
    //Convert Function name to Code
    _eventCode = if (typeName _eventFunction == "STRING") then {
         missionNamespace getVariable [_eventFunction,{hint "Error Function Not Found"}]
    } else {
        _eventFunction
    };

    // Call Code with BIS_fnc_MP @todo(Update to remoteExec)
    if (_eventCall == 0) then {
        [_eventParameter,_eventCode,"BIS_fnc_call",_target, false, true] call BIS_fnc_MP;
    } else {
        [_eventParameter,_eventCode,"BIS_fnc_spawn",_target, false, true] call BIS_fnc_MP;
    };

    missionNameSpace setVariable [_name, _eventVariable];
    nil
} count _this;
