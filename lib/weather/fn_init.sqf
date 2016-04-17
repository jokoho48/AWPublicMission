JK_weatherTemplates = [
    ["Clear",[0,1,5],[0.30,0,0,1,1]],
    ["Overcast",[0,1,2],[0.50,0,0,2,2]],
    ["Light Rain",[1,2,3,5],[0.60,0.3,0.05,3,3]],
    ["Medium Rain",[2,3,4],[0.70,0.5,0.05,4,4]],
    ["Rainstorm",[3],[0.80,0.9,0.1,5,5]],
    ["Light Fog",[0,2,5,6],[0.4,0,[0.2,0.01,10],0,0]],
    ["Medium Fog",[5,6,7],[0.4,0,[0.4,0.005,20],0,0]],
    ["Dense Fog",[6],[0.5,0,[0.4,0.0025,30],0,0]]
];

if (isServer) then {
    // Check if there is no ParamsArray, and pick random if so, otherwise pick from paramsArray.
    JK_currentWeather = if(isNil "paramsArray") then {
        floor(random(count(JK_weatherTemplates)));
    } else {
        initialWeatherParam = (paramsArray select 13);
        switch (initialWeatherParam) do{
            case 0: {0};                                            // Clear
            case 1: {1};                                            // Overcast
            case 2: {2 + (floor (random 3))};                       // Rain
            case 3: {5 + (floor (random 3))};                       // Fog
            default {floor(random(count(JK_weatherTemplates)))};    // Random
        };
    };
    // Send out Initial Weather Variable
    publicVariable "JK_currentWeather";
    [{
        private _weatherUpdateArray = JK_weatherTemplates select JK_currentWeather;
        private _weatherUpdateForecasts = _weatherUpdateArray select 1;
        JK_nextWeather = _weatherUpdateForecasts select floor(random(count(_weatherUpdateForecasts)));
        publicVariable "JK_nextWeather";
        [{
            [[],"JK_Weather_fnc_updateWeather",true] call Bis_fnc_MP;
            JK_currentWeather = JK_nextWeather;
            publicVariable "JK_currentWeather";
        }, [], 10] call ace_common_fnc_waitAndExecute;
    }, 1190, []] call CBA_fnc_addPerFrameHandler;
    // Start recurring weather loop.
};

// Run Initial Weather Function for all.
[{
    !isNil "JK_currentWeather"
}, {
    private _weatherInitialArray = JK_weatherTemplates select JK_currentWeather;
    _weatherInitialArray params ["_weatherCurrentName", "", "_weatherInitialSettings"];
    _weatherInitialSettings params ["_weatherInitialOvercast", "_weatherInitialRainSnow", "_weatherInitialFog", "_weatherInitialWindEW", "_weatherInitialWindNS"];

    skipTime -24;
    86400 setOvercast _weatherInitialOvercast;
    0 setRain _weatherInitialRainSnow;
    86400 setFog _weatherInitialFog;
    setWind [_weatherInitialWindEW,_weatherInitialWindNS,true];
    skipTime 24;

    [{
        simulWeatherSync;
    }, [], 1] call ace_common_fnc_waitAndExecute;

    if (SEN_debug) then {
        hint format ["Debug Initialized Weather - %1\nOvercast: %2\nRain/Snow: %3\nFog: %4\nWind EW|NS: %5|%6",_weatherCurrentName,_weatherInitialOvercast,_weatherInitialRainSnow,_weatherInitialFog,_weatherInitialWindEW,_weatherInitialWindNS];
    };
}] call ace_common_fnc_waitUntilAndExecute;
