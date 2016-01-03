class AW_ins_base: min_rf_soldier_LAT {
    displayname = "[AW] INS Base";
    scope = 2;
    scopeCurator = 2;
    backpack = "";
    linkedItems[] = {"ItemMap","ItemCompass","ItemWatch","ItemRadio","NVGoggles_INDEP"};
    respawnLinkedItems[] = {"ItemMap","ItemCompass","ItemWatch","ItemRadio","NVGoggles_INDEP"};
    weapons[] = {"Throw","Put"};
    respawnWeapons[] = {"Throw","Put"};
    magazines[] = {};
    respawnMagazines[] = {};
    faction = "aw_Insurgents";
};
class AW_ins_AT: AW_ins_base;
class AW_ins_AR: AW_ins_base;
class AW_ins_MK: AW_ins_base;
class AW_ins_MG: AW_ins_base;
class AW_ins_GL: AW_ins_base;
class AW_ins_RF: AW_ins_base;
