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
JK_loadOut_fnc_gear = compile preprocessFileLineNumbers "fn_gear.sqf";
JK_loadOut_fnc_addContainer = compile preprocessFileLineNumbers "fn_addContainer.sqf";
JK_loadOut_fnc_addWeapon = compile preprocessFileLineNumbers "fn_addWeapon.sqf";
finishMissionInit;
enableSaving [false,false];
_varAllHandle = [];
if ((paramsArray select 0) in [1, 3]) then {
    JK_CLASSES = ["commander", "leader", "uav", "medic", "rifleman", "gren", "at", "atAss", "mg", "pilot", "marksman", "aa", "aaAss","mmg","mmgAss","crewchief","crewman","sniper","spotter","engineer","breacher"];
    {
        private ["_path", "_handle", "_fnc"];
        _fnc = compile preprocessFileLineNumbers format["lib\gear\loadouts\fn_%1.sqf", _x];
        _handle = ["Loadouts:"+ _x, _fnc, 6] spawn db_fnc_codesave;
        _varAllHandle pushBack _handle;
        nil;
    } count JK_CLASSES;
};

if ((paramsArray select 0) in [2, 3]) then {
    BasicMedic = ["ACE_medicalSupplyCrate",5,[["ACE_fieldDressing", 100],["ACE_epinephrine", 25],["ACE_morphine", 25],["ACE_bloodIV", 15],["ACE_bloodIV_500", 15],["ACE_bloodIV_250", 15],["ACE_bodyBag", 10]]];
    Ammonition = ["Box_NATO_Wps_F",15,[["30Rnd_556x45_Stanag", 55],["30Rnd_556x45_Stanag_Tracer_Red", 40],["11Rnd_45ACP_Mag", 15],["20Rnd_762x51_Mag", 15]]];
    mgAmmo = ["Box_NATO_Wps_F",15,[["SMA_150Rnd_762_Mk319_Tracer", 10],["SMA_150Rnd_762_Mk319", 10],["SMA_150Rnd_762_Mk319_Mixed", 10],["CUP_200Rnd_TE4_Red_Tracer_556x45_M249", 10],["CUP_100Rnd_TE4_LRT4_Red_Tracer_762x51_Belt_M", 8]]];
    para = ["Box_NATO_Wps_F",15,[["B_Parachute", 10]]];
    nade = ["Box_NATO_Wps_F",15,[["HandGrenade", 30],["SmokeShell", 15],["SmokeShellYellow", 15],["SmokeShellRed", 15],["SmokeShellPurple", 15],["SmokeShellBlue", 15],["SmokeShellGreen", 15],["Chemlight_Yellow", 15],["Chemlight_Red", 15],["Chemlight_Green", 15],["Chemlight_Blue", 15],["1Rnd_HE_Grenade_shell", 30],["1Rnd_Smoke_Grenade_shell", 15],["1Rnd_SmokeRed_Grenade_shell", 15],["1Rnd_SmokePurple_Grenade_shell", 15],["1Rnd_SmokeBlue_Grenade_shell", 15],["1Rnd_SmokeGreen_Grenade_shell", 15],["UGL_FlareWhite_F", 15],["UGL_FlareYellow_F", 15],["UGL_FlareRed_F", 15],["UGL_FlareGreen_F", 15],["ACE_M84", 5],["UGL_FlareCIR_F", 15]]];
    expl = ["Box_NATO_Wps_F",15,[["ACE_M26_Clacker", 10],["ACE_Clacker", 10],["SatchelCharge_Remote_Mag", 10],["DemoCharge_Remote_Mag", 10]]];
    atAmmo = ["Box_NATO_Wps_F",15,[["tf47_at4_HEDP", 5],["tf47_at4_HP", 4]]];
    staticAmmo = ["Box_NATO_Wps_F",30,[["SMA_150Rnd_762_Mk319_Tracer", 10],["SMA_150Rnd_762_Mk319", 10],["SMA_150Rnd_762_Mk319_Mixed", 10],["tf47_at4_HEDP", 5],["tf47_at4_HP", 4],["HandGrenade", 30],["SmokeShell", 15],["SmokeShellYellow", 15],["SmokeShellRed", 15],["SmokeShellPurple", 15],["SmokeShellBlue", 15],["SmokeShellGreen", 15],["Chemlight_Yellow", 15],["Chemlight_Red", 15],["Chemlight_Green", 15],["Chemlight_Blue", 15],["1Rnd_HE_Grenade_shell", 30],["1Rnd_Smoke_Grenade_shell", 15],["1Rnd_SmokeRed_Grenade_shell", 15],["1Rnd_SmokePurple_Grenade_shell", 15],["1Rnd_SmokeBlue_Grenade_shell", 15],["1Rnd_SmokeGreen_Grenade_shell", 15],["UGL_FlareWhite_F", 15],["UGL_FlareYellow_F", 15],["UGL_FlareRed_F", 15],["UGL_FlareGreen_F", 15],["UGL_FlareCIR_F", 15],["ACE_M84", 5],["30Rnd_556x45_Stanag", 55],["CUP_200Rnd_TE4_Red_Tracer_556x45_M249", 20]]];
    staticATAmmo = ["Box_NATO_Wps_F",30,[["tf47_at4_HEDP", 10],["tf47_at4_HP", 8],["tf47_smaw_HEAA", 10],["tf47_smaw_HEDP", 5],["tf47_smaw_SR", 5],["tf47_m3maaws_HEAT", 10],["tf47_m3maaws_HEDP", 3],["tf47_m3maaws_HE", 3],["tf47_m3maaws_SMOKE", 3],["tf47_m3maaws_ILLUM", 3]]];
    atSmawAmmo =["Box_NATO_Wps_F",15,[["tf47_smaw_HEAA", 5],["tf47_smaw_HEDP", 5],["tf47_smaw_SR", 5]]];
    atM3Ammo = ["Box_NATO_Wps_F",15,[["tf47_m3maaws_HEAT", 7],["tf47_m3maaws_HEDP", 2],["tf47_m3maaws_HE", 2],["tf47_m3maaws_SMOKE", 2],["tf47_m3maaws_ILLUM", 2]]];
    aaAmmo = ["Box_NATO_Wps_F",15,[["Titan_AA",5]]];
    radio = ["ACE_Box_Misc", 5, [["ACRE_PRC117F", 3],["B_Kitbag_mcamo", 10],["ACRE_PRC148", 15],["ACRE_PRC152", 10]]];
    misc = ["ACE_Box_Misc", 60, [["ACE_HuntIR_monitor", 3],["ACE_UAVBattery", 2],["ACE_RangeCard", 2],["ACE_Kestrel4500", 2],["ACE_Flashlight_MX991", 5],["ACE_Cellphone", 2],["ACE_DeadManSwitch", 2],["ACE_DefusalKit", 2],["ACE_M26_Clacker", 2],["ACE_Clacker", 2],["ACE_EarPlugs", 5],["ACE_DAGR", 2],["ACE_CableTie", 5],["ACE_IR_Strobe_Item", 5],["ACE_ATragMX", 2],["ACE_SpottingScope", 2],["ACE_SpareBarrel", 5],["ACE_RangeTable_82mm", 2],["ACE_microDAGR", 5],["ACE_bodyBag", 5],["ACE_MapTools", 5],["ACE_wirecutter", 2]]];
    UAV = ["ACE_Box_Misc", 5, [["B_UavTerminal", 5],["B_UAV_01_backpack_F", 5],["ACE_UAVBattery", 20]]];
    Empty = ["ACE_Box_Misc", 0, []];
    Wheel = ["ACE_Wheel", 0];
    Track = ["ACE_Track", 0];
    m2Box = ["Box_NATO_Wps_F",30,[["CUP_B_M2_Gun_Bag",1],["CUP_B_M2_Tripod_Bag",1],["CUP_B_M2_MiniTripod_Bag",1]]];
    mortarBox = ["Box_NATO_Wps_F",30,[["B_Mortar_01_weapon_F",1],["B_Mortar_01_support_F",1],["ACE_RangeTable_82mm",2]]];

    {
        _var = missionNamespace getVariable _x;
        _handle = ["Crate:" + _x, str _var, 6] spawn db_fnc_save;
        _varAllHandle pushBack _handle;
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
        "aaAmmo",
        "radio",
        "misc",
        "UAV",
        "Empty",
        "Wheel",
        "Track",
        "m2Box",
        "mortarBox"
    ];
};


_varAllHandle spawn {
    waitUntil {
        0 == ({
            !scriptDone _x;
        } count _this);
    };
    hint "Import Done";
};
