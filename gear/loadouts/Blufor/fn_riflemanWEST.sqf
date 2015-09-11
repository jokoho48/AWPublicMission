/*
unit loadout script by joko
Idea by Belbo
creates a specific loadout for playable units. Add the items to their respective variables. (expected data type is given).
The kind of ammo a player gets with this loadout does not necessarily have to be specified. If tracer ammo is supposed to be used, you should set _primaryweaponAmmo to 0 and add those
magazines one for one in _items.
*/

//Vehicle Array
_vvsArray = [];

//clothing - (string)
_uniforms = ["rhs_uniform_cu_ocp"];
_vests = ["rhsusf_iotv_ocp_Rifleman"];
_headgears = ["rhsusf_ach_bare", "rhsusf_ach_bare_des", "rhsusf_ach_bare_des_ess", "rhsusf_ach_bare_des_headset", "rhsusf_ach_bare_des_headset_ess", "rhsusf_ach_bare_ess", "rhsusf_ach_bare_headset", "rhsusf_ach_bare_headset_ess", "rhsusf_ach_bare_semi", "rhsusf_ach_bare_semi_ess", "rhsusf_ach_bare_semi_headset", "rhsusf_ach_bare_semi_headset_ess", "rhsusf_ach_bare_tan", "rhsusf_ach_bare_tan_ess", "rhsusf_ach_bare_tan_headset", "rhsusf_ach_bare_tan_headset_ess", "rhsusf_ach_bare_wood", "rhsusf_ach_bare_wood_ess", "rhsusf_ach_bare_wood_headset", "rhsusf_ach_bare_wood_headset_ess", "rhsusf_ach_helmet_M81", "rhsusf_ach_helmet_ocp", "rhsusf_ach_helmet_ESS_ocp", "rhsusf_ach_helmet_headset_ocp", "rhsusf_ach_helmet_headset_ess_ocp", "rhsusf_ach_helmet_camo_ocp", "rhsusf_mich_bare_norotos", "rhsusf_mich_bare_norotos_arc", "rhsusf_mich_helmet_marpatwd", "rhsusf_mich_helmet_marpatwd_alt", "rhsusf_mich_helmet_marpatwd_norotos", "rhsusf_mich_helmet_marpatwd_norotos_arc"];
_backpacks = ["rhsusf_falconii"];
_insignium = "Curator";
_useProfileGoggles = 1;        //If set to 1, goggles from your profile will be used. If set to 0, _goggles will be added (or profile goggles will be removed when _goggles is left empty).
_goggles = "G_Combat";

//weapons - primary weapon - (string)
_primaryweapon = ["rhs_weap_m4a1_carryhandle", "rhs_weap_m4a1_grip", "rhs_weap_m4a1_carryhandle_grip2", "rhs_weap_m4a1_carryhandle_grip", "rhs_weap_m4a1_carryhandle_pmag", "rhs_weap_m4a1", "rhs_weap_m4a1_grip2"];

//primary weapon items - (array)
_itemsPrimaryweapon = [["rhsusf_acc_ACOG2_USMC", "rhsusf_acc_ACOG3_USMC", "rhsusf_acc_ACOG_USMC"],"rhsusf_acc_anpeq15side"];

//primary weapon ammo (if a primary weapon is given) and how many tracer mags - (integer)
_ARhandle = 0;        //should stay 0. Determines the class of ammunition for BIS_fnc_addWeapon. Specific Rifles need specific _ARhandles. Test it out.
_primaryweaponAmmo = 6;
_primaryweaponTracers = 6;

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
_handgun = "hgun_Pistol_heavy_01_F";

//handgun items - (array)
_itemsHandgun = [];

//handgun ammo (if a handgun is given) - (integer)
_handgunAmmo = 2;

//weapons - launcher - (string)
_launcher = "rhs_weap_M136";
_launcherHandle = 0;    //should stay the way it is. Determines the class of ammunition for BIS_fnc_addWeapon. Specific launchers need specific _launcherHandle. Test it out.

//launcher ammo (if a launcher is given) - (integer)
_launcherAmmo = 1;

//binocular - (string)
_binocular = "Binocular";

//throwables - (integer)
_grenadeHE = 2;
_grenadeSmokeWhite = 2;
_grenadeSmokeYellow = 0;
_grenadeSmokeOrange = 0;
_grenadeSmokeRed = 0;
_grenadeSmokePurple = 0;
_grenadeSmokeBlue = 1;
_grenadeSmokeGreen = 1;
_chemlightYellow = 0;
_chemlightRed = 0;
_chemlightGreen = 0;
_chemlightBlue = 0;
_IRgrenade = 0;

//ACE Items
_IVBagSaline250 = 0;
_IVBagSaline500 = 0;
_IVBagSaline1000 = 0;
_epinephrine = 0;
_morphine = 0;
_atropine = 0;

_fieldDressing = 0;
_packingBandage = 0;
_elasticBandage = 0;
_quikclot = 0;
_tourniquet = 0;

_earPlugs = 0;
_swapBarrel = 0;

//first aid kits and medi kits- (integer)
_FirstAidKits = 2;
_MediKit = 0;        //if set to 1, a MediKit and all FirstAidKits will be added to the backpack; if set to 0, FirstAidKits will be added to inventory in no specific order.

//items added specifically to uniform: - (array)
_itemsUniform = [];

//items added specifically to vest: - (array)
_itemsVest = [];

//items added specifically to Backpack: - (array)
_itemsBackpack = [];

//linked items (don't put "ItemRadio" in here, as it's set with _equipRadio) - (array)
_itemsLink = [
        "ItemRadio",
        "ItemWatch",
        "ItemCompass",
        "rhsusf_ANPVS_15",
        "ItemMap",
        "ItemGPS"
        ];

//items added to any container - (array)
_items = [];

///// No editing necessary below this line /////
params ["_player"];
_player setCaptive true;    //unfortunately necessary due to the time consumed by changing the weapon
[_player] call jk_loadOut_fnc_gear;
_player setVariable ["ace_medical_medicClass", 0];
_player setCaptive false;

if (true) exitWith {};
