// Update Weather

private _weatherCurrentArray = JK_weatherTemplates select JK_currentWeather;
private _weatherNextArray = JK_weatherTemplates select JK_nextWeather;

private _weatherCurrentName = _weatherCurrentArray select 0;
_weatherNextArray params ["_weatherNextName", "", "_weatherNextSettings"];


_weatherNextSettings params ["_weatherNextOvercast", "_weatherNextRainSnow", "_weatherNextFog", "_weatherNextWindEW", "_weatherNextWindNS"];


if (overcast < _weatherNextOvercast) then {0 setOvercast 1;} else {0 setOvercast 0;};
1200 setRain _weatherNextRainSnow;
1200 setFog _weatherNextFog;
setWind [_weatherNextWindEW,_weatherNextWindNS,true];
if (SEN_debug) then {
    hint format ["Debug Updating Weather - %1\nOvercast: %2\nRain/Snow: %3\nFog: %4\nWind EW/NS: %5|%6", _weatherNextName, _weatherNextOvercast, _weatherNextRainSnow, _weatherNextFog, _weatherNextWindEW, _weatherNextWindNS];
};
