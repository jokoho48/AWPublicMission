/*
Author: SENSEI

Start date: May 2014

Last modified: 8/15/2015

Description: Dynamic Combat Generator

License:
    Copyright 2015 Nicholas Clark (SENSEI). All rights reserved.
    This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
    To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/.
__________________________________________________________________*/
SEN_debug = (paramsArray select 1) isEqualTo 1;
if (SEN_debug) then {
    ["JK_MapClickEvent1", "onMapSingleClick", {
        if (_alt && local player) then {
            player setPos _pos;
        };
    }, player] call BIS_fnc_addStackedEventHandler;
};
enableSaving [false, false];
enableSentences false;
enableRadio false;
call SEN_fnc_setParams;
call compile preprocessFileLineNumbers "fixXEH.sqf";
if (isServer || (!isServer && !hasInterface)) then {
    jk_ammosuppavail = true;
    publicVariable "jk_ammosuppavail";
};

ace_medical_fixedStatics = [];
private _fnc_fixStatic = {
    params ["_vehicle"];
    private _vehType = typeOf _vehicle;
    if (!(_vehType in ace_medical_fixedStatics)) then {
        ace_medical_fixedStatics pushBack _vehType;
        [{
            1 preloadObject (_this select 0);
        }, {
        }, [_vehType]] call ace_common_fnc_waitUntilAndExecute;
    };
};
["StaticWeapon", "init", _fnc_fixStatic] call CBA_fnc_addClassEventHandler;
["Car", "init", _fnc_fixStatic] call CBA_fnc_addClassEventHandler;
addMissionEventHandler ["Loaded",{
    {
        [{
            1 preloadObject (_this select 0);
        }, {
        }, [_x]] call ace_common_fnc_waitUntilAndExecute;
    } forEach ace_medical_fixedStatics;
}];

waitUntil {!isNil "AME_Core_fnc_loadModules"};
["Core", "Replay"] call AME_Core_fnc_loadModules;
