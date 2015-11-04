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
JK_var_gearByClasses = false;
// insert names of new units here in their correspondent Objects:
//commanders
_command = ["a_sl", "b_sl", "plt_sgt"];
_AR_command = ["a_sl", "b_sl", "plt_sgt"];
//group leaders
_SL = ["b1_ftl", "b2_ftl", "a1_ftl", "a2_ftl"];
_AR_SL = ["b1_ftl", "b2_ftl", "a1_ftl", "a2_ftl"];
//FireTeam Leader
_FTL = [];
_AR_FTL = [];
//medics
_medics = ["plt_med", "a_med", "b_med"];
_AR_medics = ["plt_med", "a_med", "b_med"];
//MG-Schützen
_MG = ["b1_ar" ,"b2_ar", "a1_ar", "a2_ar"];
_AR_MG = ["b1_ar" ,"b2_ar", "a1_ar", "a2_ar"];
//assistant MG
_assMG = ["b1_aar", "b2_aar", "a1_aar", "a2_aar"];
_AR_assMG = ["b1_aar", "b2_aar", "a1_aar", "a2_aar"];
//AT-Soldiers/AT-Specialists
_AT = ["a1_at", "a2_at", "b1_at", "b2_at"];
_AR_AT = ["a1_at", "a2_at", "b1_at", "b2_at"];
//AT-Assistent
_ATass = ["a1_ab", "a2_ab", "b1_ab", "b2_ab"];
_AR_ATass = ["a1_ab", "a2_ab", "b1_ab", "b2_ab"];
//Grenadiers
_grenadier = ["b2_rm", "a2_rm"];
_AR_grenadier = ["b2_rm", "a2_rm"];
//Riflemen
_soldier = ["a1_rm", "b1_rm"];
_AR_soldier = ["a1_rm", "b1_rm"];
//designated Marksmen
_marksmen = [""];
_AR_marksmen = [""];
//engineers/repair-/explosive-specialists
_spec = ["plt_eng"];
_AR_spec = ["plt_eng"];
//pilots
_pilots = ["r_1", "r_2", "r_3"];
//Crew
_crew = ["rh1_driver", "rh1_co", "rh1_gunner"];
//Pilot
_jetPilot = ["pj_1", "pj_2"];
//PJ
_pjMedic = ["r_4"];
//AT-SMAW
_ATmk153 = [];
_AR_ATmk153 = [];
//AT-SMAW-Assistant
_ATAssmk153 = [];
_AR_ATAssmk153 = [];
//CQC Shotgun Stormtrooper
_stormtrooper = [];
_AR_stormtrooper = [];
//Spec Ops
_SpecOps = [];
//radioOp
_radioOp = [];
_AR_radioOp = [];
//Paratrooper
_paratrooper = [];
//Para-Drop-
_paraARman = [];
//Para-Drop-
_paraDropMedic = [];
//Para-Drop-
_paraExExpert = [];
//Para-Drop-
_paraGrenadier = [];
//Para-Drop-
_paraLeader = [];
//Para-Drop-
_paraMarksman = [];
//CQC Shotgun Para-Variant
_paraStormtrooper = [];
//Para-Drop-AssAR
_paraAssAR = [];
//SpecOps Para-Variant
_paraSpecOps = [];
//Mortar team (Bipod)
_mortarTeamBipod = [];
//Mortar team (Tube)
_mortarTeamTube = [];
//M2 team (Tripod)
_m2TeamTripod = [];
//M2 team (Gun)
_m2TeamGun = [];

