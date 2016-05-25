/*
unit loadout script by joko
Idea by Belbo
creates a specific loadout for playable units. Add the items to their respective variables. (expected data type is given).
The kind of ammo a player gets with this loadout does not necessarily have to be specified. If tracer ammo is supposed to be used, you should set JK_primaryweaponAmmo to 0 and add those
magazines one for one in JK_items.
*/

//clothing - (string)
JK_uniforms = ["Scorpion_Camo","Scorpion_Camo_Cyre_GP","Scorpion_Camo_Cyre_GS","Scorpion_GP_Camo_SS","Scorpion_GS_Camo","Scorpion_GS_Camo_SS","Scorpion_Camo_SS","Scorpion_Camo_TShirt","Scorpion_TP_Camo","Scorpion_TS_Camo_SS","Scorpion_TP_Camo_SS","Scorpion_TS_Camo","Scorpion_GP_Camo","Scorpion_Camo_Cyre","Scorpion_Camo_Cyre_TP","MC_Camo","MC_Camo_Cyre_GP","MC_Camo_Cyre_GS","MC_Camo_Cyre_Tee","MC_Camo_Cyre_TP","MC_Camo_Cyre_TS","MC_Camo_Cyre","MC_GP_Camo","MC_GP_Camo_SS","MC_Camo_SS","MC_Camo_TShirt","MC_TP_Camo","MC_GS_Camo_SS"];
JK_vests = ["Scorpion_LBT_vest","Scorpion_Vest_6","Scorpion_Vest_7","Scorpion_Vest_5","Scorpion_Vest_4","Scorpion_MBSS","Scorpion_MBSS_PACA","Scorpion_Vest_1","Scorpion_Vest_2","Scorpion_Vest_3","MC_Vest_5","MC_Vest_4","MC_MBSS","MC_MBSS_PACA","MC_Vest_1","MC_Vest_2","MC_Vest_3","Specter_LBT_vest_CB","Specter_LBT_vest_TAN","Specter_LBT_vest_WL_CB","Specter_LBT_vest_WL_GRN","Specter_LBT_vest_WL_TAN","Specter_MBSS_CB","Specter_MBSS","Specter_MBSS_PACA_CB","Specter_MBSS_PACA","Specter_MBSS_PACA_l_CB","Specter_MBSS_light_CB","Specter_MBSS_light","Specter_RAV"];
JK_headgears = ["H_HelmetB_snakeskin","H_HelmetB_sand","H_HelmetB_grass","H_HelmetB_desert","H_HelmetB_camo","H_HelmetB_black","H_HelmetB","Scorpion_Helmet2","Scorpion_Helmet1","OGA_Helmet2","OGA_Helmet1","OGA_G_Helmet2","OGA_G_Helmet1","MC_Helmet2","MC_Helmet1","H_HelmetB_light","H_HelmetB_light_black","H_HelmetB_light_desert","H_HelmetB_light_grass","H_HelmetB_light_sand","H_HelmetB_light_snakeskin"];
JK_backpacks = ["MC_Backpack_Kitbag","Scorpion_Backpack_Kitbag"];
JK_insignium = ["111thID","TFAegis","GryffinRegiment",""];
JK_useProfileGoggles = 1;        //If set to 1, goggles from your profile will be used. If set to 0, JK_goggles will be added (or profile goggles will be removed when JK_goggles is left empty).
JK_goggles = "";

//weapons - primary weapon - (string)
JK_primaryweapon = ["CUP_lmg_m249_SQuantoon","CUP_lmg_m249_pip1","CUP_lmg_m249_pip3","CUP_lmg_m249_pip4","CUP_lmg_M249_E2","CUP_lmg_m249_pip2","CUP_lmg_m249_para"];

//primary weapon items - (array)
JK_itemsPrimaryweapon = [["CUP_optic_ElcanM145","CUP_optic_Elcan_reflex","iansky_specterdr","iansky_specterdr_d","iansky_specterdr_fde","iansky_specterdr_t","iansky_specterdrkf","iansky_specterdrkf_d","iansky_specterdrkf_fde","iansky_specterdrkf_t","RKSL_optic_LDS_PIP"]];

