private ["_fnc_medical", "_fnc_ammo", "_fnc_mg_ammo", "_fnc_nade", "_fnc_exp", "_fnc_at_ammo", "_fnc_at_M3_ammo", "_fnc_at_smaw_ammo", "_fnc_para", "_fnc_static_ammo", "_fnc_static_at_ammo", "_fnc_at_ammo", "_fnc_misc", "_fnc_Radio", "_fnc_Empty", "_fnc_attachCrateAction"];
JK_SpawnMarker = "SEN_ammo_mrk";

_fnc_spawnCrate = {
    ("Crate:" + _this select 3) call JK_crate_fnc_loadDB;
};
_fnc_attachCrateAction = {
    [_this, "<t color='#AE2020'>Request Radio/Backpack Crate</t>", _fnc_spawnCrate, "true", "radio"] call JK_Core_fnc_addAction;
    [_this, "<t color='#AE2020'>Request Ammo Crate</t>", _fnc_spawnCrate, "true", "Ammonition"] call JK_Core_fnc_addAction;
    [_this, "<t color='#AE2020'>Request Mg-Ammo Crate</t>", _fnc_spawnCrate, "true", "mgAmmo"] call JK_Core_fnc_addAction;
    [_this, "<t color='#AE2020'>Request Grenade Crate</t>", _fnc_spawnCrate, "true", "nade"] call JK_Core_fnc_addAction;
    [_this, "<t color='#AE2020'>Request Explosives Crate</t>", _fnc_spawnCrate, "true", "expl"] call JK_Core_fnc_addAction;
    [_this, "<t color='#AE2020'>Request AT4-Ammo Crate</t>", _fnc_spawnCrate, "true", "atAmmo"] call JK_Core_fnc_addAction;
    [_this, "<t color='#AE2020'>Request AT-M3MAAWS-Ammo Crate</t>", _fnc_spawnCrate, "true", "atM3Ammo"] call JK_Core_fnc_addAction;
    [_this, "<t color='#AE2020'>Request AT-SMAW-Ammo Crate</t>", _fnc_spawnCrate, "true", "atSmawAmmo"] call JK_Core_fnc_addAction;
    [_this, "<t color='#AE2020'>Request Equipment Crate</t>", _fnc_spawnCrate, "true", "misc"] call JK_Core_fnc_addAction;
    [_this, "<t color='#AE2020'>Request Medic Crate</t>", _fnc_spawnCrate,"true", "BasicMedic"] call JK_Core_fnc_addAction;
    [_this, "<t color='#AE2020'>Request Paradrop Crate</t>", _fnc_spawnCrate, "true", "para"] call JK_Core_fnc_addAction;
    [_this, "<t color='#AE2020'>Request UAV Crate</t>", _fnc_spawnCrate, "true", "UAV"] call JK_Core_fnc_addAction;
    [_this, "<t color='#AE2020'>Request Non-Moving-Ammo Crate</t>", _fnc_spawnCrate, "true", "staticAmmo"] call JK_Core_fnc_addAction;
    [_this, "<t color='#AE2020'>Request Non-Moving-AT-Ammo Crate</t>", _fnc_spawnCrate, "true", "staticATAmmo"] call JK_Core_fnc_addAction;
    [_this, "<t color='#AE2020'>Request Empty Crate</t>", _fnc_spawnCrate, "true", "Empty"] call JK_Core_fnc_addAction;
    [_this, "<t color='#AE2020'>Request Universal Wheel</t>", _fnc_spawnCrate, "true", "Wheel"] call JK_Core_fnc_addAction;
    [_this, "<t color='#AE2020'>Request Tank Track-Part</t>", _fnc_spawnCrate, "true", "Track"] call JK_Core_fnc_addAction;
};
ammonition call _fnc_attachCrateAction;
ammonition2 call _fnc_attachCrateAction;

[VVS, "<t color='#AE2020'>Open Vehicle Menu</t>", {createDialog "VSS_Menu"}] call JK_Core_fnc_addAction;
