class CfgPatches {
    class aw_comp {
        units[] = {"AW_min_rf_soldier_AT", "AW_min_rf_soldier_LAT"};
        weapons[] = {};
        requiredVersion = 1;
        requiredAddons[] = {"A3_Characters_F","A3_characters_f_beta","A3_Weapons_F_Ammoboxes","A3_Weapons_F","A3_Characters_F_Heads","min_rf_air","min_rf_boat","min_rf_data","min_rf_radio","min_rf_vehicle","min_rf_wp","min_rf_wp_c","CUP_Weapons_RPG7","CUP_Weapons_RPG18"};
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
    #include "RU.hpp"
    #include "Ins.hpp"
};

#include "XEH.hpp"
