class CfgPatches {
    class aw_comp {
        units[] = {"AW_min_rf_soldier_AT", "AW_min_rf_soldier_LAT", "AW_min_rf_soldier_AA", "AW_ins_AT","AW_ins_AR","AW_ins_MK","AW_ins_MG","AW_ins_GL","AW_ins_RF"};
        weapons[] = {};
        requiredVersion = 1;
        requiredAddons[] = {
            "A3_Characters_F","A3_characters_f_beta","A3_Weapons_F_Ammoboxes",
            "A3_Weapons_F","A3_Characters_F_Heads","CBA_Extended_EventHandlers",
            "CUP_Weapons_Stinger","CUP_Weapons_AK","CUP_Weapons_WeaponsCore",
            "min_rf_data","min_rf_vehicle","min_rf_units","min_rf_wp","RH_m4_cfg"
        };
    };
};
class CfgFactionClasses {
    class aw_Insurgents {
        displayName = "Rebellen";
        priority = 2;
        icon = "";
        side = 3;
    };
};

class CfgVehicles {
    class min_rf_soldier_LAT;
    class AW_min_rf_soldier_AT: min_rf_soldier_LAT {
        displayname = "AW RU AT";
        weapons[] = {"arifle_min_rf_ak12_aco","CUP_launch_RPG7V","hgun_Rook40_F","Throw","Put"};
        respawnWeapons[] = {"arifle_min_rf_ak12_aco","CUP_launch_RPG7V","hgun_Rook40_F","Throw","Put"};
        magazines[] = {"30Rnd_min_rf_545x39_mag","30Rnd_min_rf_545x39_mag","30Rnd_min_rf_545x39_mag","30Rnd_min_rf_545x39_mag","30Rnd_min_rf_545x39_mag","30Rnd_min_rf_545x39_mag","16Rnd_9x21_Mag","16Rnd_9x21_Mag","16Rnd_9x21_Mag","CUP_PG7V_M","CUP_PG7V_M","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red"};
        respawnMagazines[] = {"30Rnd_min_rf_545x39_mag","30Rnd_min_rf_545x39_mag","30Rnd_min_rf_545x39_mag","30Rnd_min_rf_545x39_mag","30Rnd_min_rf_545x39_mag","30Rnd_min_rf_545x39_mag","16Rnd_9x21_Mag","16Rnd_9x21_Mag","16Rnd_9x21_Mag","CUP_PG7V_M","CUP_PG7V_M","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red"};
    };
    class AW_min_rf_soldier_LAT: min_rf_soldier_LAT {
        displayname = "AW RU LAT";
        weapons[] = {"arifle_min_rf_ak12_aco","CUP_launch_RPG18","hgun_Rook40_F","Throw","Put"};
        respawnWeapons[] = {"arifle_min_rf_ak12_aco","CUP_launch_RPG18","hgun_Rook40_F","Throw","Put"};
        magazines[] = {"30Rnd_min_rf_545x39_mag","30Rnd_min_rf_545x39_mag","30Rnd_min_rf_545x39_mag","30Rnd_min_rf_545x39_mag","30Rnd_min_rf_545x39_mag","30Rnd_min_rf_545x39_mag","16Rnd_9x21_Mag","16Rnd_9x21_Mag","16Rnd_9x21_Mag","CUP_RPG18_M","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red"};
        respawnMagazines[] = {"30Rnd_min_rf_545x39_mag","30Rnd_min_rf_545x39_mag","30Rnd_min_rf_545x39_mag","30Rnd_min_rf_545x39_mag","30Rnd_min_rf_545x39_mag","30Rnd_min_rf_545x39_mag","16Rnd_9x21_Mag","16Rnd_9x21_Mag","16Rnd_9x21_Mag","CUP_RPG18_M","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red"};
    };
    class AW_min_rf_soldier_AA: min_rf_soldier_LAT {
        displayname = "AW RU AA";
        weapons[] = {"arifle_min_rf_ak12_aco","CUP_launch_9K32Strela","hgun_Rook40_F","Throw","Put"};
        respawnWeapons[] = {"arifle_min_rf_ak12_aco","CUP_launch_9K32Strela","hgun_Rook40_F","Throw","Put"};
        magazines[] = {"30Rnd_min_rf_545x39_mag","30Rnd_min_rf_545x39_mag","30Rnd_min_rf_545x39_mag","30Rnd_min_rf_545x39_mag","30Rnd_min_rf_545x39_mag","30Rnd_min_rf_545x39_mag","16Rnd_9x21_Mag","16Rnd_9x21_Mag","16Rnd_9x21_Mag","CUP_Strela_2_M","CUP_Strela_2_M","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red"};
        respawnMagazines[] = {"30Rnd_min_rf_545x39_mag","30Rnd_min_rf_545x39_mag","30Rnd_min_rf_545x39_mag","30Rnd_min_rf_545x39_mag","30Rnd_min_rf_545x39_mag","30Rnd_min_rf_545x39_mag","16Rnd_9x21_Mag","16Rnd_9x21_Mag","16Rnd_9x21_Mag","CUP_Strela_2_M","CUP_Strela_2_M","SmokeShell","SmokeShellRed","Chemlight_red","Chemlight_red"};
    };

    class AW_ins_base: AW_min_rf_soldier_AA {
        scope = 0;
        scopeCurator = 0;
        backpack = "";
        linkedItems[] = {"ItemMap","ItemCompass","ItemWatch","ItemRadio","NVGoggles_INDEP"};
        respawnLinkedItems[] = {"ItemMap","ItemCompass","ItemWatch","ItemRadio","NVGoggles_INDEP"};
        weapons[] = {"Throw","Put"};
        respawnWeapons[] = {"Throw","Put"};
        magazines[] = {"SmokeShell"};
        respawnMagazines[] = {"SmokeShell"};
        faction = "aw_Insurgents";
    };

    class AW_ins_AT: AW_ins_base {
        displayname = "AW INS AT";
        scope = 2;
        scopeCurator = 2;
    };
    class AW_ins_AR: AW_ins_AT {
        displayname = "AW INS AR";
    };
    class AW_ins_MK: AW_ins_AT {
        displayname = "AW INS MK";
    };
    class AW_ins_MG: AW_ins_AT {
        displayname = "AW INS MG";
    };
    class AW_ins_GL: AW_ins_AT {
        displayname = "AW INS GL";
    };
    class AW_ins_RF: AW_ins_AT {
        displayname = "AW INS RF";
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


class Extended_Init_Eventhandlers {
    class AW_ins_base {
        class aw_comp {
            init = "_this call JK_fnc_randomGear;";
        };
    };
};

class Extended_PreInit_EventHandlers {
    aw_comp_init = "call compile preProcessFileLineNumbers '\AW_Comp\fnc_init.sqf'; JK_fnc_randomGear = compile preProcessFileLineNumbers '\AW_Comp\fnc_randomGear.sqf';";
};
