/*
 * Name: addMissionEvent
 *
 * Author: joko // Jonas
 *
 * Discription: Add a Event for the Mission Flow
 *
 * Parameter:
 * 0: EventName as STRING
 * 1: Code or Function as STRING
 * 2: Parameter for Code as Array (Optinal)
 * 3: Is 0: Called or 1:Spawned (Optinal default: 0)
 * 4: Times Called(how often can this EventCallen(Optinal default: -1))
 * 5: Protected (Optinal default true)
 * 6: Override (Optinal default: false)
 *
 * Return:
 * Boolean - Event is set or not
 *
 */
private "_isOK";
params["_eventName","_eventFunction",["_eventParameter",[]],["_eventCall",0],["_times",-1],["_protected",true],["_overrideEvent",false]];
_isOK = false;
_return = nil;
if !(isNil _eventName) then {
    if (_overrideEvent) then {
        _isProtected = (missionNamespace getVariable _eventName) select 4;
        if (_isProtected) then {_isOK = false} else {_isOK = true};
    };
} else {
    _isOK = true;
};

if (_isOK) then {
    _eventVariable = [_eventFunction, _eventParameter, _eventCall, _times, _protected];
    missionNamespace setVariable [_eventName, _eventVariable];
    publicVariable _eventName;
    _return = true;
} else {
    if !(isNil "JK_Debug") then {
        _error = format["Error Event:%1 can not set because Event is Protected"];
        diag_log _error;
        hint _error;
    };
    _return = false;
};
_return
