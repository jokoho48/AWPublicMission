class Extended_Hit_Eventhandlers {
    class Civilian {
        class SEN_civ_hit {
            // runs where unit is local
            hit = "_this call SEN_fnc_civHit";
        };
    };
};
class Extended_Init_Eventhandlers {
    class CAManBase {
        class BG_BFT_init {
            init = "_this call BG_fnc_addActions";
        };
    };
};
