/*
Author: SENSEI

Last modified: 8/13/2015

Description: preInit settings

         returns nothing
__________________________________________________________________*/
if (isNil "db_fnc_log" && {!(db_fnc_log isEqualTo {})}) then {
    db_fnc_log = {};
};

SEN_debug = (paramsArray select 1) isEqualTo 1;
publicVariable "SEN_debug";

if (!isServer) exitWith {};

if (isNil "db_fnc_save") then {
    db_fnc_save = {
        profileNamespace setVariable [_this select 0, call compile (_this select 1)];
        saveProfileNamespace;
    };
};

jk_db_fnc_load = if (isNil "db_fnc_load") then {
    { _this resize 2; profileNameSpace getVariable _this }
} else {
    { [(_this select 0), _this select 2] call db_fnc_load; }
};

JK_TicketSystem = ["JK_TicketSystem", 4000, 0] call jk_db_fnc_load;
publicVariable "JK_TicketSystem";

JK_VSS_ListTickets = ["JK_VSS_ListTickets", [["test", ["B_MRAP_01_F"],200,["All"]]], 2] call jk_db_fnc_load;
publicVariable "JK_VSS_ListTickets";

SEN_approvalCiv = ["SEN_approvalCiv", -1500, 0] call jk_db_fnc_load;
publicVariable "SEN_approvalCiv";

SEN_blacklistLocation = ["SEN_ClearedCitys", [], 0] call jk_db_fnc_load;
publicVariable "SEN_blacklistLocation";

SEN_ClearedCitys = SEN_blacklistLocation;
publicVariable "SEN_ClearedCitys";

[0,"Starting fn_settingsPre."] call SEN_fnc_log;
if ((paramsArray select 3) isEqualTo -1) then {
    setDate [2015, random ceil 11, random ceil 27, random round 23, 00];
} else {
    setDate [2015, random ceil 11, random ceil 27, (paramsArray select 3), 00];
};
if ((paramsArray select 4) isEqualTo 0) then {SEN_enemySide = EAST} else {SEN_enemySide = RESISTANCE}; publicVariable "SEN_enemySide";
createCenter SEN_enemySide;
WEST setFriend [SEN_enemySide, 0];
CIVILIAN setFriend [WEST,1];
CIVILIAN setFriend [SEN_enemySide,1];

// check server/hc for supported addon content
if ((paramsArray select 11) isEqualTo 1) then {
    SEN_rhsAFRFEnabled = (isClass (configfile >> "CfgPatches" >> "rhs_main"));
    SEN_rhsUSAFEnabled = (isClass (configfile >> "CfgPatches" >> "rhsusf_main"));
    SEN_lopEnabled = (isClass (configfile >> "CfgPatches" >> "lop_main"));
} else {
    SEN_rhsAFRFEnabled = false;
    SEN_rhsUSAFEnabled = false;
    SEN_lopEnabled = false;
};

SEN_unitPoolWest = [];
SEN_vehPoolWest = [];
SEN_airPoolWest = [];
SEN_sniperPoolWest = [];
SEN_unitPoolCiv = [];
SEN_vehPoolCiv = [];
SEN_airPoolCiv = [];
SEN_unitPool = [];
SEN_vehPool = [];
SEN_airPool = [];
SEN_sniperPool = [];
SEN_officerPool = [];
SEN_unitPoolRebel = [];
SEN_vehPoolRebel = [];
SEN_airPoolRebel = [];
SEN_airAttackPool = [];
SEN_AriPool = [];
////////////////// EDIT BELOW //////////////////

