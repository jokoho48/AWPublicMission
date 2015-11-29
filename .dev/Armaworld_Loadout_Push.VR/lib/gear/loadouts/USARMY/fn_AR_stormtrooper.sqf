/*
unit loadout script by joko
Idea by Belbo
creates a specific loadout for playable units. Add the items to their respective variables. (expected data type is given).
The kind of ammo a player gets with this loadout does not necessarily have to be specified. If tracer ammo is supposed to be used, you should set JK_primaryweaponAmmo to 0 and add those
magazines one for one in JK_items.
*/

//clothing - (string)
JK_uniforms = ["rhs_uniform_cu_ucp"];
JK_vests = ["rhsusf_iotv_ucp_Rifleman"];
JK_headgears = ["rhsusf_ach_helmet_headset_ucp", "rhsusf_ach_helmet_ESS_ucp", "rhsusf_mich_bare_norotos_arc_tan", "rhsusf_mich_bare_norotos_tan", "rhsusf_ach_helmet_headset_ess_ucp", "rhsusf_ach_helmet_ucp_norotos", "rhsusf_ach_helmet_ucp"];
JK_backpacks = ["B_AssaultPack_mcamo"];
JK_insignium = ["111thID","TFAegis","GryffinRegiment",""];
JK_useProfileGoggles = 1;        //If set to 1, goggles from your profile will be used. If set to 0, JK_goggles will be added (or profile goggles will be removed when JK_goggles is left empty).
JK_goggles = "G_Combat";

//weapons - primary weapon - (string)
JK_primaryweapon = "rhs_weap_M590_8RD";

//primary weapon items - (array)
JK_itemsPrimaryweapon = [];

//primary weapon ammo (if a primary weapon is given) and how many tracer mags - (integer)
JK_ARhandle = 0;        //should stay 0. Determines the class of ammunition for BIS_fnc_addWeapon. Specific Rifles need specific JK_ARhandles. Test it out.
JK_primaryweaponAmmo = 8;
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
JK_handgun = "rhsusf_weap_m1911a1";

//handgun items - (array)
JK_itemsHandgun = [];

//handgun ammo (if a handgun is given) - (integer)
JK_handgunAmmo = 5;

//weapons - launcher - (string)
JK_launcher = "tf47_at4_HEDP";
JK_launcherHandle = 0;    //should stay the way it is. Determines the class of ammunition for BIS_fnc_addWeapon. Specific launchers need specific JK_launcherHandle. Test it out.
JK_launcherItems = [];

//launcher ammo (if a launcher is given) - (integer)
JK_launcherAmmo = 1;

//binocular - (string)
JK_binocular = "Binocular";

//throwables - (integer)
JK_grenadeHE = 2;
JK_grenadeSmokeWhite = 2;
JK_grenadeSmokeYellow = 0;
JK_grenadeSmokeOrange = 0;
JK_grenadeSmokeRed = 0;
JK_grenadeSmokePurple = 0;
JK_grenadeSmokeBlue = 1;
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
JK_itemsVest = [];

//items added specifically to Backpack: - (array)
JK_itemsBackpack = ["DemoCharge_Remote_Mag","DemoCharge_Remote_Mag","ACE_Clacker","ACE_M84","ACE_M84","ACE_DefusalKit"];

//linked items (don't put "ItemRadio" in here, as it's set with _equipRadio) - (array)
JK_itemsLink = [
        "ACRE_PRC343",
        "ItemWatch",
        "ItemCompass",
        "ACE_NVG_Wide",
        "ItemMap",
        "ItemGPS"
        ];

//items added to any container - (array)
JK_items = ["ACE_Flashlight_MX991","ACE_MapTools","ACE_CableTie","ACE_microDAGR"];

JK_medicClass = 0;
JK_spawnAllowed = false;
JK_isEngineer = 0;
JK_isPilot = false;

//Vehicle Spawn System
JK_VehClass = "All";

///// No editing necessary below this line /////
_this call jk_loadOut_fnc_gear;
