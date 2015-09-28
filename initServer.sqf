/*
Author: SENSEI

Last modified: 8/5/2015
__________________________________________________________________*/
waitUntil {diag_log "error"; !isNil "JK_DBSetup"};
if (isNil "db_fnc_save") then {
    db_fnc_save = {
        profileNamespace setVariable [_this select 0, call compile _this select 1];
        saveProfileNamespace;
    };
};

jk_db_fnc_load = if (isNil "db_fnc_load") then {
    { profileNameSpace getVariable _this }
} else {
    { (_this select 0) call db_fnc_load }
};

JK_TicketSystem = call compile (["JK_TicketSystem", str 9850] call jk_db_fnc_load);
publicVariable "JK_TicketSystem";

SEN_approvalCiv = call compile (["SEN_approvalCiv", str (-502)] call jk_db_fnc_load);
publicVariable "SEN_approvalCiv";

SEN_blacklistLocation = call compile (["SEN_ClearedCitiys", str []] call jk_db_fnc_load);
publicVariable "SEN_blacklistLocation";

missionNameSpace setVariable ["SEN_transportReady", 1];
if (isClass (configfile >> "CfgPatches" >> "task_force_radio")) then {call compile preprocessFileLineNumbers "scripts\SEN_tfrSettings.sqf"};
//[1500,0,false,2000,2500,1500] call compile preprocessFileLineNumbers "scripts\zbe_cache\main.sqf";

if !(getMarkerColor "SEN_med_mrk" isEqualTo "") then {
    _med = ["Land_Hospital_main_F", "Land_Hospital_side2_F", "Land_Hospital_side1_F", "Land_Medevac_house_V1_F", "Land_Medevac_HQ_V1_F"];
    {
        if ((typeOf _x) in _med) then {_x setvariable["ace_medical_isMedicalFacility", true, true]};
    } forEach ((getMarkerPos "SEN_med_mrk") nearObjects ["House", 100]);
};

waitUntil {sleep 1; SEN_complete isEqualTo 2};

[] call compile preprocessFileLineNumbers "scripts\SEN_occupyTrg.sqf";
[] call compile preprocessFileLineNumbers "tasks\SEN_taskHandler.sqf";
[((SEN_range*0.04) max 400),false] call compile preprocessFileLineNumbers "scripts\SEN_civ.sqf";
[((SEN_range*0.04) max 400),((ceil (SEN_range/512)) max 10) min 25] call compile preprocessFileLineNumbers "scripts\SEN_animal.sqf";


[["SEN_approvalCiv", "JK_TicketSystem", "SEN_ClearedCitiys"], {
    params ["_key", "_value"];
    [_key, str _value] spawn db_fnc_save;
}] call JK_Core_fnc_addVariableEventHandler;

[] spawn {
    waitUntil {sleep 5; !isNil "bis_fnc_init"};
    "JK_registerPlayer" addPublicVariableEventHandler {
        params ["" ,"_player"];
        (owner _player) publicVariableClient "JK_TicketSystem";
        (owner _player) publicVariableClient "SEN_ClearedCitiys";
        (owner _player) publicVariableClient "SEN_approvalCiv";
    };
};
