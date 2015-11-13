// =========================================================================================================
// Dynamic Combat Generator Function List
// =========================================================================================================
class SEN {
    tag = "SEN";
    class functions {
        file = "fnc";
        class repetivCleanUp { preInit = 1; };
        //class Compass3d { postInit = 1; };
        class civHit;
        class removeAction;
        class log;
        class checkInMarker;
        class checkApproval;
        class timerBomb;
        class timerArty;
        class compareWire;
        class compareCode;
        class spawnBaseSmall;
        class spawnBase;
        class spawnGroup;
        class spawnSquad;
        class spawnSniper;
        class spawnCiv;
        class spawnCivSuicide;
        class spawnTower;
        class spawnStatic;
        class spawnAnimal;
        class spawnReinforcements;
        class settingsPre { preInit = 1; };
        class settingsPost { postInit = 1; };
        class EOD {postInit = 1;};
        class setOwner;
        class setParams;
        class setUnitSurrender;
        class setUnitHostage;
        class setSide;
        class setStrength;
        class setPatrolGroup;
        class setPatrolUnit;
        class setPatrolVeh;
        class setTaskCiv;
        class setTask;
        class setTimer;
        class findThirdPos;
        class findInString;
        class findRandomPos;
        class findHousePos;
        class findRuralHousePos;
        class findRuralFlatPos;
        class findPosArray;
        class onCivQuestion;
        class getIntel;
        class getNearPlayers;
        class getPlayers;
        class getApproval;
        class getApprovalNumber;
    };
};
