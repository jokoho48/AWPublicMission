/*
unit loadout script by joko
Idea by Belbo
creates a specific loadout for playable units. Add the items to their respective variables. (expected data type is given).
The kind of ammo a player gets with this loadout does not necessarily have to be specified. If tracer ammo is supposed to be used, you should set JK_primaryweaponAmmo to 0 and add those
magazines one for one in JK_items.
*/

//clothing - (string)
JK_uniforms = ["BWA3_Uniform_Fleck","BWA3_Uniform2_Fleck","BWA3_Uniform_idz_Fleck","BWA3_Uniform3_idz_Fleck","BWA3_Uniform2_idz_Fleck"];
JK_vests = ["BWA3_Vest_Fleck","BWA3_Vest_Grenadier_Fleck","BWA3_Vest_Leader_Fleck","BWA3_Vest_Marksman_Fleck","BWA3_Vest_Autorifleman_Fleck","BWA3_Vest_Medic_Fleck","BWA3_Vest_Rifleman1_Fleck"];
JK_headgears = ["BWA3_M92_Fleck","BWA3_CrewmanKSK_Fleck","BWA3_MICH_Fleck",];
JK_backpacks = ["BWA3_AssaultPack_Fleck","BWA3_FieldPack_Fleck","BWA3_TacticalPack_Fleck"];
JK_insignium = ["111thID","TFAegis","GryffinRegiment",""];
JK_useProfileGoggles = 1;        //If set to 1, goggles from your profile will be used. If set to 0, JK_goggles will be added (or profile goggles will be removed when JK_goggles is left empty).
JK_goggles = "";

//weapons - primary weapon - (string)
JK_primaryweapon = ["hlc_rifle_G36A1AG36","hlc_rifle_G36E1AG36","hlc_rifle_G36VAG36"];

//primary weapon items - (array)
JK_itemsPrimaryweapon = [["FHQ_optic_ACOG","FHQ_optic_AimM_BLK","iansky_specterdrkf","iansky_specterdrkf_d","iansky_specterdrkf_fde","iansky_specterdrkf_t","SMA_eotech552_3XDOWN","SMA_eotech552_3XDOWN_wdl","RKSL_optic_LDS_PIP","sma_spitfire_03_black","sma_spitfire_03_sc_black","sma_spitfire_03_rds_black","sma_spitfire_03_rds_low_ard_black","sma_spitfire_03_rds_low_black"]];

//primary weapon ammo (if a primary weapon is given) and how many tracer mags - (integer)
JK_ARhandle = 0;        //should stay 0. Determines the class of ammunition for BIS_fnc_addWeapon. Specific Rifles need specific JK_ARhandles. Test it out.
JK_primaryweaponAmmo = "hlc_30rnd_556x45_EPR_G36";
JK_primaryweaponAmmoCount = 7;
JK_primaryweaponTracers = "hlc_30rnd_556x45_EPR_G36";
JK_primaryweaponTracersCount = 0;

//40mm Grenades - (integer)
JK_40mmHeGrenadesAmmo = 0;
JK_40mmSmokeGrenadesWhite = 0;
JK_40mmSmokeGrenadesYellow = 0;
JK_40mmSmokeGrenadesOrange = 0;
JK_40mmSmokeGrenadesRed = 2;
JK_40mmSmokeGrenadesPurple = 1;
JK_40mmSmokeGrenadesBlue = 0;
JK_40mmSmokeGrenadesGreen = 2;
JK_40mmFlareWhite = 0;
JK_40mmFlareYellow = 0;
JK_40mmFlareRed = 0;
JK_40mmFlareGreen = 0;
JK_40mmFlareIR = 0;

//weapons - handgun - (string)
JK_handgun = "BWA3_P8";

//handgun items - (array)
JK_itemsHandgun = [""];

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
JK_itemsBackpack = ["ACRE_PRC117F"];

//linked items - (array)
JK_itemsLink = [
    "ItemWatch",
    "ItemCompass",
    "ItemMap",
    "ItemGPS",
    "ACE_NVG_Wide"
];

//items added to any container - (array)
JK_items = ["ACE_SpraypaintBlack","ACE_SpraypaintRed","ACE_SpraypaintGreen","ACE_SpraypaintBlue","ACRE_PRC343","ACRE_PRC148","ACE_Flashlight_MX991","ACE_MapTools","ACE_CableTie","ACE_microDAGR","ACE_HuntIR_monitor", ["FHQ_optic_ACOG","FHQ_optic_AimM_BLK","iansky_specterdrkf","iansky_specterdrkf_d","iansky_specterdrkf_fde","iansky_specterdrkf_t","SMA_eotech552_3XDOWN","SMA_eotech552_3XDOWN_wdl","RKSL_optic_LDS_PIP","sma_spitfire_03_black","sma_spitfire_03_sc_black","sma_spitfire_03_rds_black","sma_spitfire_03_rds_low_ard_black","sma_spitfire_03_rds_low_black"]];

JK_medicClass = 1;
JK_spawnAllowed = true;
JK_isEngineer = 0;
JK_isPilot = true;

//Vehicle Spawn System
JK_VehClass = "Leader";

///// No editing necessary below this line /////
_this call jk_loadOut_fnc_gear;
