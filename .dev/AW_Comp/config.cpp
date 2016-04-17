class CfgPatches {
    class aw_comp {
        units[] = {"AW_min_rf_soldier_AT", "AW_min_rf_soldier_LAT", "AW_min_rf_soldier_AA", "AW_ins_AT","AW_ins_AR","AW_ins_MK","AW_ins_MG","AW_ins_GL","AW_ins_RF"};
        weapons[] = {};
        requiredVersion = 1;
        requiredAddons[] = {
            "A3_Characters_F","A3_characters_f_beta","A3_Weapons_F_Ammoboxes",
            "A3_Weapons_F","A3_Characters_F_Heads","CBA_Extended_EventHandlers",
            "CUP_Weapons_Stinger","CUP_Weapons_AK","CUP_Weapons_WeaponsCore"
        };
    };
};

class CfgAmmo {
    class RocketBase;
    class CUP_R_RPG18_AT: RocketBase {
        allowAgainstInfantry = 1;
    };
    class CUP_R_PG7V_AT: RocketBase {
        allowAgainstInfantry = 1;
    };
};