//primary weapon ammo (if a primary weapon is given) and how many tracer mags - (integer)
JK_ARhandle = 0;        //should stay 0. Determines the class of ammunition for BIS_fnc_addWeapon. Specific Rifles need specific JK_ARhandles. Test it out.
JK_primaryweaponAmmo = 6;
JK_primaryweaponTracers = 0;

//40mm Grenades - (integer)
JK_40mmHeGrenadesAmmo = 0;
JK_40mmSmokeGrenadesWhite = 0;
JK_40mmSmokeGrenadesYellow = 0;
JK_40mmSmokeGrenadesOrange = 0;
JK_40mmSmokeGrenadesRed = 0;
JK_40mmSmokeGrenadesPurple = 0;
JK_40mmSmokeGrenadesBlue = 0;
JK_40mmSmokeGrenadesGreen = 0;
JK_40mmFlareWhite = 0;
JK_40mmFlareYellow = 0;
JK_40mmFlareRed = 0;
JK_40mmFlareGreen = 0;
JK_40mmFlareIR = 0;

//weapons - handgun - (string)
JK_handgun = "hgun_Pistol_heavy_01_F";

//handgun items - (array)
JK_itemsHandgun = [""];

//handgun ammo (if a handgun is given) - (integer)
JK_handgunAmmo = 2;

//weapons - launcher - (string)
JK_launcher = "";
JK_launcherHandle = 0;    //should stay the way it is. Determines the class of ammunition for BIS_fnc_addWeapon. Specific launchers need specific JK_launcherHandle. Test it out.
JK_launcherItems = [];

//launcher ammo (if a launcher is given) - (integer)
JK_launcherAmmo = 0;

//binocular - (string)
JK_binocular = "Binocular";

//throwables - (integer)
JK_grenadeHE = 2;
JK_grenadeSmokeWhite = 2;
JK_grenadeSmokeYellow = 0;
JK_grenadeSmokeOrange = 0;
JK_grenadeSmokeRed = 0;
JK_grenadeSmokePurple = 2;
JK_grenadeSmokeBlue = 0;
JK_grenadeSmokeGreen = 1;
JK_chemlightYellow = 0;
JK_chemlightRed = 0;
JK_chemlightGreen = 0;
JK_chemlightBlue = 0;
JK_IRgrenade = 0;

//ACE Items
JK_IVBagSaline250 = 1;
JK_IVBagSaline500 = 0;
JK_IVBagSaline1000 = 0;
JK_epinephrine = 3;
JK_morphine = 3;
JK_atropine = 0;

JK_fieldDressing = 15;
JK_packingBandage = 0;
JK_elasticBandage = 0;
JK_quikclot = 0;
JK_tourniquet = 0;

JK_earPlugs = 1;
JK_swapBarrel = 0;

//first aid kits and medi kits- (integer)
JK_FirstAidKits = 0;
JK_MediKit = 0;        //if set to 1, a MediKit and all FirstAidKits will be added to the backpack; if set to 0, FirstAidKits will be added to inventory in no specific order.

//items added specifically to uniform: - (array)
JK_itemsUniform = [];

//items added specifically to vest: - (array)
JK_itemsVest = [];

//items added specifically to Backpack: - (array)
JK_itemsBackpack = [];

//linked items - (array)
JK_itemsLink = [
    "ItemWatch",
    "ItemCompass",
    "ItemMap",
    "ItemGPS",
    "ACE_NVG_Wide"
];

//items added to any container - (array)
JK_items = ["ACRE_PRC343","ACE_Flashlight_MX991","ACE_MapTools","ACE_CableTie","ACE_microDAGR",["FHQ_optic_ACOG","FHQ_optic_AimM_BLK","iansky_specterdrkf","iansky_specterdrkf_d","iansky_specterdrkf_fde","iansky_specterdrkf_t","SMA_eotech552_3XDOWN","SMA_eotech552_3XDOWN_wdl","RKSL_optic_LDS_PIP","sma_spitfire_03_black","sma_spitfire_03_sc_black","sma_spitfire_03_rds_black","sma_spitfire_03_rds_low_ard_black","sma_spitfire_03_rds_low_black"]];

JK_medicClass = 0;
JK_spawnAllowed = true;
JK_isEngineer = 0;
JK_isPilot = true;

//Vehicle Spawn System
JK_VehClass = "All";

///// No editing necessary below this line /////
_this call jk_loadOut_fnc_gear;