// insert Classnames of the units
_commandClass = ["B_Soldier_SL_F"];
_SLClass = ["B_Soldier_TL_F"];
_FTLClass = [];
_medicsClass = ["B_medic_F"];
_MGClass = ["B_soldier_AR_F"];
_assMGClass = ["B_soldier_AAR_F"];
_ATClass = ["B_soldier_LAT_F"];
_ATmk153Class = ["B_Soldier_HAT_F"];
_ATassClass = ["B_Soldier_A_F"];
_ATAssmk153Class = [];
_grenadierClass = [];
_soldierClass = ["B_Soldier_F"];
_stormtrooperClass = [];
_marksmenClass = [];
_specClass = [];
_specOpsClass = [];
_radioOpClass = [];
_paratrooperClass = ["B_Soldier_P_F"];
_paraARmanClass = [];
_paraDropMedicClass = [];
_paraExExpertClass = [];
_paraGrenadierClass = [];
_paraLeaderClass = [];
_paraMarksmanClass = [];
_paraStormtrooperClass = [];
_paraAssARClass = [];
_pilotsClass = ["B_Pilot_F"];
_crewClass = ["B_crew_F"];
_jetPilotClass = [];
_pjMedicClass = [];
_mortarTeamBipodClass = [];
_mortarTeamTubeClass = [];
_m2TeamTripodClass = [];
_m2TeamGunClass = [];
_AR_commandClass = ["B_Soldier_SL_F"];
_AR_SLClass = ["B_Soldier_TL_F"];
_AR_FTLClass = [];
_AR_medicsClass = ["B_medic_F"];
_AR_MGClass = ["B_soldier_AR_F"];
_AR_assMGClass = ["B_soldier_AAR_F"];
_AR_ATClass = ["B_soldier_LAT_F"];
_AR_ATmk153Class = ["B_Soldier_HAT_F"];
_AR_ATassClass = ["B_Soldier_A_F"];
_AR_ATAssmk153Class = [];
_AR_grenadierClass = [];
_AR_soldierClass = ["B_Soldier_F"];
_AR_stormtrooperClass = [];
_AR_marksmenClass = [];
_AR_specClass = [];
_AR_radioOpClass = [];

///// No editing necessary below this line /////
private ["_object","_target"];
params [["_target", player, [objNull]]];
_object = str _target;

_class = "";

//switch to select the applicable loadout function
_class = switch true do {
    case (_object in _command): {"command"};
    case (_object in _SL): {"leader"};
    case (_object in _FTL): {"FTL"};
    case (_object in _medics): {"medic"};
    case (_object in _MG): {"MG"};
    case (_object in _stormtrooper): {"stormtrooper"};
    case (_object in _assMG): {"assMG"};
    case (_object in _AT): {"AT"};
    case (_object in _ATmk153): {"ATmk153"};
    case (_object in _ATass): {"ATAss"};
    case (_object in _ATassmk153): {"ATAssmk153"};
    case (_object in _grenadier): {"grenadier"};
    case (_object in _soldier): {"Rifleman"};
    case (_object in _marksmen): {"marksman"};
    case (_object in _radioOp): {"radioOp"};
    case (_object in _SpecOps): {"SpecOps"};
    case (_object in _spec): {"specialist"};
    case (_object in _AR_command): {"command"};
    case (_object in _AR_SL): {"leader"};
    case (_object in _AR_FTL): {"FTL"};
    case (_object in _AR_medics): {"medic"};
    case (_object in _AR_MG): {"MG"};
    case (_object in _AR_stormtrooper): {"stormtrooper"};
    case (_object in _AR_assMG): {"assMG"};
    case (_object in _AR_AT): {"AT"};
    case (_object in _AR_ATmk153): {"ATmk153"};
    case (_object in _AR_ATass): {"ATAss"};
    case (_object in _AR_ATassmk153): {"ATAssmk153"};
    case (_object in _AR_grenadier): {"grenadier"};
    case (_object in _AR_soldier): {"Rifleman"};
    case (_object in _AR_marksmen): {"marksman"};
    case (_object in _AR_radioOp): {"radioOp"};
    case (_object in _AR_spec): {"specialist"};
    case (_object in _paratrooper): {"paratrooper"};
    case (_object in _paraARman): {"paraARman"};
    case (_object in _paraDropMedic): {"paraDropMedic"};
    case (_object in _paraExExpert): {"paraExExpert"};
    case (_object in _paraGrenadier): {"paraGrenadier"};
    case (_object in _paraLeader): {"paraLeader"};
    case (_object in _paraMarksman): {"paraMarksman"};
    case (_object in _paraStormtrooper): {"paraStormtrooper"};
    case (_object in _paraAssAR): {"paraAssAR"};
    case (_object in _pilots): {"pilot"};
    case (_object in _crew): {"crew"};
    case (_object in _jetPilot): {"jetPilot"};
    case (_object in _pjMedic): {"pjMedic"};
    case (_object in _mortarTeamBipod): {"mortarTeamBipod"};
    case (_object in _mortarTeamTube): {"mortarTeamTube"};
    case (_object in _m2TeamTripod): {"m2TeamBipod"};
    case (_object in _m2TeamGun): {"m2TeamTube"};
    default{""};
};

