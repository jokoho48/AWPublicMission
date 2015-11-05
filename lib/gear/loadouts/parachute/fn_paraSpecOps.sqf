/*
unit loadout script by joko
Idea by Belbo
creates a specific loadout for playable units. Add the items to their respective variables. (expected data type is given).
The kind of ammo a player gets with this loadout does not necessarily have to be specified. If tracer ammo is supposed to be used, you should set JK_primaryweaponAmmo to 0 and add those
magazines one for one in JK_items.
*/

//Vehicle Array
JK_vvsArray = [];

//clothing - (string)
JK_uniforms = ["rhs_uniform_FROG01_m81", "rhs_uniform_FROG01_wd"];
JK_vests = ["rhsusf_spc_light"];
JK_headgears = ["H_Bandanna_khk_hs", "rhsusf_opscore_01_tan", "H_HelmetSpecB_paint1", "H_HelmetSpecB_blk", "H_Bandanna_camo", "rhsusf_ach_bare_des_headset_ess", "rhsusf_opscore_02_tan", "H_HelmetSpecB", "H_HelmetSpecB_snakeskin", "H_HelmetSpecB_sand", "rhsusf_lwh_helmet_marpatwd","rhsusf_ach_helmet_headset_ocp"];
JK_backpacks = ["B_Parachute"];
JK_insignium = ["111thID","TFAegis","GryffinRegiment"];
JK_useProfileGoggles = 1;        //If set to 1, goggles from your profile will be used. If set to 0, JK_goggles will be added (or profile goggles will be removed when JK_goggles is left empty).
JK_goggles = "G_Combat";

//weapons - primary weapon - (string)
JK_primaryweapon = ["rhs_weap_m16a4", "rhs_weap_m16a4_grip", "rhs_weap_m16a4_carryhandle", "rhs_weap_m16a4_carryhandle_grip_pmag", "rhs_weap_m16a4_carryhandle_grip", "rhs_weap_m16a4_carryhandle_pmag", "rhs_weap_m4", "rhs_weap_m4_grip2", "rhs_weap_m4_grip", "rhs_weap_m4_carryhandle", "rhs_weap_m4_carryhandle_pmag"];

//primary weapon items - (array)
JK_itemsPrimaryweapon = [["rhsusf_acc_ACOG2_USMC","rhsusf_acc_ACOG3_USMC","ACE_optic_Hamr_2D"],"rhsusf_acc_anpeq15side","rhsusf_acc_harris_bipod",["rhsusf_acc_nt4_black","rhsusf_acc_rotex5_grey"]];

//primary weapon ammo (if a primary weapon is given) and how many tracer mags - (integer)
JK_ARhandle = 0;        //should stay 0. Determines the class of ammunition for BIS_fnc_addWeapon. Specific Rifles need specific JK_ARhandles. Test it out.
JK_primaryweaponAmmo = 7;
JK_primaryweaponTracers = 1;

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
JK_handgun = "rhsusf_weap_m1911a1";

//handgun items - (array)
JK_itemsHandgun = [];

//handgun ammo (if a handgun is given) - (integer)
JK_handgunAmmo = 1;

//weapons - launcher - (string)
JK_launcher = "tf47_at4_HEDP";
JK_launcherHandle = 0;    //should stay the way it is. Determines the class of ammunition for BIS_fnc_addWeapon. Specific launchers need specific JK_launcherHandle. Test it out.
JK_launcherItems = [];

//launcher ammo (if a launcher is given) - (integer)
JK_launcherAmmo = 1;

//binocular - (string)
JK_binocular = "Binocular";

//throwables - (integer)
JK_grenadeHE = 0;
JK_grenadeSmokeWhite = 3;
JK_grenadeSmokeYellow = 0;
JK_grenadeSmokeOrange = 0;
JK_grenadeSmokeRed = 1;
JK_grenadeSmokePurple = 0;
JK_grenadeSmokeBlue = 0;
JK_grenadeSmokeGreen = 0;
JK_chemlightYellow = 0;
JK_chemlightRed = 0;
JK_chemlightGreen = 0;
JK_chemlightBlue = 0;
JK_IRgrenade = 0;

//ACE Items
JK_IVBagSaline250 = 0;
JK_IVBagSaline500 = 0;
JK_IVBagSaline1000 = 0;
JK_epinephrine = 3;
JK_morphine = 3;
JK_atropine = 0;

JK_fieldDressing = 10;
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
JK_itemsVest = ["DemoCharge_Remote_Mag","ACE_Clacker","ACE_M84","ACE_M84","ACE_M84","ACE_DefusalKit"];

//items added specifically to Backpack: - (array)
JK_itemsBackpack = [];

//linked items (don't put "ItemRadio" in here, as it's set with _equipRadio) - (array)
JK_itemsLink = [
        "ItemRadio",
        "ItemWatch",
        "ItemCompass",
        "ACE_NVG_Wide",
        "ItemMap",
        "ItemGPS"
        ];

//items added to any container - (array)
JK_items = ["ACE_Flashlight_MX991","ACE_MapTools","ACE_CableTie","ACE_microDAGR","rhsusf_acc_compm4"];

JK_medicClass = 0;
JK_spawnAllowed = false;
JK_isEngineer = 0;
JK_isPilot = false;

///// No editing necessary below this line /////
_this call jk_loadOut_fnc_gear;
