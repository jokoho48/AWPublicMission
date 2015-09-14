/*
loadout script by joko
Idea by Belbo
adds the loadouts to the specific playable units for the side West
Call from initPlayerLocal.sqf via:
[object,true] call JK_loadOut_fnc_applyLoadout;
    with
    _this select 0 = object - target the loadout is applied to.
    _this select 1 = boolean - whether or not the target in _zeus is supposed to be invincible.
*/
JK_var_gearByClasses = true;
// insert names of new units here in their correspondent Objects:
//commanders
_command = [];
//group leaders
_SL = [];
//medics
_medics = [];
//Assaultriflemen
_AR = [];
//MG-Schützen
_MG = [];
//assistant Assaultriflemen
_assMG = [];
//AT-Soldiers/AT-Specialists
_AT = [];
//Grenadiers
_grenadier = [];
//Riflemen
_soldier = [];
//designated Marksmen
_marksmen = [];
//engineers/repair-/explosive-specialists
_spec = [];
//pilots
_pilots = [];
//Crew
_crew = [];
//Pilot
_jetPilot = [];
//PJ
_pjMedic = [];

// insert Classnames of the units
_commandClass = ["B_Soldier_SL_F"];
_SLClass = ["B_Soldier_TL_F"];
_medicsClass = ["B_medic_F"];
_ARClass = [];
_MGClass = [];
_assMGClass = [];
_ATClass = [];
_grenadierClass = [];
_soldierClass = ["B_Soldier_F"];
_marksmenClass = [];
_specClass = [];
_pilotsClass = ["B_Pilot_F"];
_crewClass = ["B_crew_F"];
_jetPilotClass = [];
_pjMedicClass = [];

///// No editing necessary below this line /////
private ["_object","_target"];
params [["_target", player, [objNull]]];
_object = str _target;

_class = "";

//switch to select the applicable loadout function
if (!JK_var_gearByClasses) then {
    _class = switch true do {
        case (_object in _command): {"command"};
        case (_object in _SL): {"leader"};
        case (_object in _medics): {"medic"};
        case (_object in _AR): {"ARman"};
        case (_object in _MG): {"MG"};
        case (_object in _assMG): {"assMG"};
        case (_object in _AT): {"AT"};
        case (_object in _grenadier): {"grenadier"};
        case (_object in _soldier): {"Rifleman"};
        case (_object in _marksmen): {"marksman"};
        case (_object in _spec): {"specialist"};
        case (_object in _pilots): {"pilot"};
        case (_object in _crew): {"crew"};
        case (_object in _jetPilot): {"jetPilot"};
        case (_object in _pjMedic): {"pjMedic"};
        default{""};
    };
};
if (_class == "" || JK_var_gearByClasses) then {
    _class = switch true do {
        case (typeOf _target in _commandClass): {"command"};
        case (typeOf _target in _SLClass): {"leader"};
        case (typeOf _target in _medicsClass): {"medic"};
        case (typeOf _target in _ARClass): {"ARman"};
        case (typeOf _target in _MGClass): {"MG"};
        case (typeOf _target in _assMGClass): {"assMG"};
        case (typeOf _target in _ATClass): {"AT"};
        case (typeOf _target in _grenadierClass): {"grenadier"};
        case (typeOf _target in _soldierClass): {"Rifleman"};
        case (typeOf _target in _marksmenClass): {"marksman"};
        case (typeOf _target in _specClass): {"specialist"};
        case (typeOf _target in _pilotsClass): {"pilot"};
        case (typeOf _target in _crewClass): {"crew"};
        case (typeOf _target in _jetPilotClass): {"jetPilot"};
        case (typeOf _target  in _pjMedicClass): {"pjMedic"};
        default {"Rifleman"};
    };
};

[_target,_class] call JK_loadOut_fnc_selectGear;

if (true) exitWith {};
