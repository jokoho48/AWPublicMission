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
        class MC_FTL;
        class MC_arman;
        class MC_assmg;
        class MC_mg;
        class MC_stormtrooper;
        class MC_aa;
        class MC_aaass;
        class MC_at;
        class MC_atmk153;
        class MC_atass;
        class MC_ATAssmk153;
        class MC_command;
        class MC_grenadier;
        class MC_leader;
        class MC_marksman;
        class MC_medic;
        class MC_rifleman;
        class MC_specialist;
        class MC_radioOp;
    };

    class USARMY {
        file = "lib\gear\loadouts\USARMY";
        // US Army
        class AR_FTL;
        class AR_arman;
        class AR_assmg;
        class AR_mg;
        class AR_stormtrooper;
        class AR_aa;
        class AR_aaass;
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

    class USSOF {
        file = "lib\gear\loadouts\USSOF";
        // US SOF
        class SO_arman;
        class SO_at;
        class SO_grenadier;
        class SO_leader;
        class SO_marksman;
        class SO_SpecOps;
        class SO_specialist;
    };

    class parachuteLoadouts {
        file = "lib\gear\loadouts\parachute";
        // Paratrooper
        class PARA_trooper;
        class PARA_ARman;
        class PARA_DropMedic;
        class PARA_ExExpert;
        class PARA_Grenadier;
        class PARA_Leader;
        class PARA_Marksman;
        class PARA_Stormtrooper;
        class PARA_AssAR;
        class PARA_SpecOps;
    };

    class specialLoadouts {
        file = "lib\gear\loadouts\special";
        // Special
        class Crew;
        class jetPilot;
        class pjMedic;
        class pilot;
        class MC_mortarTeamBipod;
        class MC_mortarTeamTube;
        class AR_m2TeamTripod;
        class AR_m2TeamGun;
    };
};
