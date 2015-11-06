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
_MC_command = ["a_sl", "b_sl", "plt_sgt"];
_AR_command = ["a_sl", "b_sl", "plt_sgt"];
//group leaders
_MC_SL = ["b1_ftl", "b2_ftl", "a1_ftl", "a2_ftl"];
_AR_SL = ["b1_ftl", "b2_ftl", "a1_ftl", "a2_ftl"];
//FireTeam Leader
_MC_FTL = [];
_AR_FTL = [];
//medics
_MC_medics = ["plt_med", "a_med", "b_med"];
_AR_medics = ["plt_med", "a_med", "b_med"];
//MG-Schützen
_MC_MG = ["b1_ar" ,"b2_ar", "a1_ar", "a2_ar"];
_AR_MG = ["b1_ar" ,"b2_ar", "a1_ar", "a2_ar"];
//assistant MG
_MC_assMG = ["b1_aar", "b2_aar", "a1_aar", "a2_aar"];
_AR_assMG = ["b1_aar", "b2_aar", "a1_aar", "a2_aar"];
//AT-Soldiers/AT-Specialists
_MC_AT = ["a1_at", "a2_at", "b1_at", "b2_at"];
_AR_AT = ["a1_at", "a2_at", "b1_at", "b2_at"];
//AT-Assistent
_MC_ATass = ["a1_ab", "a2_ab", "b1_ab", "b2_ab"];
_AR_ATass = ["a1_ab", "a2_ab", "b1_ab", "b2_ab"];
//Grenadiers
_MC_grenadier = ["b2_rm", "a2_rm"];
_AR_grenadier = ["b2_rm", "a2_rm"];
//Riflemen
_MC_soldier = ["a1_rm", "b1_rm"];
_AR_soldier = ["a1_rm", "b1_rm"];
//designated Marksmen
_MC_marksmen = [""];
_AR_marksmen = [""];
//engineers/repair-/explosive-specialists
_MC_spec = ["plt_eng"];
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
_MC_ATmk153 = [];
_AR_ATmk153 = [];
//AT-SMAW-Assistant
_MC_ATAssmk153 = [];
_AR_ATAssmk153 = [];
//CQC Shotgun Stormtrooper
_MC_stormtrooper = [];
_AR_stormtrooper = [];
//Spec Ops
_SO_SpecOps = [];
_SO_ARman = [];
_SO_at = [];
_SO_grenadier = [];
_SO_leader = [];
_SO_marksman = [];
_SO_SpecOps = [];
_SO_specialist = [];
//radioOp
_MC_radioOp = [];
_AR_radioOp = [];
//Paratrooper
_PARA_trooper = [];
//Para-Drop-
_PARA_ARman = [];
//Para-Drop-
_PARA_DropMedic = [];
//Para-Drop-
_PARA_ExExpert = [];
//Para-Drop-
_PARA_Grenadier = [];
//Para-Drop-
_PARA_Leader = [];
//Para-Drop-
_PARA_Marksman = [];
//CQC Shotgun Para-Variant
_PARA_Stormtrooper = [];
//Para-Drop-AssAR
_PARA_AssAR = [];
//SpecOps Para-Variant
_PARA_SpecOps = [];
//Mortar team (Bipod)
_MC_mortarTeamBipod = [];
//Mortar team (Tube)
_MC_mortarTeamTube = [];
//M2 team (Tripod)
_AR_m2TeamTripod = [];
//M2 team (Gun)
_AR_m2TeamGun = [];

