/*
Author: SENSEI

Start date: May 2014

Last modified: 8/15/2015

Description: Dynamic Combat Generator

To Do:
    create more tasks that interact with FOB

Known Issues:
    momentary lag when SEN_occupy.sqf runs
    ACE3 - ACE_server.pbo overwrites ACE variables set by DCG

License:
    Copyright 2015 Nicholas Clark (SENSEI). All rights reserved.
    This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
    To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/.
__________________________________________________________________*/
["Preload"] call BIS_fnc_arsenal;
enableSaving [false, false];
enableSentences false;
enableRadio false;
call SEN_fnc_setParams;
[] call compile preprocessFileLineNumbers "scripts\zlt_fieldrepair.sqf";

if (isServer || (!isServer && !hasInterface)) then {
    jk_ammosuppavail = true;
    publicVariable "jk_ammosuppavail";
    waitUntil {sleep 0.1; SEN_complete isEqualTo 1};
    [] spawn compile preprocessFileLineNumbers "scripts\SEN_occupy.sqf";
};

if (hasInterface) then {
    ["playerInventoryChanged", {
        if ((_this select 0 distance (getMarkerPos "Base")) <= 100) then {
            {
                deleteVehicle _x;
            } count nearestObjects [_this select 0, ["WeaponHolder", "GroundWeaponHolder", "WeaponHolderSimulated"], 10];
        };
    }] call ace_common_fnc_addEventHandler;
};
