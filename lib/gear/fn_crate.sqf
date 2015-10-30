private ["_fnc_medical", "_fnc_ammo", "_fnc_mg_ammo", "_fnc_nade", "_fnc_exp", "_fnc_at_ammo", "_fnc_at_M3_ammo", "_fnc_at_smaw_ammo", "_fnc_para", "_fnc_static_ammo", "_fnc_static_at_ammo", "_fnc_at_ammo", "_fnc_misc", "_fnc_Radio", "_fnc_Empty", "_fnc_attachCrateAction"];
JK_SpawnMarker = "SEN_ammo_mrk";
JK_fnc_createCrate = {
    private "_crate";
    if (!(JK_ammoSuppAvail)) exitWith {
        hint "Supply Crate is not currently available"
    };

    JK_ammoSuppAvail = false;
    publicVariable "JK_ammoSuppAvail";

    params ["_crateType", ["_reloadTime", 20], "_content"];

    _position = ((getMarkerPos JK_SpawnMarker) findEmptyPosition [0, 10]);
    if (_position isEqualTo []) exitWith {hint "No Space to create the Crate."};
    _crateObject = _crateType createVehicle _position;
    if (!isNil "_content") then {
        [[[_crateObject, _content],{
            params ["_crateObject", "_content"];
            _crateObject addAction ["<t color='#FF0000'>Delete Crate</t>", { deleteVehicle (_this select 0); JK_ammoSuppAvail = true; publicVariable "JK_ammoSuppAvail";}];
            if !(isServer) exitWith {};
            _crateObject hideObjectGlobal true;
            _crateObject setVariable ["SEN_noClean", true, true];
            clearWeaponCargoGlobal _crateObject;
            clearMagazineCargoGlobal _crateObject;
            clearItemCargoGlobal _crateObject;
            clearBackpackCargoGlobal _crateObject;
            {
                if (isClass(configFile >> "CfgMagazines" >> (_x select 0))) then {
                    _crateObject addMagazineCargoGlobal _x;
                };
                if (isClass(configFile >> "CfgWeapons" >> (_x select 0))) then {
                    _crateObject addWeaponCargoGlobal _x;
                };
                if ((_x select 0) isKindOf "ItemCore") then {
                    _crateObject addItemCargoGlobal _x;
                };
                if ((_x select 0) isKindOf "Bag_Base") then {
                    _crateObject addBackpackCargoGlobal _x;
                };
                nil
            } count _content;
            _crateObject hideObjectGlobal false;
        }], "BIS_fnc_call", true] call BIS_fnc_MP;
    };
    [{
        JK_ammoSuppAvail = true;
        publicVariable "JK_ammoSuppAvail";
    }, [], _reloadTime] call ace_common_fnc_waitAndExecute;
};


_fnc_medical = {
    if (ace_medical_level == 1) then {
        ["ACE_medicalSupplyCrate", 5] call JK_fnc_createCrate;
        } else {
        ["ACE_medicalSupplyCrate_advanced", 5] call JK_fnc_createCrate;
    };
};

_fnc_ammo = {
    [
        "Box_NATO_Wps_F",
        10,
        [
            // Normal
            ["30Rnd_556x45_Stanag", 55],
            ["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", 45],
            ["rhsusf_mag_7x45acp_MHP", 5],

            //CQC
            ["rhsusf_8Rnd_00Buck", 15],

            //Marksman
            ["rhsusf_20Rnd_762x51_m118_special_Mag", 20]
        ]
    ] call JK_fnc_createCrate;
};
_fnc_mg_ammo = {
    [
        "Box_NATO_Wps_F",
        10,
        [
            //MG Munition
            ["rhs_200rnd_556x45_M_SAW", 11],
            ["rhsusf_100Rnd_762x51", 11]
        ]
    ] call JK_fnc_createCrate;
};

_fnc_para = {
    [
        "Box_NATO_Wps_F",
        10,
        [
            ["B_Parachute", 10]
        ]
    ] call JK_fnc_createCrate;
};

