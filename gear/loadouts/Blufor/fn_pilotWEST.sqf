/*
unit loadout script by joko
Idea by Belbo
creates a specific loadout for playable units. Add the items to their respective variables. (expected data type is given).
The kind of ammo a player gets with this loadout does not necessarily have to be specified. If tracer ammo is supposed to be used, you should set _primaryweaponAmmo to 0 and add those
magazines one for one in _items.
*/

//Vehicle Array
JK_vvsArray = ["rhs_vehclass_aircraft", "rhs_vehclass_helicopter", "rhs_vehclass_helicopter_wd", "B_Heli_Light_01_F", "B_Heli_Light_01_armed_F", "B_Heli_Light_01_stripped_F"];

//clothing - (string)
_uniforms = ["U_B_HeliPilotCoveralls"];
_vests = ["V_TacVest_blk"];
_headgears = ["H_CrewHelmetHeli_B"];
_backpacks = ["tf_rt1523g_big_rhs"];
_insignium = "";
_useProfileGoggles = 0;        //If set to 1, goggles from your profile will be used. If set to 0, _goggles will be added (or profile goggles will be removed when _goggles is left empty).
_goggles = "G_Aviator";

//weapons - primary weapon - (string)
_primaryweapon = ["rhs_weap_m16a4", "rhs_weap_m16a4_grip", "rhs_weap_m16a4_carryhandle", "rhs_weap_m16a4_carryhandle_grip_pmag", "rhs_weap_m16a4_carryhandle_grip", "rhs_weap_m16a4_carryhandle_pmag", "rhs_weap_m4", "rhs_weap_m4_grip2", "rhs_weap_m4_grip", "rhs_weap_m4_carryhandle", "rhs_weap_m4_carryhandle_pmag"];

//primary weapon items - (array)
_itemsPrimaryweapon = [];

//primary weapon ammo (if a primary weapon is given) and how many tracer mags - (integer)
_ARhandle = 0;        //should stay 0. Determines the class of ammunition for BIS_fnc_addWeapon. Specific Rifles need specific _ARhandles. Test it out.
_primaryweaponAmmo = 4;
_primaryweaponTracers = 0;

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
_itemsHandgun = ["optic_MRD"];

//handgun ammo (if a handgun is given) - (integer)
_handgunAmmo = 4;

//weapons - launcher - (string)
_launcher = "";
_launcherHandle = 0;    //should stay the way it is. Determines the class of ammunition for BIS_fnc_addWeapon. Specific launchers need specific _launcherHandle. Test it out.

//launcher ammo (if a launcher is given) - (integer)
_launcherAmmo = 0;

//binocular - (string)
_binocular = "Binocular";

//throwables - (integer)
_grenadeHE = 2;
_grenadeSmokeWhite = 2;
_grenadeSmokeYellow = 0;
_grenadeSmokeOrange = 0;
_grenadeSmokeRed = 0;
_grenadeSmokePurple = 2;
_grenadeSmokeBlue = 0;
_grenadeSmokeGreen = 0;
_chemlightYellow = 0;
_chemlightRed = 0;
_chemlightGreen = 0;
_chemlightBlue = 0;
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
_itemsBackpack = [];

//linked items - (array)
_itemsLink = [
        "ItemRadio",
        "ItemWatch",
        "ItemCompass",
        "ItemMap",
        "ItemGPS"
        ];

//items added to any container - (array)
_items = ["ACE_Flashlight_MX991","ACE_MapTools","ACE_CableTie","ACE_microDAGR"];

///// No editing necessary below this line /////

params ["_player"];
_player setCaptive true;    //unfortunately necessary due to the time consumed by changing the weapon
[_player] call jk_loadOut_fnc_gear;
_player setVariable ["JK_CrateSpawnAllowed", true];
_player setVariable ["ACE_IsEngineer", 2];
_player setVariable ["JK_isPilot", true];
_player setCaptive false;
if (true) exitWith {};
