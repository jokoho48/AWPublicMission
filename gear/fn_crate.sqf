_fnc_createCrate = {
    if (!(JK_ammoSuppAvail)) exitWith {
        hint "Supply Crate is not currently available"
    };

    JK_ammoSuppAvail = false;
    publicVariable "JK_ammoSuppAvail";

    params ["_crate", "_content", ["_reloadTime", 20]];

    _position = ((getMarkerPos "SEN_ammo_mrk") findEmptyPosition [0, 20]);
    if (_position isEqualTo []) exitWith {hint "No Space to create the Crate."};
    _crate createVehicle _position;

    if (!isNil "_content") then {
        clearWeaponCargoGlobal _crate;
        clearMagazineCargoGlobal _crate;
        clearItemCargoGlobal _crate;
        {
            _crate addMagazineCargoGlobal _x;
        } count _content;
    };
    [{
        JK_ammoSuppAvail = true;
        publicVariable "JK_ammoSuppAvail";
    }, _reloadTime] call ace_common_fnc_waitAndExecute;
    [[[_crate], {(_this select 0) addAction ["Delete Crate", {deleteVehicle (_this select 0)}];}],"BIS_fnc_call"] call BIS_fnc_MP;
};


_fnc_medical = {
    ["ACE_medicalSupplyCrate_advanced", nil , 5] call _fnc_createCrate;
};

_fnc_ammo = {
    [
        "Box_NATO_Wps_F",
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

            //Marksman
            ["rhsusf_20Rnd_762x51_m118_special_Mag", 20]
        ]
    ] call _fnc_createCrate;
};

_fnc_Radio = {
    ["ACE_Box_Misc", ["tf_rt1523g_rhs", 1], 5] call _fnc_createCrate;
};

_fnc_misc = {
    ["ACE_Box_Misc", nil , 5] call _fnc_createCrate;
};

if (str player in ["plt_co", "plt_sgt", "plt_eng", "plt_med", "a_sl", "a1_ftl", "a2_ftl", "rh1_co", "r_1", "r_2", "r_3", "r_4", "b2_ftl", "b1_ftl", "b_sl", "pj_1", "pj_2"]) then {
    VVS addAction["<t color='#3f3fff'>Open Vehicle Menu</t>",VVS_fnc_openVVS,["SEN_vehSpawn_mrk","All"],99];
    ammonition addAction ["<t color='#3f3fff'>Request Radio Crate</t>", _fnc_Radio];
};

ammonition addAction ["<t color='#3f3fff'>Request Ammo Crate</t>", _fnc_ammo];
ammonition addAction ["<t color='#3f3fff'>Request Medic Crate</t>", _fnc_medical];
