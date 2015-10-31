/*
loadout script by joko
Idea by Belbo
*/

class JK_loadOut
{
    tag = "JK_loadOut";
    class core
    {
        file = "lib\gear";
        class applyLoadout {};
        class gear {};
        class loadoutsInit {};
        class chooseLoadout{};
        class selectGear {};
        class crate { postInit = 1; };
    };
    class loadoutsWEST
    {
        file = "lib\gear\loadouts\Blufor";
        // USMC
        class FTLWEST {};
        class armanWEST {};
        class assmgWEST {};
        class mgWEST {};
        class stormtrooperWEST {};
        class atWEST {};
        class atmk153WEST {};
        class atassWEST {};
        class ATAssmk153WEST {};
        class commandWEST {};
        class grenadierWEST {};
        class leaderWEST {};
        class marksmanWEST {};
        class medicWEST {};
        class riflemanWEST {};
        class specialistWEST {};
        class radioOpWEST {};

        // Paratrooper
        class paratrooperWEST {};
        class paraARmanWEST {};
        class paraDropMedicWEST {};
        class paraExExpertWEST {};
        class paraGrenadierWEST {};
        class paraLeaderWEST {};
        class paraMarksmanWEST {};
        class paraStormtrooperWEST {};
        class paraAssARWEST {};
        class paraSpecOpsWEST {};

        // Special
        class CrewWEST {};
        class jetPilotWEST {};
        class pjMedicWEST {};
        class pilotWEST {};
        class SpecOpsWEST {};
        class mortarTeamBipodWEST {};
        class mortarTeamTubeWEST {};
    };
};
