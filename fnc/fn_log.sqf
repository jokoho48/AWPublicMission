/*
Author: SENSEI

Last modified: 1/11/2015

Description: formats and logs messages to RPT

             returns nothing
__________________________________________________________________*/
params ["_type", "_msg"];
if !(isServer) then {_this remoteExecCall ["SEN_fnc_log", 2];};

if !(typeName _msg isEqualTo "STRING") exitWith {diag_log "SEN_ERROR: fn_log: Message is not of type STRING."};

if (typeName _type isEqualTo "SCALAR") then {
    _type = call {
        if (_type isEqualTo 1) exitWith {"WARNING: "};
        if (_type isEqualTo 2) exitWith {"ERROR: "};
        "LOG: "
    };
};
_time = if (!isNil "db_fnc_time") then {
    [true, "_", 2] call db_fnc_time;
} else {
    str serverTime;
};
_msg = _type + _msg;
_this set [1,_msg];
_this deleteAt 0;
_text = format ["[%2] %1", (format _this), _time];
diag_log _text;

if (!isNil "db_fnc_log") then {
    ["ArmAWorldPublicMissionLog.log", _text] call db_fnc_log;
};

if (SEN_debug) then {
    hintSilent _text;
};
