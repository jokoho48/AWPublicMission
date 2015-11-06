JK_VSS_ListTickets = [
    [
        "Unarmed HMMWVs",
        [
            "rhsusf_m1025_w_s",
            "rhsusf_m998_w_s_2dr_halftop",
            "rhsusf_m998_w_s_2dr",
            "rhsusf_m998_w_s_2dr_fulltop",
            "rhsusf_m998_w_s_4dr_halftop",
            "rhsusf_m998_w_s_4dr",
            "rhsusf_m998_w_s_4dr_fulltop",
            "rhsusf_m1025_w",
            "rhsusf_m998_w_2dr_fulltop",
            "rhsusf_m998_w_2dr_halftop",
            "rhsusf_m998_w_2dr",
            "rhsusf_m998_w_4dr_fulltop",
            "rhsusf_m998_w_4dr_halftop",
            "rhsusf_m998_w_4dr"
        ],
        200,
        "Leader"
    ],
    [
        "Armed HMMWVs",
        [
            "rhsusf_m1025_w_s_m2",
            "rhsusf_m1025_w_s_Mk19",
            "rhsusf_m1025_w_m2",
            "rhsusf_m1025_w_mk19"
        ],
        250,
        "Leader"
    ],
    [
        "Unarmed LKW",
        [
            "rhsusf_M1078A1P2_wd_fmtv_usarmy",
            "rhsusf_M1078A1P2_wd_flatbed_fmtv_usarmy",
            "rhsusf_M1078A1P2_wd_open_fmtv_usarmy",
            "rhsusf_M1078A1P2_B_wd_fmtv_usarmy",
            "rhsusf_M1078A1P2_B_wd_fmtv_usarmy",
            "rhsusf_M1078A1P2_B_wd_open_fmtv_usarmy",
            "rhsusf_M1083A1P2_wd_fmtv_usarmy",
            "rhsusf_M1083A1P2_wd_flatbed_fmtv_usarmy",
            "rhsusf_M1083A1P2_wd_open_fmtv_usarmy",
            "rhsusf_M1083A1P2_B_wd_fmtv_usarmy",
            "rhsusf_M1083A1P2_B_wd_flatbed_fmtv_usarmy",
            "rhsusf_M1083A1P2_B_wd_open_fmtv_usarmy"
        ],
        250,
        "Leader"
    ],
    [
        "Armed LKW",
        [
            "rhsusf_M1078A1P2_B_M2_wd_fmtv_usarmy",
            "rhsusf_M1078A1P2_B_M2_wd_flatbed_fmtv_usarmy",
            "rhsusf_M1078A1P2_B_M2_wd_open_fmtv_usarmy",
            "rhsusf_M1083A1P2_B_M2_wd_fmtv_usarmy",
            "rhsusf_M1083A1P2_B_M2_wd_flatbed_fmtv_usarmy",
            "rhsusf_M1083A1P2_B_M2_wd_open_fmtv_usarmy"
        ],
        300,
        "Leader"
    ],
    [
        "MRAPs",
        [
            "rhsusf_rg33_usmc_wd",
            "rhsusf_rg33_m2_usmc_wd"
        ],
        300,
        "Leader"
    ],
    [
        "Panzer",
        [
            "rhsusf_m1a1aimwd_usarmy",
            "rhsusf_m1a1aim_tuski_wd",
            "rhsusf_m1a2sep1wd_usarmy",
            "rhsusf_m1a2sep1tuskiwd_usarmy",
            "rhsusf_m1a2sep1tuskiiwd_usarmy",
            "rhsusf_m1a1fep_wd",
            "rhsusf_m1a1fep_od"
        ],
        600,
        "Crew"
    ],
    [
        "Schützenpanzerwagen",
        [
            "rhsusf_m113_usarmy_supply",
            "rhsusf_m113_usarmy",
            "rhsusf_m113_usarmy_M240",
            "rhsusf_m113_usarmy_medical",
            "rhsusf_m113_usarmy_MK19",
            "rhsusf_m113_usarmy_unarmed"
        ],
        400,
        "Crew"
    ],
    [
        "Schützenpanzer",
        [
            "RHS_M2A2_wd",
            "RHS_M2A2_BUSKI_WD",
            "RHS_M2A3_wd",
            "RHS_M2A3_BUSKI_wd",
            "RHS_M2A3_BUSKIII_wd",
            "RHS_M6_wd"
        ],
        500,
        "Crew"
    ],
    [
        "Leichte Helikopter",
        [
            "B_Heli_Light_01_armed_F",
            "B_Heli_Light_01_F"
        ],
        350,
        "Pilot"
    ],
    [
        "Transport Helikopter",
        [
            "RHS_UH1Y_FFAR",
            "RHS_UH1Y",
            "RHS_UH1Y_UNARMED",
            "RHS_CH_47F",
            "RHS_UH60M",
            "RHS_UH60M_MEV2",
            "RHS_UH60M_MEV"
        ],
        400,
        "Pilot"
    ],
    [
        "Kampf Helikopter",
        [
            "RHS_AH1Z_wd_CS",
            "RHS_AH1Z_wd_GS",
            "RHS_AH1Z_wd",
            "RHS_AH64D_wd_AA",
            "RHS_AH64D_wd_CS",
            "RHS_AH64D_wd_GS",
            "RHS_AH64D_wd"
        ],
        700,
        "Pilot"
    ],
    [
        "Flugzeuge",
        [
            "RHS_C130J",
            "RHS_A10"
        ],
        1000,
        "Pilot"
    ],
    [
        "Other",
        [
            "B_Quadbike_01_F"
        ],
        50,
        "All"
    ]
];

