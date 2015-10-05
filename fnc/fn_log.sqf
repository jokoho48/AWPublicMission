/*
Author: SENSEI

Last modified: 1/11/2015

Description: formats and logs messages to RPT

             returns nothing
__________________________________________________________________*/
params ["_type", "_msg"];
if !(isServer) exitWith {_this remoteExecCall ["SEN_fnc_log", false];};

if !(typeName _msg isEqualTo "STRING") exitWith {diag_log "SEN_ERROR: fn_log: Message is not of type STRING."};

if (typeName _type isEqualTo "SCALAR") then {
    _type = call {
        if (_type isEqualTo 1) exitWith {"SEN_WARNING: "};
        if (_type isEqualTo 2) exitWith {"SEN_ERROR: "};
        "SEN_LOG: "
    };
};
_time = if (!isNil "JK_DBSetup" && !isNil "db_fnc_time") then {
    call db_fnc_time;
} else {
    str serverTime;
};
_msg = _type + _msg;
_this set [1,_msg];
_this deleteAt 0;
_text = (format _this + " TARGET:" + str player);
diag_log _text;
_text spawn {
    private "_text";
    waitUntil {!isNil "JK_DBSetup"};
    ["ArmAWorldPublicMissionErrorLog.log", _this] call db_fnc_log;
};
if (SEN_debug isEqualTo 1) then {
    hintSilent _text;
};
