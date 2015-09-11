/*
gear-adding function by joko
Idea by Belbo
adds the loadouts from ADV_Setup\gear\west\*.sqf to the units
If custom content is added to the units, they possibly have to be added to _glrfls (if there are rifles with grenade launchers).
define per cfgFunctions or from init.sqf or initPlayerLocal.sqf as early as possible via
call JK_loadOut_fnc_gear;
*/

private ["_uniform", "_headgear", "_vest", "_backpack", "_count"];
params ["_unit"];

//a lot of arrays
_medicBackPacks = ["B_AssaultPack_rgr_Medic","B_FieldPack_ocamo_Medic","B_FieldPack_oucamo_Medic","B_AssaultPack_rgr_ReconMedic"];
_NVGoggles = ["NVGoggles","NVGoggles_OPFOR","NVGoggles_INDEP"];

//randomizers:
_uniform = _uniforms call BIS_fnc_selectRandom;
_headgear = _headgears call BIS_fnc_selectRandom;
_vest = _vests call BIS_fnc_selectRandom;
_backpack = _backpacks call BIS_fnc_selectRandom;

if (typeName _primaryWeapon == "ARRAY") then {_primaryWeapon = _primaryWeapon call BIS_fnc_selectRandom;};


//removals:
removeUniform _unit;
removeallItems _unit;
removeAllAssignedItems _unit;
removeallWeapons _unit;
removeHeadgear _unit;
removeBackpack _unit;
removeVest _unit;
{_unit removeMagazine _x} forEach magazines _unit;
//...and readding. Clothing:
_unit forceAddUniform _uniform;
_unit addVest _vest;
if (_backpack != "") then {
    _unit addBackpack _backpack;
};
_unit addHeadgear _headgear;
if (_useProfileGoggles == 0) then {
    removeGoggles _unit;
    _unit addGoggles _goggles;
};

//removing FAKs/MediKits/AGM medic stuff again and adding FAKs/MediKits
if (_backpack in _medicBackPacks) then {
    _unit removeItems "MediKit";
    _unit removeItems "FirstAidKit";
};
if (_mediKit == 0) then {
    for "_i" from 1 to _FirstAidKits do    {
        _unit addItem "FirstAidKit";
    };
};
if (_mediKit >= 1) then {
    _unit addItemToBackpack "MediKit";
    for "_i" from 1 to _FirstAidKits do    {
        _unit addItemToBackpack "FirstAidKit";
    };
};

//'nades:
_IR_GrenType = switch (side (group _unit)) do {
    case west: {"B_IR_Grenade"};
    case east: {"O_IR_Grenade"};
    case independent: {"I_IR_Grenade"};
    default {"I_IR_Grenade"};
};

_grenadeArray = [["HandGrenade", _grenadeHE], ["SmokeShell", _grenadeSmokeWhite],["SmokeShellYellow", _grenadeSmokeYellow],["SmokeShellOrange", _grenadeSmokeOrange],["SmokeShellRed", _grenadeSmokeRed],["SmokeShellPurple", _grenadeSmokePurple],["SmokeShellBlue", _grenadeSmokeBlue],["SmokeShellGreen", _grenadeSmokeGreen],["Chemlight_Yellow", _chemlightYellow],["Chemlight_Red", _chemlightRed],["Chemlight_Green", _chemlightGreen],["Chemlight_Blue", _chemlightBlue],[_IR_GrenType, _IRgrenade],["1Rnd_HE_Grenade_shell", _40mmHeGrenadesAmmo],["1Rnd_Smoke_Grenade_shell", _40mmSmokeGrenadesWhite],["1Rnd_SmokeYellow_Grenade_shell", _40mmSmokeGrenadesYellow],["1Rnd_SmokeOrange_Grenade_shell", _40mmSmokeGrenadesOrange],["1Rnd_SmokeRed_Grenade_shell", _40mmSmokeGrenadesRed],["1Rnd_SmokePurple_Grenade_shell", _40mmSmokeGrenadesPurple],["1Rnd_SmokeBlue_Grenade_shell", _40mmSmokeGrenadesBlue],["1Rnd_SmokeGreen_Grenade_shell", _40mmSmokeGrenadesGreen],["UGL_FlareWhite_F", _40mmFlareWhite],["UGL_FlareYellow_F", _40mmFlareYellow],["UGL_FlareRed_F", _40mmFlareRed],["UGL_FlareGreen_F", _40mmFlareGreen],["UGL_FlareCIR_F", _40mmFlareIR]];
{
    _unit addMagazines _x;
    nil
} count _grenadeArray;

