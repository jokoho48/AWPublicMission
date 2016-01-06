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
[{
    if (!isNil "JK_postInit") then {
        //call SEN_fnc_EOD;
        call SEN_fnc_settingsPost;
        [_this select 1] call CBA_fnc_removePerFrameHandler;
    };
},0,0] call CBA_fnc_addPerFrameHandler;
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
    private _cfg = configFile >> "CfgPatches";
    private _count = ({
        isClass (_cfg >> _x)
    } count [
        "Project_Honor_Config","min_rf_units",
        "CUP_Weapons_WeaponsCore","CUP_BaseData",
        "CUP_BaseConfigs","CUP_Creatures_People_Core",
        "CUP_WheeledVehicles_Core","CUP_WaterVehicles_Core",
        "CUP_TrackedVehicles_Core","CUP_AirVehicles_Core"
    ]);
    SEN_CUPEnabled = _count != 0;

} else {
    SEN_CUPEnabled = false;
};

SEN_unitPoolWest = [];
SEN_vehPoolWest = [];
SEN_airPoolWest = [];
SEN_sniperPoolWest = [];
SEN_unitPoolCiv = [];
SEN_vehPoolCiv = [];
SEN_airPoolCiv = [];
SEN_unitPool = [];
SEN_unitDriverPool = [];
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
if (SEN_CUPEnabled) then { // CUP
    SEN_unitPoolWest = ["CUP_B_USMC_Soldier_AA","CUP_B_USMC_Soldier_HAT","CUP_B_USMC_Soldier_AT","CUP_B_USMC_Soldier_AR","CUP_B_USMC_Medic","CUP_B_USMC_Crew","CUP_B_USMC_Soldier_Marksman","CUP_B_USMC_Engineer","CUP_B_USMC_Soldier_TL","CUP_B_USMC_Soldier_GL","CUP_B_USMC_Soldier_MG","CUP_B_USMC_Officer","CUP_B_USMC_Pilot","CUP_B_USMC_Soldier","CUP_B_USMC_SpecOps_SD","CUP_B_USMC_Soldier_LAT","CUP_B_USMC_Soldier_SL"];
    SEN_vehPoolWest = ["CUP_B_HMMWV_M2_GPK_USA","CUP_B_HMMWV_Unarmed_USA","CUP_B_HMMWV_MK19_USA"];

    SEN_unitPool = ["min_rf_soldier_A","min_rf_soldier_AR","AW_min_rf_soldier_AA","AW_min_rf_soldier_AT","AW_min_rf_soldier_LAT","min_rf_medic","min_rf_engineer","min_rf_soldier_exp","min_rf_soldier_GL","min_rf_soldier_repair","min_rf_soldier","min_rf_soldier_SL","min_rf_soldier_TL","min_rf_soldier_lite"];
    SEN_unitDriverPool = ["min_rf_driver","min_rf_crew"];
    SEN_vehPool = ["CUP_B_BRDM2_CDF","CUP_B_BRDM2_ATGM_CDF","CUP_O_BTR60_TK","CUP_O_BTR90_RU","CUP_O_UAZ_AGS30_RU","CUP_O_UAZ_MG_RU","CUP_O_UAZ_METIS_RU","CUP_O_UAZ_SPG9_RU","CUP_O_Ural_ZU23_RU","CUP_O_Ural_ZU23_RU","CUP_O_Ural_ZU23_RU","CUP_O_Ural_ZU23_RU","CUP_O_Ural_ZU23_RU","CUP_O_Ural_ZU23_RU"];
    SEN_airPool = ["CUP_B_Mi24_D_CDF","CUP_O_Mi24_P_RU","CUP_O_Mi24_V_RU","CUP_O_Mi8_RU"];
    SEN_sniperPool = ["min_rf_soldier_M"];
    SEN_officerPool = ["min_rf_officer"];
    SEN_unitPoolRebel = ["AW_ins_AT","AW_ins_AR","AW_ins_MK","AW_ins_MG","AW_ins_GL","AW_ins_RF"];
    //SEN_airPoolRebel = [];
    SEN_airAttackPool = ["CUP_B_Mi24_D_CDF","CUP_O_Mi24_P_RU","CUP_O_Mi24_V_RU","CUP_O_Mi8_RU","CUP_O_Su25_RU_1","CUP_O_Su25_RU_2","CUP_O_Su25_RU_3"];
    SEN_AriPool = ["min_rf_MBT_arty", "CUP_O_BM21_RU", "CUP_D30_base"];
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
if (count SEN_unitDriverPool isEqualTo 0) then {SEN_unitDriverPool = SEN_unitPool;};
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