// fill arrays with addon content if enabled
if (SEN_rhsUSAFEnabled) then { // RHS: USAF
    SEN_unitPoolWest = ["rhsusf_army_ucp_rifleman_101st","rhsusf_army_ucp_aa","rhsusf_army_ucp_javelin","rhsusf_army_ucp_autorifleman","rhsusf_army_ucp_medic","rhsusf_army_ucp_explosives","rhsusf_army_ucp_grenadier","rhsusf_army_ucp_marksman","rhsusf_army_ucp_teamleader"];
    SEN_vehPoolWest = ["rhsusf_rg33_wd","rhsusf_rg33_m2_wd","rhsusf_m1025_w","rhsusf_m1025_w_m2"];
    SEN_airPoolWest = ["RHS_CH_47F","RHS_UH1Y_UNARMED","RHS_UH60M","B_Heli_Light_01_F"];
    publicVariable "SEN_airPoolWest"; //public for fn_transportHandler
    SEN_sniperPoolWest = ["rhsusf_army_ucp_sniper"];
};
if (SEN_rhsAFRFEnabled) then { // RHS: AFRF
    SEN_unitPoolRebel = ["rhs_g_Soldier_GL_F","rhs_g_Soldier_AAT_F","rhs_g_engineer_F","rhs_g_Soldier_AA_F","rhs_g_Soldier_AR_F","rhs_g_Soldier_AAR_F","rhs_g_Soldier_F3","rhs_g_medic_F","rhs_g_Soldier_F2","rhs_g_Soldier_F","rhs_g_Soldier_lite_F","rhs_g_Soldier_LAT_F","rhs_g_Soldier_AT_F","rhs_g_Soldier_M_F","rhs_g_Soldier_exp_F","rhs_g_Soldier_TL_F", "rhs_g_Soldier_SL_F"];
    SEN_vehPoolRebel = ["rhs_uaz_spg9_chdkz","rhs_uaz_dshkm_chdkz","rhs_uaz_ags_chdkz"];
    SEN_airPoolRebel = [];
    SEN_airAttackPool = ["O_Heli_Light_02_v2_F","RHS_Ka52_vvsc","RHS_Mi24V_vvs","RHS_Mi24P_vvs","RHS_Mi8AMTSh_vvs","RHS_Mi8MTV3_vvs","RHS_Su25SM_vvs","RHS_T50_vvs_051","O_Plane_CAS_02_F"];
    SEN_AriPool = ["rhs_2s3_tv", "RHS_BM21_MSV_01"];
    if (SEN_enemySide isEqualTo EAST) exitWith {
        SEN_unitPool = ["rhs_msv_at", "rhs_msv_grenadier", "rhs_msv_LAT", "rhs_msv_RShG2", "rhs_msv_sergeant", "rhs_msv_junior_sergeant", "rhs_msv_efreitor", "rhs_msv_grenadier_rpg", "rhs_msv_engineer", "rhs_msv_strelok_rpg_assist", "rhs_msv_aa", "rhs_msv_machinegunner", "rhs_msv_machinegunner_assistant", "rhs_msv_medic", "rhs_msv_rifleman"];
        SEN_vehPool = ["rhs_uaz_spg9_chdkz","rhs_uaz_dshkm_chdkz","rhs_uaz_ags_chdkz","rhs_tigr_sts_3camo_vv", "rhs_sprut_vdv", "rhs_bmd1", "rhs_bmd1p", "rhs_bmd1pk", "rhs_bmd1r", "rhs_bmd2", "rhs_bmd2m", "rhs_bmp1_vdv", "rhs_bmp1d_vdv", "rhs_bmp1k_vdv", "rhs_bmp1p_vdv","rhs_bmp2_vdv","rhs_bmp2e_vdv","rhs_bmp2d_vdv","rhs_bmp2k_vdv","rhs_bmp3_msv","rhs_bmp3_late_msv","rhs_bmp3m_msv","rhs_bmp3mera_msv","rhs_brm1k_vdv","rhs_prp3_vdv","rhs_t72ba_tv","rhs_t72bb_tv","rhs_t72bc_tv","rhs_t72bd_tv","rhs_t80","rhs_t80a","rhs_t80b","rhs_t80bv","rhs_t80u","rhs_t80u45m","rhs_t80ue1","rhs_t80uk","rhs_t80um","rhs_t90_tv","rhs_t90a_tv","rhs_zsu234_aa"];
        SEN_airPool = ["RHS_Mi8AMTSh_FAB_vvs", "RHS_Ka52_vvs", "RHS_Mi24P_CAS_vvs"];
        SEN_sniperPool = ["rhs_msv_marksman"];
        SEN_officerPool = ["rhs_msv_officer_armored"];
    };
};
if (toUpper worldName isEqualTo "TAKISTAN" && SEN_lopEnabled) then {
    SEN_unitPoolCiv = ["LOP_Tak_Civ_Man_01","LOP_Tak_Civ_Man_02","LOP_Tak_Civ_Man_04"];
    SEN_vehPoolCiv = ["LOP_TAK_Civ_Hatchback","LOP_TAK_Civ_Landrover","LOP_TAK_Civ_Offroad","LOP_TAK_Civ_UAZ","LOP_TAK_Civ_UAZ_Open","LOP_TAK_Civ_Ural","LOP_TAK_Civ_Ural_open"];
};
// fill arrays with vanilla content if still empty
if (count SEN_unitPoolWest isEqualTo 0) then {SEN_unitPoolWest = ["B_Soldier_SL_F","B_medic_F","B_soldier_AR_F","B_soldier_M_F","B_Soldier_AA_F","B_soldier_AT_F","B_soldier_F"]};
if (count SEN_vehPoolWest isEqualTo 0) then {SEN_vehPoolWest = ["B_mrap_01_F","B_MRAP_01_gmg_F","B_MRAP_01_hmg_F"]};
if (count SEN_airPoolWest isEqualTo 0) then {SEN_airPoolWest = ["B_Heli_Transport_03_F","B_Heli_Transport_01_F","B_Heli_Light_01_F"]; publicVariable "SEN_airPoolWest";};
if (count SEN_sniperPoolWest isEqualTo 0) then {SEN_sniperPoolWest = ["B_sniper_F"]};
if (count SEN_unitPoolCiv isEqualTo 0) then {SEN_unitPoolCiv = ["C_man_1","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_hunter_1_F","C_man_p_beggar_F","C_man_p_beggar_F_afro","C_man_p_fugitive_F","C_man_p_shorts_1_F","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F","C_man_shorts_1_F","C_man_shorts_2_F","C_man_shorts_3_F","C_man_shorts_4_F","C_man_w_worker_F"]};
if (count SEN_vehPoolCiv isEqualTo 0) then {SEN_vehPoolCiv = ["C_Offroad_01_F","C_SUV_01_F","C_Van_01_box_F","C_Van_01_fuel_F","C_Van_01_transport_F"]};
if (count SEN_airPoolCiv isEqualTo 0) then {SEN_airPoolCiv = ["C_Heli_Light_01_civil_F"]};
if (count SEN_unitPoolRebel isEqualTo 0) then { SEN_unitPoolRebel = SEN_unitPoolCiv;};
if (count SEN_vehPoolRebel isEqualTo 0) then {SEN_vehPoolRebel = SEN_vehPoolCiv;};
if (count SEN_airPoolRebel isEqualTo 0) then {SEN_airPoolRebel = SEN_airPoolCiv;};
if (count SEN_airAttackPool isEqualTo 0) then {SEN_airAttackPool = ["O_Plane_CAS_02_F", "O_Heli_Attack_02_F", "O_Heli_Attack_02_black_F", "O_Heli_Light_02_F"]};
if (count SEN_AriPool isEqualTo 0) then {SEN_AriPool = ["O_MBT_02_arty_F"];};
if (SEN_enemySide isEqualTo RESISTANCE) exitWith {
    if (count SEN_unitPool isEqualTo 0) then {SEN_unitPool = ["I_soldier_AR_F","I_medic_F","I_soldier_exp_F","I_soldier_GL_F","I_soldier_AT_F","I_soldier_repair_F","I_soldier_AAR_F","I_soldier_M_F","I_soldier_F","I_support_AMort_F","I_support_AMG_F","I_support_MG_F","I_support_Mort_F","I_engineer_F","I_Soldier_AAT_F","I_Soldier_A_F","I_Soldier_AA_F"]};
    if (count SEN_vehPool isEqualTo 0) then {SEN_vehPool = ["I_MRAP_03_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F","I_Quadbike_01_F","I_APC_tracked_03_cannon_F","I_APC_Wheeled_03_cannon_F","O_APC_Tracked_02_AA_F"]};
    if (count SEN_airPool isEqualTo 0) then {SEN_airPool = ["I_Heli_light_03_F"]};
    if (count SEN_officerPool isEqualTo 0) then {SEN_officerPool = ["I_officer_F"]};
    if (count SEN_sniperPool isEqualTo 0) then {SEN_sniperPool = ["I_sniper_F"]};
    [0,"fn_settingsPre complete."] call SEN_fnc_log;
};
if (SEN_enemySide isEqualTo EAST) exitWith {
    if (count SEN_unitPool isEqualTo 0) then {SEN_unitPool = ["O_soldier_AR_F","O_medic_F","O_soldier_exp_F","O_soldier_GL_F","O_soldier_AT_F","O_soldier_repair_F","O_soldier_AAR_F","O_soldier_M_F","O_soldier_F","O_support_AMort_F","O_support_AMG_F","O_support_MG_F","O_support_Mort_F","O_engineer_F","O_recon_M_F","O_Soldier_AA_F"]};
    if (count SEN_vehPool isEqualTo 0) then {SEN_vehPool = ["O_MRAP_02_F","O_MRAP_02_hmg_F","O_MRAP_02_gmg_F","O_Quadbike_01_F","O_APC_Tracked_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_APC_Tracked_02_AA_F","O_MBT_02_cannon_F"]};
    if (count SEN_airPool isEqualTo 0) then {SEN_airPool = ["O_Heli_Light_02_F","O_Heli_Attack_02_F","O_Heli_Light_02_v2_F"]};
    if (count SEN_officerPool isEqualTo 0) then {SEN_officerPool = ["O_officer_F"]};
    if (count SEN_sniperPool isEqualTo 0) then {SEN_sniperPool = ["O_sniper_F"]};
    [0,"fn_settingsPre complete."] call SEN_fnc_log;
};