//weapons
[_unit,_binocular,1] call BIS_fnc_addWeapon;
[_unit,_handgun,_handgunAmmo] call BIS_fnc_addWeapon;
{_unit addHandgunItem _x; true} count _itemsHandgun;
[_unit,_launcher,_launcherAmmo,_launcherHandle] call BIS_fnc_addWeapon;
if (_primaryweaponTracers >= 1) then {
    if (_primaryWeapon == "arifle_MX_SW_Black_F" || _primaryWeapon == "arifle_MX_SW_F") then {
        [_unit, _primaryWeapon, _primaryweaponTracers, _ARhandle + 1] call BIS_fnc_addWeapon;
        [_unit, _primaryWeapon, _primaryweaponAmmo, _ARhandle] call BIS_fnc_addWeapon;
    }
    else {
        [_unit, _primaryWeapon, _primaryweaponAmmo, _ARhandle] call BIS_fnc_addWeapon;
        [_unit, _primaryWeapon, _primaryweaponTracers, _ARhandle + 1] call BIS_fnc_addWeapon;
    };
} else {
    [_unit, _primaryWeapon, _primaryweaponAmmo, _ARhandle] call BIS_fnc_addWeapon;
};
{
    if (typeName _x == "ARRAY") then {
        _unit addPrimaryWeaponItem (_x call BIS_fnc_selectRandom);
    } else {
        _unit addPrimaryWeaponItem _x;
    };
    nil
} count _itemsPrimaryweapon;
_unit selectWeapon _primaryweapon;

if (ace_medical_level == 1) then {
    _ivBag = "ACE_bloodIV";
} else {
    _ivBag = "ACE_salineIV";
};


for "_i" from 1 to _IVBagSaline250 do {
    _unit addItem format [_ivBag,"_250"];
};

for "_i" from 1 to _IVBagSaline500 do {
    _unit addItem format [_ivBag,"_500"];
};

for "_i" from 1 to _IVBagSaline1000 do {
    _unit addItem _ivBag;
};

for "_i" from 1 to _epinephrine do {
    _unit addItem "ACE_epinephrine";
};

for "_i" from 1 to _morphine do {
    _unit addItem "ACE_morphine";
};

for "_i" from 1 to _atropine do {
    _unit addItem "ACE_atropine";
};

for "_i" from 1 to _fieldDressing do {
    _unit addItem "ACE_fieldDressing";
};

for "_i" from 1 to _packingBandage do {
    _unit addItem "ACE_packingBandage";
};

for "_i" from 1 to _elasticBandage do {
    _unit addItem "ACE_elasticBandage";
};

for "_i" from 1 to _quikclot do {
    _unit addItem "ACE_quikclot";
};

for "_i" from 1 to _tourniquet do {
    _unit addItem "ACE_tourniquet";
};

for "_i" from 1 to _earPlugs do {
    _unit addItem "ACE_EarPlugs";
};

for "_i" from 1 to _swapBarrel do {
    _unit addItem "ACE_SpareBarrel";
};

//items:
{_unit linkitem _x; false} count _itemslink;
{_unit addItemToUniform _x; false} count _itemsUniform;
{_unit addItemToVest _x; false} count _itemsVest;
if (_backpack != "") then {
    {_unit addItemToBackpack _x; false} count _itemsBackpack;
};
{_unit addItem _x; false} count _items;
[_unit,_insignium] call BIS_fnc_setUnitInsignia;
if(true)exitWith{};
