/*
loadout script by joko
Idea by Belbo
*/

class JK_loadOut {
    tag = "JK_loadOut";
    class core {
        file = "lib\gear";
        class gear: baseFNC {};
        class loadoutsInit: baseFNC {};
        class chooseLoadout: baseFNC {};
        class selectGear: baseFNC {};
        class addContainer: baseFNC {};
        class init: basePreFNC {};
        class addWeapon: baseFNC {};
        class reset: baseFNC {};
    };
};
class AW_loadOut {
    tag = "AW_loadOut";
    class core {
        file = "lib\gear";
        class chooseFaction: baseFNC {};
    };
};