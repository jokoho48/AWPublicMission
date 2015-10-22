private ["_fnc_medical", "_fnc_ammo","_fnc_at_ammo", "_fnc_misc", "_fnc_Radio"];
JK_fnc_createCrate = {
    private "_crate";
    if (!(JK_ammoSuppAvail)) exitWith {
        hint "Supply Crate is not currently available"
    };

    JK_ammoSuppAvail = false;
    publicVariable "JK_ammoSuppAvail";

    params ["_crateType", ["_reloadTime", 20], "_content"];

    _position = ((getMarkerPos "SEN_ammo_mrk") findEmptyPosition [0, 10]);
    if (_position isEqualTo []) exitWith {hint "No Space to create the Crate."};
    crateObject = _crateType createVehicle _position;
    if (!isNil "_content") then {
        publicVariable "crateObject";
        crateContent = _content;
        publicVariable "crateContent";
        [{
            crateObject hideObjectGlobal true;
            crateObject setVariable ["SEN_noClean", true, true];
            clearWeaponCargoGlobal crateObject;
            clearMagazineCargoGlobal crateObject;
            clearItemCargoGlobal crateObject;
            clearBackpackCargoGlobal crateObject;
            {
                if (isClass(configFile >> "CfgMagazines" >> (_x select 0))) then {
                    crateObject addMagazineCargoGlobal _x;
                };
                if (isClass(configFile >> "CfgWeapons" >> (_x select 0))) then {
                    crateObject addWeaponCargoGlobal _x;
                };
                if ((_x select 0) isKindOf "ItemCore") then {
                    crateObject addItemCargoGlobal _x;
                };
                if ((_x select 0) isKindOf "Bag_Base") then {
                    crateObject addBackpackCargoGlobal _x;
                };
                nil
            } count crateContent;
            crateObject hideObjectGlobal false;
        }, "BIS_fnc_call", false] call BIS_fnc_MP;
    };
    [{
        JK_ammoSuppAvail = true;
        publicVariable "JK_ammoSuppAvail";
    }, [], _reloadTime] call ace_common_fnc_waitAndExecute;
    [[{crateObject addAction ["<t color='#FF0000'>Delete Crate</t>", { deleteVehicle (_this select 0); JK_ammoSuppAvail = true; publicVariable "JK_ammoSuppAvail";}];}],"BIS_fnc_call", true, true, true] call BIS_fnc_MP;
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
        20,
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
            ["UGL_FlareCIR_F", 15],

            //MG Munition
            ["rhs_200rnd_556x45_M_SAW", 30],
            ["rhsusf_100Rnd_762x51", 30],

            // Normal
            ["30Rnd_556x45_Stanag", 55],
            ["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", 45],

            //Sprengstoffe+Zünder
            ["ACE_M26_Clacker", 2],
            ["ACE_Clacker", 4],
            ["SatchelCharge_Remote_Mag", 4],
            ["DemoCharge_Remote_Mag", 6],
            //Marksman
            ["rhsusf_20Rnd_762x51_m118_special_Mag", 20]
        ]
    ] call JK_fnc_createCrate;
};

_fnc_at_ammo = {
    [
        "Box_NATO_Wps_F",
        20,
        [
            //AT
                ["tf47_at4_HEDP", 5],
                ["tf47_at4_HP", 5],

                ["tf47_m3maaws_HEAT", 5],
                ["tf47_m3maaws_HEDP", 3],
                ["tf47_m3maaws_HE", 3],
                ["tf47_m3maaws_SMOKE", 3],
                ["tf47_m3maaws_ILLUM", 3],

                ["tf47_smaw_HEAA", 5],
                ["tf47_smaw_HEDP", 5],
                ["tf47_smaw_SR", 5]
        ]
    ] call JK_fnc_createCrate;
};

_fnc_Radio = {
    ["ACE_Box_Misc", 5, [["tf_rt1523g_rhs", 1]]] call JK_fnc_createCrate;
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
        ["ACE_wirecutter", 2],
        ["B_Parachute", 15],
        ["rhsusf_acc_eotech_552", 2],
        ["optic_Hamr", 2],
        ["rhsusf_acc_SR25S", 2],
        ["rhsusf_acc_compm4", 2]
    ]] call JK_fnc_createCrate;
};

_fnc_UAV = {
    ["ACE_Box_Misc", 5, [
        ["B_UavTerminal", 5],
        ["B_UAV_01_backpack_F", 5],
        ["ACE_UAVBattery", 20]
    ]] call JK_fnc_createCrate;
};

VVS addAction["<t color='#3f3fff'>Open Vehicle Menu</t>", VVS_fnc_openVVS, ["SEN_vehSpawn_mrk", "All"], 99, false, false, "", "player getVariable ['JK_CrateSpawnAllowed', false]"];
ammonition addAction ["<t color='#3f3fff'>Request Radio Crate</t>", _fnc_Radio, [], 0, false, false, "", "player getVariable ['JK_CrateSpawnAllowed', false]"];

ammonition addAction ["<t color='#3f3fff'>Request Ammo Crate</t>", _fnc_ammo];
ammonition addAction ["<t color='#3f3fff'>Request AT-Ammo Crate</t>", _fnc_at_ammo];
ammonition addAction ["<t color='#3f3fff'>Request ACE Misc Crate</t>", _fnc_misc];
ammonition addAction ["<t color='#3f3fff'>Request Medic Crate</t>", _fnc_medical];
ammonition addAction ["<t color='#3f3fff'>Request UAV Crate</t>", _fnc_UAV];