// insert Classnames of the units
_MC_commandClass = ["B_Soldier_SL_F"];
_MC_SLClass = ["B_Soldier_TL_F"];
_MC_FTLClass = [];
_MC_medicsClass = ["B_medic_F"];
_MC_MGClass = ["B_soldier_AR_F"];
_MC_assMGClass = ["B_soldier_AAR_F"];
_MC_ATClass = ["B_soldier_LAT_F"];
_MC_ATmk153Class = ["B_Soldier_HAT_F"];
_MC_ATassClass = ["B_Soldier_A_F"];
_MC_ATAssmk153Class = [];
_MC_grenadierClass = [];
_MC_soldierClass = ["B_Soldier_F"];
_MC_stormtrooperClass = [];
_MC_marksmenClass = [];
_MC_specClass = [];
_MC_radioOpClass = [];
_SO_specOpsClass = [];
_SO_SpecOps = [];
_SO_ARman = [];
_SO_at = [];
_SO_grenadier = [];
_SO_leader = [];
_SO_marksman = [];
_SO_SpecOps = [];
_SO_specialist = [];
_PARA_trooperClass = ["B_Soldier_P_F"];
_PARA_ARmanClass = [];
_PARA_DropMedicClass = [];
_PARA_ExExpertClass = [];
_PARA_GrenadierClass = [];
_PARA_LeaderClass = [];
_PARA_MarksmanClass = [];
_PARA_StormtrooperClass = [];
_PARA_AssARClass = [];
_pilotsClass = ["B_Pilot_F"];
_crewClass = ["B_crew_F"];
_jetPilotClass = [];
_pjMedicClass = [];
_MC_mortarTeamBipodClass = [];
_MC_mortarTeamTubeClass = [];
_AR_m2TeamTripodClass = [];
_AR_m2TeamGunClass = [];
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
    case (_object in _MC_command): {"command"};
    case (_object in _MC_SL): {"leader"};
    case (_object in _MC_FTL): {"FTL"};
    case (_object in _MC_medics): {"medic"};
    case (_object in _MC_MG): {"MG"};
    case (_object in _MC_stormtrooper): {"stormtrooper"};
    case (_object in _MC_assMG): {"assMG"};
    case (_object in _MC_AT): {"AT"};
    case (_object in _MC_ATmk153): {"ATmk153"};
    case (_object in _MC_ATass): {"ATAss"};
    case (_object in _MC_ATassmk153): {"ATAssmk153"};
    case (_object in _MC_grenadier): {"grenadier"};
    case (_object in _MC_soldier): {"Rifleman"};
    case (_object in _MC_marksmen): {"marksman"};
    case (_object in _MC_radioOp): {"radioOp"};
    case (_object in _MC_spec): {"specialist"};
    case (_object in _SO_SpecOps): {"SpecOps"};
    case (_object in _SO_SL): {"leader"};
    case (_object in _SO_ARman): {"ARman"};
    case (_object in _SO_AT): {"AT"};
    case (_object in _SO_grenadier): {"grenadier"};
    case (_object in _SO_marksmen): {"marksman"};
    case (_object in _SO_spec): {"specialist"};
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
    case (_object in _PARA_trooper): {"paratrooper"};
    case (_object in _PARA_ARman): {"paraARman"};
    case (_object in _PARA_DropMedic): {"paraDropMedic"};
    case (_object in _PARA_ExExpert): {"paraExExpert"};
    case (_object in _PARA_Grenadier): {"paraGrenadier"};
    case (_object in _PARA_Leader): {"paraLeader"};
    case (_object in _PARA_Marksman): {"paraMarksman"};
    case (_object in _PARA_Stormtrooper): {"paraStormtrooper"};
    case (_object in _PARA_AssAR): {"paraAssAR"};
    case (_object in _pilots): {"pilot"};
    case (_object in _crew): {"crew"};
    case (_object in _jetPilot): {"jetPilot"};
    case (_object in _pjMedic): {"pjMedic"};
    case (_object in _MC_mortarTeamBipod): {"mortarTeamBipod"};
    case (_object in _MC_mortarTeamTube): {"mortarTeamTube"};
    case (_object in _AR_m2TeamTripod): {"AR_m2TeamBipod"};
    case (_object in _AR_m2TeamGun): {"AR_m2TeamTube"};
    default{""};
};

if (_class == "") then {
    _class = switch true do {
        case (typeOf _target in _MC_commandClass): {"command"};
        case (typeOf _target in _MC_FTLClass): {"FTL"};
        case (typeOf _target in _MC_SLClass): {"leader"};
        case (typeOf _target in _MC_medicsClass): {"medic"};
        case (typeOf _target in _MC_MGClass): {"MG"};
        case (typeOf _target in _MC_assMGClass): {"assMG"};
        case (typeOf _target in _MC_ATClass): {"AT"};
        case (typeOf _target in _MC_ATmk153Class): {"ATmk153"};
        case (typeOf _target in _MC_ATassClass): {"ATAss"};
        case (typeOf _target in _MC_ATAssmk153Class): {"ATAssmk153"};
        case (typeOf _target in _MC_grenadierClass): {"grenadier"};
        case (typeOf _target in _MC_soldierClass): {"Rifleman"};
        case (typeOf _target in _MC_stormtrooperClass): {"stormtrooper"};
        case (typeOf _target in _MC_marksmenClass): {"marksman"};
        case (typeOf _target in _MC_specClass): {"specialist"};
        case (typeOf _target in _MC_RadioOpClass): {"RadioOp"};
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
        case (typeOf _target in _SO_specOpsClass): {"SpecOps"};
        case (typeOf _target in _SO_SpecOps): {"SpecOps"};
        case (typeOf _target in _SO_SL): {"leader"};
        case (typeOf _target in _SO_ARman): {"ARman"};
        case (typeOf _target in _SO_AT): {"AT"};
        case (typeOf _target in _SO_grenadier): {"grenadier"};
        case (typeOf _target in _SO_marksmen): {"marksman"};
        case (typeOf _target in _SO_spec): {"specialist"};
        case (typeOf _target in _PARA_trooperClass): {"paratrooper"};
        case (typeOf _target in _PARA_ARmanClass): {"paraARman"};
        case (typeOf _target in _PARA_DropMedicClass): {"paraDropMedic"};
        case (typeOf _target in _PARA_ExExpertClass): {"paraExExpert"};
        case (typeOf _target in _PARA_GrenadierClass): {"paraGrenadier"};
        case (typeOf _target in _PARA_LeadeClassr): {"paraLeader"};
        case (typeOf _target in _PARA_MarksmanClass): {"paraMarksman"};
        case (typeOf _target in _PARA_StormtrooperClass): {"paraStormtrooper"};
        case (typeOf _target in _PARA_AssARClass): {"paraAssARClass"};
        case (typeOf _target in _PARA_SpecOpsClass): {"paraSpecOpsClass"};
        case (typeOf _target in _pilotsClass): {"pilot"};
        case (typeOf _target in _crewClass): {"crew"};
        case (typeOf _target in _jetPilotClass): {"jetPilot"};
        case (typeOf _target in _pjMedicClass): {"pjMedic"};
        case (typeOf _target in _MC_mortarTeamBipodClass): {"mortarTeamBipod"};
        case (typeOf _target in _MC_mortarTeamTubeClass): {"mortarTeamTube"};
        case (typeOf _target in _AR_m2TeamTripodClass): {"AR_m2TeamTripod"};
        case (typeOf _target in _AR_m2TeamGunClass): {"AR_m2TeamGun"};
        default {"Rifleman"};
    };
};

[_target, _class] call JK_loadOut_fnc_selectGear;
