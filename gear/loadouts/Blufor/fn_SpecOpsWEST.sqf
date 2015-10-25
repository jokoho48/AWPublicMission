/*
unit loadout script by joko
Idea by Belbo
creates a specific loadout for playable units. Add the items to their respective variables. (expected data type is given).
The kind of ammo a player gets with this loadout does not necessarily have to be specified. If tracer ammo is supposed to be used, you should set _primaryweaponAmmo to 0 and add those
magazines one for one in _items.
*/

//Vehicle Array
JK_vvsArray = [];

//clothing - (string)
_uniforms = ["rhs_uniform_FROG01_m81", "rhs_uniform_FROG01_wd"];
_vests = ["rhsusf_spc_light"];
_headgears = ["H_Bandanna_khk_hs", "rhsusf_opscore_01", "rhsusf_opscore_01_tan", "H_HelmetSpecB_paint1", "H_HelmetSpecB_blk", "H_Bandanna_camo", "rhsusf_opscore_02", "rhsusf_opscore_02_tan", "H_HelmetSpecB", "H_HelmetSpecB_snakeskin", "H_HelmetSpecB_sand", "rhsusf_lwh_helmet_marpatwd","rhsusf_ach_helmet_headset_ocp"];
_backpacks = ["rhsusf_falconii"];
_insignium = "";
_useProfileGoggles = 1;        //If set to 1, goggles from your profile will be used. If set to 0, _goggles will be added (or profile goggles will be removed when _goggles is left empty).
_goggles = "G_Combat";

//weapons - primary weapon - (string)
_primaryweapon = ["rhs_weap_m16a4", "rhs_weap_m16a4_grip", "rhs_weap_m16a4_carryhandle", "rhs_weap_m16a4_carryhandle_grip_pmag", "rhs_weap_m16a4_carryhandle_grip", "rhs_weap_m16a4_carryhandle_pmag", "rhs_weap_m4", "rhs_weap_m4_grip2", "rhs_weap_m4_grip", "rhs_weap_m4_carryhandle", "rhs_weap_m4_carryhandle_pmag"];

//primary weapon items - (array)
_itemsPrimaryweapon = [["rhsusf_acc_ACOG2_USMC","rhsusf_acc_ACOG3_USMC","ACE_optic_Hamr_2D"],"rhsusf_acc_anpeq15A","rhsusf_acc_harris_bipod",["rhsusf_acc_nt4_black","rhsusf_acc_rotex5_grey"]];

//primary weapon ammo (if a primary weapon is given) and how many tracer mags - (integer)
_ARhandle = 0;        //should stay 0. Determines the class of ammunition for BIS_fnc_addWeapon. Specific Rifles need specific _ARhandles. Test it out.
_primaryweaponAmmo = 9;
_primaryweaponTracers = 3;

//40mm Grenades - (integer)
_40mmHeGrenadesAmmo = 0;
_40mmSmokeGrenadesWhite = 0;
_40mmSmokeGrenadesYellow = 0;
_40mmSmokeGrenadesOrange = 0;
_40mmSmokeGrenadesRed = 0;
_40mmSmokeGrenadesPurple = 0;
_40mmSmokeGrenadesBlue = 0;
_40mmSmokeGrenadesGreen = 0;
_40mmFlareWhite = 0;
_40mmFlareYellow = 0;
_40mmFlareRed = 0;
_40mmFlareGreen = 0;
_40mmFlareIR = 0;

//weapons - handgun - (string)
_handgun = "rhsusf_weap_m1911a1";

//handgun items - (array)
_itemsHandgun = [];

//handgun ammo (if a handgun is given) - (integer)
_handgunAmmo = 2;

//weapons - launcher - (string)
_launcher = "tf47_at4_HEDP";
_launcherHandle = 0;    //should stay the way it is. Determines the class of ammunition for BIS_fnc_addWeapon. Specific launchers need specific _launcherHandle. Test it out.

//launcher ammo (if a launcher is given) - (integer)
_launcherAmmo = 1;

//binocular - (string)
_binocular = "Binocular";

//throwables - (integer)
_grenadeHE = 2;
_grenadeSmokeWhite = 4;
_grenadeSmokeYellow = 0;
_grenadeSmokeOrange = 0;
_grenadeSmokeRed = 1;
_grenadeSmokePurple = 0;
_grenadeSmokeBlue = 1;
_grenadeSmokeGreen = 1;
_chemlightYellow = 0;
_chemlightRed = 0;
_chemlightGreen = 0;
_chemlightBlue = 1;
_IRgrenade = 0;

//ACE Items
_IVBagSaline250 = 1;
_IVBagSaline500 = 0;
_IVBagSaline1000 = 0;
_epinephrine = 3;
_morphine = 3;
_atropine = 0;

_fieldDressing = 10;
_packingBandage = 0;
_elasticBandage = 0;
_quikclot = 0;
_tourniquet = 0;

_earPlugs = 1;
_swapBarrel = 0;

//first aid kits and medi kits- (integer)
_FirstAidKits = 0;
_MediKit = 0;        //if set to 1, a MediKit and all FirstAidKits will be added to the backpack; if set to 0, FirstAidKits will be added to inventory in no specific order.

//items added specifically to uniform: - (array)
_itemsUniform = [];

//items added specifically to vest: - (array)
_itemsVest = [];

//items added specifically to Backpack: - (array)
_itemsBackpack = ["DemoCharge_Remote_Mag","DemoCharge_Remote_Mag","ACE_Clacker","ACE_M84","ACE_M84","ACE_M84","ACE_M84","ACE_DefusalKit"];

//linked items (don't put "ItemRadio" in here, as it's set with _equipRadio) - (array)
_itemsLink = [
        "ItemRadio",
        "ItemWatch",
        "ItemCompass",
        "ACE_NVG_Wide",
        "ItemMap",
        "ItemGPS"
        ];

//items added to any container - (array)
_items = ["ACE_Flashlight_MX991","ACE_MapTools","ACE_CableTie","ACE_microDAGR","rhsusf_acc_compm4"];

///// No editing necessary below this line /////
params ["_player"];
_player setCaptive true;    //unfortunately necessary due to the time consumed by changing the weapon
[_player] call jk_loadOut_fnc_gear;
_player setVariable ["ace_medical_medicClass", 0];
_player setVariable ["JK_CrateSpawnAllowed", false];
_player setVariable ["ACE_IsEngineer", 0];
_player setVariable ["JK_isPilot", false];
_player setCaptive false;

if (true) exitWith {};
