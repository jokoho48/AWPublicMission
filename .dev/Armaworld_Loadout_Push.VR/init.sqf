/*
    @file Title: Test Framework by Creedcoder
    @file Version: 1.0
    @file Name: init.sqf
    @file Author: Creedcoder
    @file edit: 07.07.2015
    Copyright © 2015 Creedcoder, All rights reserved

    Do not use without permission!

    This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
    To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/ or send a letter to Creative Commons,
    444 Castro Street, Suite 900, Mountain View, California, 94041, USA.
*/

finishMissionInit;
enableSaving [false,false];

if ((paramsArray select 0) in [1, 3]) then {
    JK_USMC = ["MC_COMMAND", "MC_RADIOOP", "MC_LEADER", "MC_FTL", "MC_MEDIC", "MC_ARMAN", "MC_MG", "MC_ASSMG", "MC_AA", "MC_AAASS", "MC_AT", "MC_ATMK153", "MC_ATASS", "MC_ATASSMK153", "MC_GRENADIER", "MC_RIFLEMAN", "MC_STORMTROOPER", "MC_MARKSMAN", "MC_SPECIALIST", "MC_MORTARTEAMBIPOD", "MC_MORTARTEAMTUBE", "MC_M2TEAMGUN", "MC_M2TEAMTRIPOD", "MC_DRIVER"];
    JK_USARMY = ["AR_COMMAND", "AR_RADIOOP", "AR_LEADER", "AR_FTL", "AR_MEDIC", "AR_ARMAN", "AR_MG", "AR_ASSMG", "AR_AA", "AR_AAASS", "AR_AT", "AR_ATMK153", "AR_ATASS", "AR_ATASSMK153", "AR_GRENADIER", "AR_RIFLEMAN", "AR_STORMTROOPER", "AR_MARKSMAN", "AR_SPECIALIST", "AR_MORTARTEAMBIPOD", "AR_MORTARTEAMTUBE", "AR_M2TEAMGUN", "AR_M2TEAMTRIPOD", "AR_DRIVER"];
    JK_USSOF = ["SO_LEADER", "SO_GRENADIER", "SO_AT", "SO_ARMAN", "SO_MARKSMAN", "SO_SPECOPS","SO_AA", "SO_SPECIALIST"];
    JK_USSOFLIGHT = ["SOL_LEADER", "SOL_AT", "SOL_ARMAN", "SOL_GRENADIER", "SOL_MARKSMAN", "SOL_SPECIALIST", "SOL_SPECOPS", "SOL_AA"];
    JK_PARA = ["PARA_LEADER", "PARA_TROOPER", "PARA_ARMAN", "PARA_DROPMEDIC", "PARA_EXEXPERT", "PARA_GRENADIER", "PARA_MARKSMAN", "PARA_STORMTROOPER", "PARA_ASSAR"];
    JK_SPECIALCLASSES = ["SC_PJMEDIC", "SC_PILOT", "SC_JETPILOT", "SC_CREW", "SC_CREWCHIEF", "SC_DIVER_Leader","SC_DIVER","SC_DIVER_ARm","SC_DIVER_AT","SC_DIVER_Marksman","SC_DIVER_Specialist"];
    JK_CLASSES = JK_USMC + JK_USARMY + JK_USSOF + JK_USSOFLIGHT + JK_PARA + JK_SPECIALCLASSES;

    {
        private "_path";
        _path = call {
            if (_x in JK_USMC) exitWith {
                "USMC"
            };
            if (_x in JK_USARMY) exitWith {
                "USARMY"
            };
            if (_x in JK_USSOF) exitWith {
                "USSOF"
            };
            if (_x in JK_USSOFLIGHT) exitWith {
                "USSOFlight"
            };
            if (_x in JK_SPECIALCLASSES) exitWith {
                "special"
            };
            if (_x in JK_PARA) exitWith {
                "parachute"
            };
        };
        ["Loadouts:"+ _x,(compile preprocessFileLineNumbers format["lib\gear\loadouts\%1\fn_%2.sqf", _path, _x]), 1] spawn db_fnc_codesave;
        nil;
    } count JK_CLASSES;
};

