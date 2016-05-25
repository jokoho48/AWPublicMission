/*
unit loadout script by joko
Idea by Belbo
creates a specific loadout for playable units. Add the items to their respective variables. (expected data type is given).
The kind of ammo a player gets with this loadout does not necessarily have to be specified. If tracer ammo is supposed to be used, you should set JK_primaryweaponAmmo to 0 and add those
magazines one for one in JK_items.
*/

//clothing - (string)

//Check if DLC is owned by this client
// 275700 - Arma 3 Zeus
// 249860 - Arma 3 Soundtrack
// 304400 - Arma 3 DLC Bundle
// 249861 - Arma 3 Maps
// 249862 - Arma 3 Tactical Guide
// 288520 - Arma 3 Karts
// 304380 - Arma 3 Helicopters
// 332350 - Arma 3 Marksmen
if (332350 in (getDLCs 1)) then {
    JK_uniforms = ["U_B_FullGhillie_lsh"];
} else {
    JK_uniforms = ["U_B_GhillieSuit"];
};

JK_vests = ["V_BandollierB_oli"];
JK_headgears = [""];
JK_backpacks = ["B_AssaultPack_sgg"];
JK_insignium = ["111thID","TFAegis","GryffinRegiment",""];
JK_useProfileGoggles = 0;        //If set to 1, goggles from your profile will be used. If set to 0, JK_goggles will be added (or profile goggles will be removed when JK_goggles is left empty).
JK_goggles = "G_Bandanna_khk";

//weapons - primary weapon - (string)
JK_primaryweapon = ["SMA_M4afg_SM","SMA_M4MOE_SM","SMA_M4afgSTOCK","SMA_M4afg","SMA_M4MOE","SMA_M4afg_BLK1_SM","SMA_M4MOE_BLK1_SM","SMA_M4afg_BLK1","SMA_M4MOE_BLK1","SMA_M4afg_OD_SM","SMA_M4MOE_OD_SM","SMA_M4afg_OD","SMA_M4MOE_OD","SMA_M4CQBR","SMA_M4afg_Tan_SM","SMA_M4MOE_Tan_SM","SMA_M4afg_Tan","SMA_M4MOE_Tan","SMA_MK18afgBLK","SMA_MK18MOEBLK","SMA_MK18afgTANBLK_SM","SMA_MK18afgTANBLK","SMA_MK18MOEBLKTAN","SMA_MK18afgBLK_SM","SMA_MK18MOEBLK_SM","SMA_MK18MOEBLKTAN_SM","SMA_MK18afgTAN_SM","SMA_MK18MOETAN_SM","SMA_MK18afg_SM","SMA_MK18MOE_SM","SMA_MK18afgTAN","SMA_MK18MOETAN","SMA_MK18afg","SMA_MK18MOE"];

//primary weapon items - (array)
JK_itemsPrimaryweapon = [["FHQ_optic_ACOG","FHQ_optic_AimM_BLK","iansky_specterdrkf","iansky_specterdrkf_d","iansky_specterdrkf_fde","iansky_specterdrkf_t","SMA_eotech552_3XDOWN","SMA_eotech552_3XDOWN_wdl","RKSL_optic_LDS_PIP","sma_spitfire_03_black","sma_spitfire_03_sc_black","sma_spitfire_03_rds_black","sma_spitfire_03_rds_low_ard_black","sma_spitfire_03_rds_low_black"]];

//primary weapon ammo (if a primary weapon is given) and how many tracer mags - (integer)
JK_ARhandle = 0;        //should stay 0. Determines the class of ammunition for BIS_fnc_addWeapon. Specific Rifles need specific JK_ARhandles. Test it out.
JK_primaryweaponAmmo = "30Rnd_556x45_Stanag";
JK_primaryweaponAmmoCount = 6;
JK_primaryweaponTracers = "30Rnd_556x45_Stanag_Tracer_Red";
JK_primaryweaponTracersCount = 0;

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
JK_itemsHandgun = ["optic_MRD"];

//handgun ammo (if a handgun is given) - (integer)
JK_handgunAmmo = 3;

//weapons - launcher - (string)
JK_launcher = "";
JK_launcherHandle = 0;    //should stay the way it is. Determines the class of ammunition for BIS_fnc_addWeapon. Specific launchers need specific JK_launcherHandle. Test it out.
JK_launcherItems = [];

//launcher ammo (if a launcher is given) - (integer)
JK_launcherAmmo = 0;

//binocular - (string)
JK_binocular = "ACE_Vector";

//throwables - (integer)
JK_grenadeHE = 0;
JK_grenadeSmokeWhite = 2;
JK_grenadeSmokeYellow = 0;
JK_grenadeSmokeOrange = 0;
JK_grenadeSmokeRed = 0;
JK_grenadeSmokePurple = 0;
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
JK_itemsBackpack = ["7Rnd_408_Mag","7Rnd_408_Mag","7Rnd_408_Mag","ACE_Tripod","ACE_SpottingScope"];

//linked items - (array)
JK_itemsLink = [
    "ItemWatch",
    "ItemCompass",
    "ItemMap",
    "ItemGPS",
    "ACE_NVG_Wide"
];

//items added to any container - (array)
JK_items = ["ACE_ATragMX","ACE_Kestrel4500","ACE_RangeCard","ACRE_PRC343","ACRE_PRC148","ACE_Flashlight_MX991","ACE_MapTools","ACE_CableTie","ACE_microDAGR","ACE_HuntIR_monitor",["FHQ_optic_ACOG","FHQ_optic_AimM_BLK","iansky_specterdrkf","iansky_specterdrkf_d","iansky_specterdrkf_fde","iansky_specterdrkf_t","SMA_eotech552_3XDOWN","SMA_eotech552_3XDOWN_wdl","RKSL_optic_LDS_PIP","sma_spitfire_03_black","sma_spitfire_03_sc_black","sma_spitfire_03_rds_black","sma_spitfire_03_rds_low_ard_black","sma_spitfire_03_rds_low_black"]];

JK_medicClass = 1;
JK_spawnAllowed = true;
JK_isEngineer = 0;
JK_isPilot = false;

//Vehicle Spawn System
JK_VehClass = "All";

///// No editing necessary below this line /////
_this call jk_loadOut_fnc_gear;