if (_class == "") then {
    _class = switch true do {
        case (typeOf _target in _commandClass): {"command"};
        case (typeOf _target in _FTLClass): {"FTL"};
        case (typeOf _target in _SLClass): {"leader"};
        case (typeOf _target in _medicsClass): {"medic"};
        case (typeOf _target in _MGClass): {"MG"};
        case (typeOf _target in _assMGClass): {"assMG"};
        case (typeOf _target in _ATClass): {"AT"};
        case (typeOf _target in _ATmk153Class): {"ATmk153"};
        case (typeOf _target in _ATassClass): {"ATAss"};
        case (typeOf _target in _ATAssmk153Class): {"ATAssmk153"};
        case (typeOf _target in _grenadierClass): {"grenadier"};
        case (typeOf _target in _soldierClass): {"Rifleman"};
        case (typeOf _target in _stormtrooperClass): {"stormtrooper"};
        case (typeOf _target in _marksmenClass): {"marksman"};
        case (typeOf _target in _specClass): {"specialist"};
        case (typeOf _target in _RadioOpClass): {"RadioOp"};
        case (typeOf _target in _AR_commandClass): {"command"};
        case (typeOf _target in _AR_FTLClass): {"FTL"};
        case (typeOf _target in _AR_SLClass): {"leader"};
        case (typeOf _target in _AR_medicsClass): {"medic"};
        case (typeOf _target in _AR_MGClass): {"MG"};
        case (typeOf _target in _AR_assMGClass): {"assMG"};
        case (typeOf _target in _AR_ATClass): {"AT"};
        case (typeOf _target in _AR_ATmk153Class): {"ATmk153"};
        case (typeOf _target in _AR_ATassClass): {"ATAss"};
        case (typeOf _target in _AR_ATAssmk153Class): {"ATAssmk153"};
        case (typeOf _target in _AR_grenadierClass): {"grenadier"};
        case (typeOf _target in _AR_soldierClass): {"Rifleman"};
        case (typeOf _target in _AR_stormtrooperClass): {"stormtrooper"};
        case (typeOf _target in _AR_marksmenClass): {"marksman"};
        case (typeOf _target in _AR_specClass): {"specialist"};
        case (typeOf _target in _AR_RadioOpClass): {"RadioOp"};
        case (typeOf _target in _specOpsClass): {"SpecOps"};
        case (typeOf _target in _paratrooperClass): {"paratrooper"};
        case (typeOf _target in _paraARmanClass): {"paraARman"};
        case (typeOf _target in _paraDropMedicClass): {"paraDropMedic"};
        case (typeOf _target in _paraExExpertClass): {"paraExExpert"};
        case (typeOf _target in _paraGrenadierClass): {"paraGrenadier"};
        case (typeOf _target in _paraLeadeClassr): {"paraLeader"};
        case (typeOf _target in _paraMarksmanClass): {"paraMarksman"};
        case (typeOf _target in _paraStormtrooperClass): {"paraStormtrooper"};
        case (typeOf _target in _paraAssARClass): {"paraAssARClass"};
        case (typeOf _target in _paraSpecOpsClass): {"paraSpecOpsClass"};
        case (typeOf _target in _pilotsClass): {"pilot"};
        case (typeOf _target in _crewClass): {"crew"};
        case (typeOf _target in _jetPilotClass): {"jetPilot"};
        case (typeOf _target in _pjMedicClass): {"pjMedic"};
        case (typeOf _target in _mortarTeamBipodClass): {"mortarTeamBipod"};
        case (typeOf _target in _mortarTeamTubeClass): {"mortarTeamTube"};
        case (typeOf _target in _m2TeamTripodClass): {"m2TeamTripod"};
        case (typeOf _target in _m2TeamGunClass): {"m2TeamGun"};
        default {"Rifleman"};
    };
};

[_target, _class] call JK_loadOut_fnc_selectGear;
