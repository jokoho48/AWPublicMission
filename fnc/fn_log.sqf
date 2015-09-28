/*
Author: SENSEI

Last modified: 1/11/2015

Description: formats and logs messages to RPT

             returns nothing
__________________________________________________________________*/
params ["_type", "_msg"];
if !(typeName _type isEqualTo "SCALAR") exitWith {diag_log "SEN_ERROR: fn_log: type is not of type SCALAR."};
if !(typeName _msg isEqualTo "STRING") exitWith {diag_log "SEN_ERROR: fn_log: Message is not of type STRING."};

call {
    if (_type isEqualTo 1) exitWith {_type = "SEN_WARNING: "};
    if (_type isEqualTo 2) exitWith {_type = "SEN_ERROR: "};
    _type = "SEN_LOG: ";
};

_msg = _type + _msg;
_this set [1,_msg];
_this deleteAt 0;
_text = (format _this + " TARGET:" + str player);
diag_log _text;
_text spawn {
    private "_text";
    waitUntil {!isNil "JK_DBSetup"};

    ["ArmAWorldPublicMissionErrorLog.log", _this] remoteExecCall ["db_fnc_log", 2, false];
};
if (SEN_debug isEqualTo 1) then {
    hintSilent _text;
};
