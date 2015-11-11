/*
Author: SENSEI

Last modified: 8/5/2015
__________________________________________________________________*/
SEN_debug = (paramsArray select 1) isEqualTo 1;

if !(getMarkerColor "SEN_med_mrk" isEqualTo "") then {
    _med = ["Land_Hospital_main_F", "Land_Hospital_side2_F", "Land_Hospital_side1_F", "Land_Medevac_house_V1_F", "Land_Medevac_HQ_V1_F"];
    {
        if ((typeOf _x) in _med) then {_x setvariable["ace_medical_isMedicalFacility", true, true]};
    } forEach ((getMarkerPos "SEN_med_mrk") nearObjects ["House", 100]);
};

[((SEN_range*0.04) max 400),false] call compile preprocessFileLineNumbers "scripts\SEN_civ.sqf";
[((SEN_range*0.04) max 400),((ceil (SEN_range/512)) max 10) min 25] call compile preprocessFileLineNumbers "scripts\SEN_animal.sqf";


[["SEN_approvalCiv", "JK_TicketSystem", "SEN_ClearedCitys"], {
    params ["_key", "_value", "", "_preValue"];
    if ("JK_TicketSystem" == _key) then {
        if (_value > _preValue) then {
            [["SEN_ticketAdd",[floor(_value - _preValue)]],"BIS_fnc_showNotification",true] call BIS_fnc_MP;
        } else {
            [["SEN_ticketSubstact",[floor(_preValue - _value)]],"BIS_fnc_showNotification",true] call BIS_fnc_MP;
        };
    };
    if ("SEN_approvalCiv" == _key) then {
        if (_value > _preValue) then {
            [["SEN_approvalBonus",[floor(_value - _preValue)]],"BIS_fnc_showNotification",true] call BIS_fnc_MP;
        };
    };
    [_key, str _value] spawn db_fnc_save;
}] call JK_Core_fnc_addVariableEventHandler;

[] spawn {
    waitUntil {!isNil "bis_fnc_init" && {bis_fnc_init}};
    sleep 10;
    "JK_registerPlayer" addPublicVariableEventHandler {
        private "_owner";
        params ["" ,"_player"];
        _owner = owner _player;
        {
            _owner publicVariableClient _x;
        } count ["JK_TicketSystem", "SEN_approvalCiv", "predefinedLocations", "iedInitialArray", "JK_iedTown", "JK_VSS_ListTickets", "JK_allBuildingPositions"];
    };
};
