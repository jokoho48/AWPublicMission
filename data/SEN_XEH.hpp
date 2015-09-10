class Extended_Hit_Eventhandlers {
    class Civilian {
        class SEN_civ_hit {
            // runs where unit is local
            hit = "if (alive (_this select 0) && {side (_this select 0) isEqualTo CIVILIAN} && {isPlayer (_this select 1)}) then {SEN_approvalCiv = SEN_approvalCiv - (25 + (random 25)); publicVariable ""SEN_approvalCiv"";}";
        };
    };
};