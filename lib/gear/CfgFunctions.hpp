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
    };
};
