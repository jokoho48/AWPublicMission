/***************SETTINGS***********************/
JK_isExploded = false;
hideIedSectionMarkers = true;  //sets the alpha to 0 after spawning IEDs at a section
hideSafeZoneMarkers = true;  //sets the alpha to 0 of a safezone
iedSafeZones = ["SEN_safezone_mrk"];
itemsRequiredToDisarm = ["ACE_DefusalKit"];   //"MineDetector" or "ToolKit" for example
betterDisarmers = []; // people who are better at disarming

baseDisarmChance = 90; //how well everybody can disarm
bonusDisarmChance = 0; //increase that the "betterDisarmers" get

secondaryChance = 10; //Chance that a secondary IED will spawn.

smallChance = 20; //Chance that a small IED will be chosen.
mediumChance = 40; //Chance that a medium IED will be chosen.
largeChance = 60; //Chance that a large IED will be chosen.

iedSecondaryItems = ["Land_Canteen_F", "Land_FMradio_F", "Land_CanisterOil_F"];

iedSmallItems = ["RoadCone_F","Land_Pallets_F","Land_WheelCart_F","Land_Tyre_F"];

iedMediumItems = ["Land_Portable_generator_F","Land_WoodenBox_F","Land_MetalBarrel_F","Land_BarrelTrash_grey_F","Land_Sacks_heap_F","Land_WoodenLog_F","Land_WoodPile_F"];

iedLargeItems = ["Land_Bricks_V2_F","Land_Bricks_V3_F","Land_Bricks_V4_F","Land_GarbageBags_F","Land_GarbagePallet_F","Land_GarbageWashingMachine_F","Land_JunkPile_F","Land_Tyres_F","Land_Wreck_Skodovka_F","Land_Wreck_Car_F","Land_Wreck_Car3_F","Land_Wreck_Car2_F","Land_Wreck_Offroad_F","Land_Wreck_Offroad2_F"];

//Place the mapLocations, predefinedLocations, and markerNames of places you don't want any IEDs spawning
iedSafeZones = ["SEN_safezone_mrk"];

waitUntil {!isNil "SEN_occupiedLocation" && !isNil "SEN_whitelistLocation"};
//If you want to use locations without making markers on the map, define them here. Altis has been provided as an example. ***THESE ARE NOT WHERE THE ACTUAL IEDS ARE SPAWNED***
//["Name",[LocationX,LocationY,LocationZ],size]
if (isServer) then {
    predefinedLocations = [];
    iedInitialArray = [];
    private ["_tempwlLocations" ,"_tempCitiyArray", "_count"];
    _tempwlLocations = +SEN_whitelistLocation;
    _count = floor (random (count _tempwlLocations - 1));
    _count = (_count min JK_maxIEDCount) min JK_minIEDCount;
    for "_i" from _count to 0 step -1 do {
        private "_var";
        _var = (_tempwlLocations call BIS_fnc_selectRandom);
        _tempCitiyArray pushBack _var;
        _tempwlLocations deleteAt (_tempwlLocations find _var);
    };
    JK_iedTown = +_tempCitiyArray;
    publicVariable "JK_iedTown";
    _tempCitiyArray append SEN_occupiedLocation;
    {
        private ["_id", "_townSize", "_avgTownSize", "_pos"];
        _id = format ["%1%2%3%4%5%6%7%8%9%10", random 100,random 100,random 100,random 100,random 100,random 100,random 100,random 100,random 100,random 100];
        _location = if (typeName _x == "ARRAY") then {
            _pos = _x;
            nearestLocation [_x, ""]
        } else {
            _pos = getPos _x;
            _x
        };
        _townSize = size _location;
        _avgTownSize = (((_townSize select 0) + (_townSize select 1))*2);
        predefinedLocations pushBack [_id, _pos, _avgTownSize];
        iedInitialArray pushBack [_id, floor(random 6), "West"];
        nil
    } count _tempCitiyArray;
    publicVariable "predefinedLocations";
    publicVariable "iedInitialArray";
};
waitUntil {!isNil "predefinedLocations" && !isNil "iedInitialArray"};
iedPredefinedLocationsSize = count predefinedLocations;

/***************EXPERIMENTAL***********************/
// This is still being worked on and may contain bugs, please report them on the forums.
allowExplosiveToTriggerIEDs = true;

/***************END EXPERIMENTAL*******************/


//These are the actual IEDs that will spawn. Add them using one of the following formats.
//mapLocations must have their type defined as one of "NameCityCapital","NameCity","NameVillage", "NameLocal"
//["All", side]
//["AllCities", side]
//["AllVillages", side]
//["AllLocals", side]
//["mapLocation", side]
//["mapLocation", amountToPlace, side];
//["mapLocation", iedsToPlace, fakesToPlace, side]
//["mapLocation", amountToPlace, [fakeChance, smallIedChance, mediumIedChance, largeIedChance], side]
//["predefinedLocation", side]
//["predefinedLocation", amountToPlace, side]
//["predefinedLocation", iedsToPlace, fakesToPlace, side]
//["predefinedLocation", amountToPlace, [fakeChance, smallIedChance, mediumIedChance, largeIedChance], side]
/*********Marker size > 1**********************/
//["marker", amountToPlace, [fakeChance, smallIedChance, mediumIedChance, largeIedChance], side]
//["marker", iedsToPlace, fakesToPlace, side]
//["marker", amountToPlace, side]
//["marker", side]
/*********Marker size = 1**********************/
//["marker", side]
//["marker", chanceToBeReal, side]
//["marker", [fakeChance, smallIedChance, mediumIedChance, largeIedChance] , side]

//The side can be a single side, or an array of sides
//Ex. "West"   or ["West,"East"]
//http://community.bistudio.com/wiki/side
/*
iedInitialArray = [
    ["AllCities","West"],
    ["AllVillages","West"]
    ["AltisRandom1",6,"West"],
    ["AltisRandom2",6,"West"],
    ["AltisRandom3",6,"West"],
    ["AltisRandom4",6,"West"],
    ["AltisRandom5",6,"West"],
    ["AltisRandom6",6,"West"],
    ["AltisRandom7",6,"West"],
    ["AltisRandom8",6,"West"],
    ["AltisRandom9",6,"West"],
    ["AltisRandom10",6,"West"],
    ["AltisRandom11",6,"West"],
    ["AltisRandom12",6,"West"],
    ["AltisRandom13",6,"West"],
    ["AltisRandom14",6,"West"],
    ["AltisRandom15",6,"West"],
    ["AltisRandom16",6,"West"],
    //["Gravia", 20, [0, 30, 0, 0], "West" ],
    //["Lakka", 2, 8,  ["West","East"] ],
    //["OreoKastro", "West"],
    //["Athira", 2, "West" ],
    //["IEDSINGLE1", "West"],
    //["IEDSINGLE2", 50 ,"West"],
    //["IEDSINGLE3", [0,0,0,100], "West"]
];
*/
