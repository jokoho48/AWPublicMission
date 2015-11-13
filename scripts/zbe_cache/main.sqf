params ["_aiCacheDist", "_minFrameRate", "_vehicleCacheDistCar", "_vehicleCacheDistAir", "_vehicleCacheDistBoat"];

zbe_aiCacheDist = _aiCacheDist;
zbe_minFrameRate = _minFrameRate;
zbe_vehicleCacheDistCar = _vehicleCacheDistCar;
zbe_vehicleCacheDistAir = _vehicleCacheDistAir;
zbe_vehicleCacheDistBoat = _vehicleCacheDistBoat;

zbe_cachedGroups = [];
zbe_cachedUnits = 0;
zbe_allVehicles = [];
zbe_cachedVehicles = 0;
zbe_objectView = 0;

call compileFinal preprocessFileLineNumbers "scripts\zbe_cache\zbe_functions.sqf";

if (zbe_minFrameRate isEqualTo -1) then {if (isDedicated) then {zbe_minFrameRate = 16} else {zbe_minFrameRate = 31};};

zbe_mapsize = worldSize;
zbe_mapside = zbe_mapsize / 2;
zbe_centerPOS = [zbe_mapside, zbe_mapside, 0];

zbe_cached_cars = [];
zbe_cached_air = [];
zbe_cached_boat = [];
JK_allreadyKnownCaching = [];

JK_fnc_addNewVehicleToCaching = {
    params ["_vehicle"];
    if (side _vehicle in [west, resistance]) then {
        call {
            if (_vehicle isKindOf "LandVehicle") exitWith {
                if !(_vehicle in zbe_cached_cars) then {
                    zbe_cached_cars pushBack _vehicle;
                    [_vehicle, zbe_vehicleCacheDistCar] execFSM "scripts\zbe_cache\zbe_vehicleCaching.fsm";
                };
            };
            if (_vehicle isKindOf "Air") exitWith {
                if !(_vehicle in zbe_cached_air) then {
                    zbe_cached_air pushBack _vehicle;
                    [_vehicle, zbe_vehicleCacheDistAir] execFSM "scripts\zbe_cache\zbe_vehicleCaching.fsm";
                };
            };
            if (_vehicle isKindOf "Ship") exitWith {
                if !(_vehicle in zbe_cached_boat) then {
                    zbe_cached_boat pushBack _vehicle;
                    [_vehicle, zbe_vehicleCacheDistBoat] execFSM "scripts\zbe_cache\zbe_vehicleCaching.fsm";
                };
            };
        };
    };
    nil
};

JK_fnc_addNewGroupToCaching = {
    private "_disable";
    params ["_group"];
    if (!(_group getVariable ["JK_noCache", false]) && {!(_group in zbe_cachedGroups)}) then {
        zbe_cachedGroups pushBack _group;
        [zbe_aiCacheDist, _group, zbe_minFrameRate, SEN_debug] execFSM "scripts\zbe_cache\zbe_aiCaching.fsm";
    };
    nil
};

JK_cachePFHID = [{
    {
        [_x] call JK_fnc_addNewGroupToCaching;
    } count allGroups;

    private ["_assetsLoop", "_assets", "_delete"];
    _assets = vehicles;
    if !(JK_allreadyKnownCaching isEqualTo _assets) then {
        _assetsLoop = _assets - JK_allreadyKnownCaching;
        JK_allreadyKnownCaching = +_assets;

        {
            [_x] call JK_fnc_addNewVehicleToCaching;
        } count _assetsLoop;
    };
    zbe_cached_boat = zbe_cached_boat - [nil];
    zbe_cached_air = zbe_cached_air - [nil];
    zbe_cached_cars = zbe_cached_cars - [nil];
    JK_allreadyKnownCaching = JK_allreadyKnownCaching - [nil];


    zbe_cached_boat = zbe_cached_boat - [objNull];
    zbe_cached_air = zbe_cached_air - [objNull];
    zbe_cached_cars = zbe_cached_cars - [objNull];
    JK_allreadyKnownCaching = JK_allreadyKnownCaching - [objNull];

    zbe_allVehicles = (zbe_cached_boat + zbe_cached_air + zbe_cached_cars);
}, 200, []] call CBA_fnc_addPerFrameHandler;

publicVariable "JK_cachePFHID";

if (SEN_debug) then {
    [{
        zbe_cachedUnits = ({!simulationEnabled _x} count allUnits);
        zbe_cachedVehicles = ({!simulationEnabled _x} count zbe_allVehicles);
        zbe_allVehiclesCount = (count zbe_allVehicles);
        hintSilent parseText format ["
        <t color='#FFFFFF' size='1.5'>ZBE Caching</t><br/>
        <t color='#FFFFFF'>Debug data</t><br/><br/>
        <t color='#A1A4AD' align='left'>Game time in seconds:</t><t color='#FFFFFF' align='right'>%1</t><br/><br/>
        <t color='#A1A4AD' align='left'>Number of groups:</t><t color='#FFFFFF' align='right'>%2</t><br/>
        <t color='#A1A4AD' align='left'>All units:</t><t color='#FFFFFF' align='right'>%3</t><br/>
        <t color='#A1A4AD' align='left'>Cached units:</t><t color='#39a0ff' align='right'>%4</t><br/><br/>
        <t color='#A1A4AD' align='left'>All vehicles:</t><t color='#FFFFFF' align='right'>%5</t><br/>
        <t color='#A1A4AD' align='left'>Cached vehicles:</t><t color='#39a0ff' align='right'>%6</t><br/><br/>
        <t color='#A1A4AD' align='left'>FPS:</t><t color='#FFFFFF' align='right'>%7</t><br/><br/>
        <t color='#A1A4AD' align='left'>Obj draw distance:</t><t color='#FFFFFF' align='right'>%8</t><br/>
        ", (round time), count allGroups, count allUnits, zbe_cachedUnits, zbe_allVehiclesCount, zbe_cachedVehicles, (round diag_fps), zbe_objectView];
        zbe_log_stats = format ["Groups: %1 # All/Cached Units: %2/%3 # All/Cached Vehicles: %4/%5 # FPS: %6 # ObjectDrawDistance: %7", count allGroups, count allUnits, zbe_cachedUnits, zbe_allVehiclesCount, zbe_cachedVehicles, (round diag_fps), zbe_objectView];
        [0,format ["%1 ZBE_Cache (%2) ---  %3", (round time), name player, zbe_log_stats]] call SEN_fnc_log;
    }, 20, []] call CBA_fnc_addPerFrameHandler;
};
