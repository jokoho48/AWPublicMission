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
    };
    class USMC {
        file = "lib\gear\loadouts\USMC";
        // USMC
        class FTL;
        class arman;
        class assmg;
        class mg;
        class stormtrooper;
        class at;
        class atmk153;
        class atass;
        class ATAssmk153;
        class command;
        class grenadier;
        class leader;
        class marksman;
        class medic;
        class rifleman;
        class specialist;
        class radioOp;
    };

    class USARMY {
        file = "lib\gear\loadouts\USARMY";
        // USARMY
        class AR_FTL;
        class AR_arman;
        class AR_assmg;
        class AR_mg;
        class AR_stormtrooper;
        class AR_at;
        class AR_atmk153;
        class AR_atass;
        class AR_ATAssmk153;
        class AR_command;
        class AR_grenadier;
        class AR_leader;
        class AR_marksman;
        class AR_medic;
        class AR_rifleman;
        class AR_specialist;
        class AR_radioOp;
    };

    class parachuteLoadouts {
        file = "lib\gear\loadouts\parachute";
        // Paratrooper
        class paratrooper;
        class paraARman;
        class paraDropMedic;
        class paraExExpert;
        class paraGrenadier;
        class paraLeader;
        class paraMarksman;
        class paraStormtrooper;
        class paraAssAR;
        class paraSpecOps;
    };

    class specialLoadouts {
        file = "lib\gear\loadouts\special";
        // Special
        class Crew;
        class jetPilot;
        class pjMedic;
        class pilot;
        class SpecOps;
        class mortarTeamBipod;
        class mortarTeamTube;
        class AR_m2TeamTripod;
        class AR_m2TeamGun;
    };
};