_fnc_nade = {
    [
        "Box_NATO_Wps_F",
        10,
        [
            // Granaten
            ["HandGrenade", 30],
            ["SmokeShell", 15],
            ["SmokeShellYellow", 15],
            ["SmokeShellRed", 15],
            ["SmokeShellPurple", 15],
            ["SmokeShellBlue", 15],
            ["SmokeShellGreen", 15],
            ["Chemlight_Yellow", 15],
            ["Chemlight_Red", 15],
            ["Chemlight_Green", 15],
            ["Chemlight_Blue", 15],
            ["1Rnd_HE_Grenade_shell", 30],
            ["1Rnd_Smoke_Grenade_shell", 15],
            ["1Rnd_SmokeRed_Grenade_shell", 15],
            ["1Rnd_SmokePurple_Grenade_shell", 15],
            ["1Rnd_SmokeBlue_Grenade_shell", 15],
            ["1Rnd_SmokeGreen_Grenade_shell", 15],
            ["UGL_FlareWhite_F", 15],
            ["UGL_FlareYellow_F", 15],
            ["UGL_FlareRed_F", 15],
            ["UGL_FlareGreen_F", 15],
            ["ACE_M84", 5],
            ["UGL_FlareCIR_F", 15]
        ]
    ] call JK_fnc_createCrate;
};

_fnc_exp = {
    [
        "Box_NATO_Wps_F",
        10,
        [
            //Sprengstoffe+Zünder
            ["ACE_M26_Clacker", 10],
            ["ACE_Clacker", 10],
            ["SatchelCharge_Remote_Mag", 10],
            ["DemoCharge_Remote_Mag", 10]
        ]
    ] call JK_fnc_createCrate;
};

_fnc_at_ammo = {
    [
        "Box_NATO_Wps_F",
        10,
        [
            //AT
            ["tf47_at4_HEDP", 5],
            ["tf47_at4_HP", 4]
        ]
    ] call JK_fnc_createCrate;
};

_fnc_static_ammo = {
    [
        "Box_NATO_Wps_F",
        30,
        [
            //AT
            ["tf47_at4_HEDP", 5],
            ["tf47_at4_HP", 4],

            // Granaten
            ["HandGrenade", 30],
            ["SmokeShell", 15],
            ["SmokeShellYellow", 15],
            ["SmokeShellRed", 15],
            ["SmokeShellPurple", 15],
            ["SmokeShellBlue", 15],
            ["SmokeShellGreen", 15],
            ["Chemlight_Yellow", 15],
            ["Chemlight_Red", 15],
            ["Chemlight_Green", 15],
            ["Chemlight_Blue", 15],
            ["1Rnd_HE_Grenade_shell", 30],
            ["1Rnd_Smoke_Grenade_shell", 15],
            ["1Rnd_SmokeRed_Grenade_shell", 15],
            ["1Rnd_SmokePurple_Grenade_shell", 15],
            ["1Rnd_SmokeBlue_Grenade_shell", 15],
            ["1Rnd_SmokeGreen_Grenade_shell", 15],
            ["UGL_FlareWhite_F", 15],
            ["UGL_FlareYellow_F", 15],
            ["UGL_FlareRed_F", 15],
            ["UGL_FlareGreen_F", 15],
            ["UGL_FlareCIR_F", 15],
            ["ACE_M84", 5],

            //MG Munition
            ["rhs_200rnd_556x45_M_SAW", 30],
            ["rhsusf_100Rnd_762x51", 30],

            //CQC
            ["rhsusf_5Rnd_00Buck", 30],

            // Normal
            ["30Rnd_556x45_Stanag", 55],
            ["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", 45],

            //Marksman
            ["rhsusf_20Rnd_762x51_m118_special_Mag", 20]
        ]
    ] call JK_fnc_createCrate;
};

_fnc_static_at_ammo = {
    [
        "Box_NATO_Wps_F",
        30,
        [
            //AT
            ["tf47_at4_HEDP", 10],
            ["tf47_at4_HP", 8],
            ["tf47_smaw_HEAA", 10],
            ["tf47_smaw_HEDP", 5],
            ["tf47_smaw_SR", 5],
            ["tf47_m3maaws_HEAT", 10],
            ["tf47_m3maaws_HEDP", 3],
            ["tf47_m3maaws_HE", 3],
            ["tf47_m3maaws_SMOKE", 3],
            ["tf47_m3maaws_ILLUM", 3]
        ]
    ] call JK_fnc_createCrate;
};

_fnc_at_smaw_ammo = {
    [
        "Box_NATO_Wps_F",
        10,
        [
            //AT
            ["tf47_smaw_HEAA", 5],
            ["tf47_smaw_HEDP", 5],
            ["tf47_smaw_SR", 5]
        ]
    ] call JK_fnc_createCrate;
};

_fnc_at_M3_ammo = {
    [
        "Box_NATO_Wps_F",
        10,
        [
            //AT
            ["tf47_m3maaws_HEAT", 7],
            ["tf47_m3maaws_HEDP", 2],
            ["tf47_m3maaws_HE", 2],
            ["tf47_m3maaws_SMOKE", 2],
            ["tf47_m3maaws_ILLUM", 2]
        ]
    ] call JK_fnc_createCrate;
};

