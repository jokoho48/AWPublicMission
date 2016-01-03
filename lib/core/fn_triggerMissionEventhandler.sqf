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

    if (_eventCall == 0) then {
        [_eventParameter,_eventCode] remoteExecCall ["BIS_fnc_call", 0, false];
    } else {
        [_eventParameter,_eventCode] remoteExecCall ["BIS_fnc_spawn", 0, false];
    };

    missionNameSpace setVariable [_name, _eventVariable];
    nil
} count _this;