if ((paramsArray select 0) in [2, 3]) then {
    BasicMedic = ["ACE_medicalSupplyCrate",5,[["ACE_fieldDressing", 100],["ACE_epinephrine", 25],["ACE_morphine", 25],["ACE_bloodIV", 15],["ACE_bloodIV_500", 15],["ACE_bloodIV_250", 15],["ACE_bodyBag", 10]]];
    Ammonition = ["Box_NATO_Wps_F",15,[["30Rnd_556x45_Stanag", 55],["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", 45],["rhsusf_mag_7x45acp_MHP", 5],["rhsusf_8Rnd_00Buck", 15],["rhsusf_20Rnd_762x51_m118_special_Mag", 20]]];
    mgAmmo = ["Box_NATO_Wps_F",15,[["rhs_200rnd_556x45_M_SAW", 11],["rhsusf_100Rnd_762x51", 11]]];
    para = ["Box_NATO_Wps_F",15,[["B_Parachute", 10]]];
    nade = ["Box_NATO_Wps_F",15,[["HandGrenade", 30],["SmokeShell", 15],["SmokeShellYellow", 15],["SmokeShellRed", 15],["SmokeShellPurple", 15],["SmokeShellBlue", 15],["SmokeShellGreen", 15],["Chemlight_Yellow", 15],["Chemlight_Red", 15],["Chemlight_Green", 15],["Chemlight_Blue", 15],["1Rnd_HE_Grenade_shell", 30],["1Rnd_Smoke_Grenade_shell", 15],["1Rnd_SmokeRed_Grenade_shell", 15],["1Rnd_SmokePurple_Grenade_shell", 15],["1Rnd_SmokeBlue_Grenade_shell", 15],["1Rnd_SmokeGreen_Grenade_shell", 15],["UGL_FlareWhite_F", 15],["UGL_FlareYellow_F", 15],["UGL_FlareRed_F", 15],["UGL_FlareGreen_F", 15],["ACE_M84", 5],["UGL_FlareCIR_F", 15]]];
    expl = ["Box_NATO_Wps_F",15,[["ACE_M26_Clacker", 10],["ACE_Clacker", 10],["SatchelCharge_Remote_Mag", 10],["DemoCharge_Remote_Mag", 10]]];
    atAmmo = ["Box_NATO_Wps_F",15,[["tf47_at4_HEDP", 5],["tf47_at4_HP", 4]]];
    staticAmmo = ["Box_NATO_Wps_F",30,[["tf47_at4_HEDP", 5],["tf47_at4_HP", 4],["HandGrenade", 30],["SmokeShell", 15],["SmokeShellYellow", 15],["SmokeShellRed", 15],["SmokeShellPurple", 15],["SmokeShellBlue", 15],["SmokeShellGreen", 15],["Chemlight_Yellow", 15],["Chemlight_Red", 15],["Chemlight_Green", 15],["Chemlight_Blue", 15],["1Rnd_HE_Grenade_shell", 30],["1Rnd_Smoke_Grenade_shell", 15],["1Rnd_SmokeRed_Grenade_shell", 15],["1Rnd_SmokePurple_Grenade_shell", 15],["1Rnd_SmokeBlue_Grenade_shell", 15],["1Rnd_SmokeGreen_Grenade_shell", 15],["UGL_FlareWhite_F", 15],["UGL_FlareYellow_F", 15],["UGL_FlareRed_F", 15],["UGL_FlareGreen_F", 15],["UGL_FlareCIR_F", 15],["ACE_M84", 5],["rhs_200rnd_556x45_M_SAW", 30],["rhsusf_100Rnd_762x51", 30],["rhsusf_5Rnd_00Buck", 30],["30Rnd_556x45_Stanag", 55],["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", 45],["rhsusf_20Rnd_762x51_m118_special_Mag", 20]]];
    staticATAmmo = ["Box_NATO_Wps_F",30,[["tf47_at4_HEDP", 10],["tf47_at4_HP", 8],["tf47_smaw_HEAA", 10],["tf47_smaw_HEDP", 5],["tf47_smaw_SR", 5],["tf47_m3maaws_HEAT", 10],["tf47_m3maaws_HEDP", 3],["tf47_m3maaws_HE", 3],["tf47_m3maaws_SMOKE", 3],["tf47_m3maaws_ILLUM", 3]]];
    atSmawAmmo =["Box_NATO_Wps_F",15,[["tf47_smaw_HEAA", 5],["tf47_smaw_HEDP", 5],["tf47_smaw_SR", 5]]];
    atM3Ammo = ["Box_NATO_Wps_F",15,[["tf47_m3maaws_HEAT", 7],["tf47_m3maaws_HEDP", 2],["tf47_m3maaws_HE", 2],["tf47_m3maaws_SMOKE", 2],["tf47_m3maaws_ILLUM", 2]]];
    radio = ["ACE_Box_Misc", 5, [["tf_rt1523g_rhs", 3],["tf_rt1523g_black", 2],["rhsusf_falconii", 10],["rhsusf_assult_eagleaiii_coy", 10],["tf_rt1523g_big_rhs", 1]]];
    misc = ["ACE_Box_Misc", 60, [["ACE_HuntIR_monitor", 3],["ACE_UAVBattery", 2],["ACE_RangeCard", 2],["ACE_Kestrel4500", 2],["ACE_Flashlight_MX991", 5],["ACE_Cellphone", 2],["ACE_DeadManSwitch", 2],["ACE_DefusalKit", 2],["ACE_M26_Clacker", 2],["ACE_Clacker", 2],["ACE_EarPlugs", 5],["ACE_DAGR", 2],["ACE_CableTie", 5],["ACE_IR_Strobe_Item", 5],["ACE_ATragMX", 2],["ACE_SpottingScope", 2],["ACE_SpareBarrel", 5],["ACE_RangeTable_82mm", 2],["ACE_microDAGR", 5],["ACE_bodyBag", 5],["ACE_MapTools", 5],["ACE_wirecutter", 2]]];
    UAV = ["ACE_Box_Misc", 5, [["B_UavTerminal", 5],["B_UAV_01_backpack_F", 5],["ACE_UAVBattery", 20]]];
    Empty = ["ACE_Box_Misc", 0, []];
    Wheel = ["ACE_Wheel", 0];
    Track = ["ACE_Track", 0];

    {
        _var = missionNamespace getVariable _x;
        ["Crate:" + _x, str _var, 1] spawn db_fnc_save;
        nil
    } count [
        "BasicMedic",
        "Ammonition",
        "mgAmmo",
        "para",
        "nade",
        "expl",
        "atAmmo",
        "staticAmmo",
        "staticATAmmo",
        "atSmawAmmo",
        "atM3Ammo",
        "radio",
        "misc",
        "UAV",
        "Empty",
        "Wheel",
        "Track"
    ];
};