_fnc_Radio = {
    ["ACE_Box_Misc", 5, [["tf_rt1523g_rhs", 3],["rhsusf_falconii", 10],["rhsusf_assault_eagleaiii_coy", 10],["tf_rt1523g_big_rhs", 1]]] call JK_fnc_createCrate;
};

_fnc_misc = {
    ["ACE_Box_Misc", 60, [
            ["ACE_HuntIR_monitor", 3],
            ["ACE_UAVBattery", 2],
            ["ACE_RangeCard", 2],
            ["ACE_Kestrel4500", 2],
            ["ACE_Flashlight_MX991", 5],
            ["ACE_Cellphone", 2],
            ["ACE_DeadManSwitch", 2],
            ["ACE_DefusalKit", 2],
            ["ACE_M26_Clacker", 2],
            ["ACE_Clacker", 2],
            ["ACE_EarPlugs", 5],
            ["ACE_DAGR", 2],
            ["ACE_CableTie", 5],
            ["ACE_IR_Strobe_Item", 5],
            ["ACE_ATragMX", 2],
            ["ACE_SpottingScope", 2],
            ["ACE_SpareBarrel", 5],
            ["ACE_RangeTable_82mm", 2],
            ["ACE_microDAGR", 5],
            ["ACE_bodyBag", 5],
            ["ACE_MapTools", 5],
            ["ACE_wirecutter", 2]
    ]] call JK_fnc_createCrate;
};

_fnc_UAV = {
    ["ACE_Box_Misc", 5, [
        ["B_UavTerminal", 5],
        ["B_UAV_01_backpack_F", 5],
        ["ACE_UAVBattery", 20]
    ]] call JK_fnc_createCrate;
};

_fnc_Empty = {
    ["ACE_Box_Misc", 0, []] call JK_fnc_createCrate;
};

_fnc_attachCrateAction = {
    [_this, "<t color='#AE2020'>Request Radio/Backpack Crate</t>", _fnc_Radio, {player getVariable ['JK_CrateSpawnAllowed', false]}] call JK_Core_fnc_addAction;
    [_this, "<t color='#AE2020'>Request Ammo Crate</t>", _fnc_ammo] call JK_Core_fnc_addAction;
    [_this, "<t color='#AE2020'>Request Mg-Ammo Crate</t>", _fnc_mg_ammo] call JK_Core_fnc_addAction;
    [_this, "<t color='#AE2020'>Request Grenade Crate</t>", _fnc_nade] call JK_Core_fnc_addAction;
    [_this, "<t color='#AE2020'>Request Explosives Crate</t>", _fnc_exp] call JK_Core_fnc_addAction;
    [_this, "<t color='#AE2020'>Request AT4-Ammo Crate</t>", _fnc_at_ammo] call JK_Core_fnc_addAction;
    [_this, "<t color='#AE2020'>Request AT-M3MAAWS-Ammo Crate</t>", _fnc_at_M3_ammo] call JK_Core_fnc_addAction;
    [_this, "<t color='#AE2020'>Request AT-SMAW-Ammo Crate</t>", _fnc_at_smaw_ammo] call JK_Core_fnc_addAction;
    [_this, "<t color='#AE2020'>Request Equipment Crate</t>", _fnc_misc] call JK_Core_fnc_addAction;
    [_this, "<t color='#AE2020'>Request Medic Crate</t>", _fnc_medical] call JK_Core_fnc_addAction;
    [_this, "<t color='#AE2020'>Request Paradrop Crate</t>", _fnc_para] call JK_Core_fnc_addAction;
    [_this, "<t color='#AE2020'>Request UAV Crate</t>", _fnc_UAV] call JK_Core_fnc_addAction;
    [_this, "<t color='#AE2020'>Request Non-Moving-Ammo Crate</t>", _fnc_static_ammo] call JK_Core_fnc_addAction;
    [_this, "<t color='#AE2020'>Request Non-Moving-AT-Ammo Crate</t>", _fnc_static_at_ammo] call JK_Core_fnc_addAction;
    [_this, "<t color='#AE2020'>Request Empty Crate</t>", _fnc_Empty] call JK_Core_fnc_addAction;
};
ammonition call _fnc_attachCrateAction;
ammonition2 call _fnc_attachCrateAction;

[VVS, "<t color='#AE2020'>Open Vehicle Menu</t>", VVS_fnc_openVVS, {player getVariable ['JK_CrateSpawnAllowed', false]}, ["SEN_vehSpawn_mrk", "All"]] call JK_Core_fnc_addAction;
