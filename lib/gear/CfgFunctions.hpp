/*
loadout script by joko
Idea by Belbo
*/

class JK_loadOut {
    tag = "JK_loadOut";
    class core {
        file = "lib\gear";
        class applyLoadout;
        class gear;
        class loadoutsInit;
        class chooseLoadout;
        class selectGear;
        class crate { postInit = 1; };
        class init { preInit = 1;};
    };
};