["JK_VSS_ListTickets", str JK_VSS_ListTickets, 2] spawn db_fnc_save;



/*
// Leader
"rhsusf_m1025_w_s",
"rhsusf_m998_w_s_2dr_halftop",
"rhsusf_m998_w_s_2dr",
"rhsusf_m998_w_s_2dr_fulltop",
"rhsusf_m998_w_s_4dr_halftop",
"rhsusf_m998_w_s_4dr",
"rhsusf_m998_w_s_4dr_fulltop",
"rhsusf_m1025_w",
"rhsusf_m998_w_2dr_fulltop",
"rhsusf_m998_w_2dr_halftop",
"rhsusf_m998_w_2dr",
"rhsusf_m998_w_4dr_fulltop",
"rhsusf_m998_w_4dr_halftop",
"rhsusf_m998_w_4dr",
"rhsusf_M1078A1P2_wd_fmtv_usarmy",
"rhsusf_M1078A1P2_wd_flatbed_fmtv_usarmy",
"rhsusf_M1078A1P2_wd_open_fmtv_usarmy",
"rhsusf_M1078A1P2_B_wd_fmtv_usarmy",
"rhsusf_M1078A1P2_B_wd_fmtv_usarmy",
"rhsusf_M1078A1P2_B_wd_open_fmtv_usarmy",
"rhsusf_M1083A1P2_wd_fmtv_usarmy",
"rhsusf_M1083A1P2_wd_flatbed_fmtv_usarmy",
"rhsusf_M1083A1P2_wd_open_fmtv_usarmy",
"rhsusf_M1083A1P2_B_wd_fmtv_usarmy",
"rhsusf_M1083A1P2_B_wd_flatbed_fmtv_usarmy",
"rhsusf_M1083A1P2_B_wd_open_fmtv_usarmy"

"rhsusf_rg33_usmc_wd",
"rhsusf_rg33_m2_usmc_wd"


// Crew

"rhsusf_m113_usarmy_supply",
"rhsusf_m113_usarmy",
"rhsusf_m113_usarmy_M240",
"rhsusf_m113_usarmy_medical",
"rhsusf_m113_usarmy_MK19",
"rhsusf_m113_usarmy_unarmed"

"RHS_M2A2_wd",
"RHS_M2A2_BUSKI_WD",
"RHS_M2A3_wd",
"RHS_M2A3_BUSKI_wd",
"RHS_M2A3_BUSKIII_wd",
"RHS_M6_wd"


// Pilots
"RHS_UH1Y_FFAR",
"RHS_UH1Y",
"RHS_UH1Y_UNARMED",
"RHS_CH_47F",
"RHS_UH60M",
"RHS_UH60M_MEV2",
"RHS_UH60M_MEV"

"B_Heli_Light_01_armed_F",
"B_Heli_Light_01_F"

"RHS_AH1Z_wd_CS",
"RHS_AH1Z_wd_GS",
"RHS_AH1Z_wd",
"RHS_AH64D_wd_AA",
"RHS_AH64D_wd_CS",
"RHS_AH64D_wd_GS",
"RHS_AH64D_wd"

"RHS_C130J",
"RHS_A10"
*/
