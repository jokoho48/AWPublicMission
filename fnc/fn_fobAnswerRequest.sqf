/*
Author: SENSEI

Last modified: 8/8/2015

Description:  answer request for FOB control
__________________________________________________________________*/
params ["_userName", "_answer"];

call {
    if (_answer isEqualTo 0) exitWith {hintSilent (_userName + " denies FOB construction request.")};
    if (_answer isEqualTo 1) exitWith {
        hintSilent (_userName + " accepts FOB construction request.");
        uiSleep 5;
        _key = (actionKeys "curatorInterface") select 0;
        if (!isNil "_key") then {
            hint format ["Press the Zeus key, %1, to construct FOB Pirelli.",keyName _key]
        } else {
            hint format ["Press the Zeus key, %1, to construct FOB Pirelli.",'UNBOUND'];
        };
    };
    hintSilent "No reply for FOB construction request.";
};

//player setVariable ["SEN_inProgress",false];
