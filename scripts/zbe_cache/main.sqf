params ["_aiCacheDist", "_minFrameRate", "_debug", "_vehicleCacheDistCar", "_vehicleCacheDistAir", "_vehicleCacheDistBoat"];

zbe_aiCacheDist = _aiCacheDist;
zbe_minFrameRate = _minFrameRate;
zbe_debug = _debug;
zbe_vehicleCacheDistCar = _vehicleCacheDistCar;
zbe_vehicleCacheDistAir = _vehicleCacheDistAir;
zbe_vehicleCacheDistBoat = _vehicleCacheDistBoat;

zbe_allGroups = 0;
zbe_cachedGroups = [];
zbe_cachedUnits = 0;
zbe_allVehicles = 0;
zbe_cachedVehicles = 0;
zbe_objectView = 0;
zbe_players = allPlayers;

call compileFinal preprocessFileLineNumbers "scripts\zbe_cache\zbe_functions.sqf";

if (zbe_minFrameRate isEqualTo -1) then {if (isDedicated) then {zbe_minFrameRate = 16} else {zbe_minFrameRate = 31};};

zbe_mapsize = worldSize;
zbe_mapside = zbe_mapsize / 2;
zbe_centerPOS = [zbe_mapside, zbe_mapside, 0];

zbe_cached_cars = [];
zbe_cached_air = [];
zbe_cached_boat = [];

[{
    zbe_players = allPlayers;
    {
        private "_disable";
        _disable = _x getVariable "JK_noCache";
        if (isNil "_disable") then {_disable = false};
        if (!_disable && {!(_x in zbe_cachedGroups)}) then {
            zbe_cachedGroups pushBack _x;
            [zbe_aiCacheDist, _x, zbe_minFrameRate, zbe_debug] execFSM "scripts\zbe_cache\zbe_aiCaching.fsm";
        };
        nil
    } count allGroups;

    private ["_assets", "_delete"];
    _assets = entities "";

    if !(JK_allreadyKnownCaching isEqualTo _assets) then {
        zbe_cached_cars = [];
        zbe_cached_air = [];
        zbe_cached_boat = [];
        JK_allreadyKnownCaching = +_assets;

        {
            call {
                if (_x isKindOf "LandVehicle") exitWith {
                    zbe_cached_cars pushBack _x;
                    [_x, zbe_vehicleCacheDistCar] execFSM "scripts\zbe_cache\zbe_vehicleCaching.fsm";
                };
                if (_x isKindOf "Air") exitWith {
                    zbe_cached_air pushBack _x;
                    [_x, zbe_vehicleCacheDistAir] execFSM "scripts\zbe_cache\zbe_vehicleCaching.fsm";
                };
                if (_x isKindOf "Ship") exitWith {
                    zbe_cached_boat pushBack _x;
                        [_x, zbe_vehicleCacheDistBoat] execFSM "scripts\zbe_cache\zbe_vehicleCaching.fsm";
                };
            };
            nil
        } count _assets;
    };
    zbe_cached_boat = zbe_cached_boat - [nil, objNull];
    zbe_cached_air = zbe_cached_air - [nil, objNull];
    zbe_cached_cars = zbe_cached_cars - [nil, objNull];

    zbe_allVehicles = (zbe_cached_boat + zbe_cached_air + zbe_cached_cars);
}, 200, []] call CBA_fnc_addPerFrameHandler;


// Vehicle Caching Beta (for client FPS)

if (zbe_debug) then {
    [{
        zbe_cachedUnits = (count allUnits - ({simulationEnabled _x} count allUnits));
        zbe_cachedVehicles = (count zbe_allVehicles - ({simulationEnabled _x} count zbe_allVehicles));
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
// Experimental, disabled for now
// if (!isDedicated) then {execFSM "scripts\zbe_cache\zbe_clientObjectDrawAuto.fsm";};
