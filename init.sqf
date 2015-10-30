/*
Author: SENSEI

Start date: May 2014

Last modified: 8/15/2015

Description: Dynamic Combat Generator

To Do:
    create more tasks that interact with FOB

Known Issues:
    momentary lag when SEN_occupy.sqf runs

License:
    Copyright 2015 Nicholas Clark (SENSEI). All rights reserved.
    This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
    To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/.
__________________________________________________________________*/
SEN_debug = (paramsArray select 1) isEqualTo 1;
waitUntil {!isServer ||{!isNil "JK_DBSetup"}};
if (SEN_debug) then {
    ["JK_MapClickEvent1","onMapSingleClick",{
        if (_ctrl) then {
            _this setPos _pos;
        };
    },player] call BIS_fnc_addStackedEventHandler;
};
enableSaving [false, false];
enableSentences false;
enableRadio false;
call SEN_fnc_setParams;
call compile preprocessFileLineNumbers "fixXEH.sqf";
if (isServer || (!isServer && !hasInterface)) then {
    jk_ammosuppavail = true;
    publicVariable "jk_ammosuppavail";
    waitUntil {sleep 0.1; SEN_complete isEqualTo 1};
    [] spawn compile preprocessFileLineNumbers "scripts\SEN_occupy.sqf";
};
/*
if (hasInterface) then {
    ["playerInventoryChanged", {
        private "_hint";
        _hint = false;
        if (!isnull (findDisplay 602) && {(_this select 0 distance (getMarkerPos "Base")) <= 300}) then {
            {
                deleteVehicle _x;
                _hint = true;
            } count nearestObjects [_this select 0, ["WeaponHolder", "GroundWeaponHolder", "WeaponHolderSimulated"], 300];
            if (_hint) then {
                hintSilent parseText "<t size='1.5'><t color='#ff0000'>Bist du blöd man wirft seine Ausrüstung nicht auf den Boden!</br><t size='1.5'><t color='#ff0000'> Schäm dich!</br><t size='1.5'><t color='#ff0000'> So das hast du nun davon jetzt hast du eins davon weniger.";
            };
        };
    }] call ace_common_fnc_addEventHandler;
};
*/
//call compile preprocessFileLineNumbers "EPD\Ied_Init.sqf";
