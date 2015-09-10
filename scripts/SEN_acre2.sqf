/*
Author: SENSEI

Last modified: 6/27/2015

Description: setup acre2 presets

        NOTE: created with ACRE2 2.1.0.811 / TS 3.0.16
__________________________________________________________________*/
SEN_acre2_commandRadio = "ACRE_PRC152"; // you can use "ACRE_PRC148" or "ACRE_PRC152"
SEN_acre2_squadRadio = "ACRE_PRC343"; // don't change
SEN_acre2_supportRadio = "ACRE_PRC117F"; // don't change

[SEN_acre2_commandRadio, "default", "SEN_preset"] call acre_api_fnc_copyPreset;
[SEN_acre2_squadRadio, "default", "SEN_preset"] call acre_api_fnc_copyPreset;
[SEN_acre2_supportRadio, "default", "SEN_preset"] call acre_api_fnc_copyPreset;

// setup labels
call {
    if (SEN_acre2_commandRadio isEqualTo "ACRE_PRC148") exitWith {
        [SEN_acre2_commandRadio, "SEN_preset", 1, "label", "COMMAND"] call acre_api_fnc_setPresetChannelField;
        [SEN_acre2_commandRadio, "SEN_preset", 2, "label", "SUPPORT"] call acre_api_fnc_setPresetChannelField;
    };
    if (SEN_acre2_commandRadio isEqualTo "ACRE_PRC152") exitWith {
        [SEN_acre2_commandRadio, "SEN_preset", 1, "description", "COMMAND"] call acre_api_fnc_setPresetChannelField;
        [SEN_acre2_commandRadio, "SEN_preset", 2, "description", "SUPPORT"] call acre_api_fnc_setPresetChannelField;
    };
    [2,"Incorrect channel data for SEN_acre2_commandRadio."] call SEN_fnc_log;
};

[SEN_acre2_supportRadio, "SEN_preset", 1, "name", "COMMAND"] call acre_api_fnc_setPresetChannelField;
[SEN_acre2_supportRadio, "SEN_preset", 2, "name", "SUPPORT"] call acre_api_fnc_setPresetChannelField;

[SEN_acre2_squadRadio, "SEN_preset"] call acre_api_fnc_setPreset;
[SEN_acre2_commandRadio, "SEN_preset"] call acre_api_fnc_setPreset;
[SEN_acre2_supportRadio, "SEN_preset"] call acre_api_fnc_setPreset;

call SEN_fnc_setAcreRadio;

/*
///////////// OLD METHOD | DEPRECIATED /////////////


// setup SEN_acre2_squadRadio preset data
call {
    if (player getvariable ["SEN_team",""] isEqualTo "plt") exitWith {
        _presetName = format ["SEN_%1_preset",(player getvariable ["SEN_team",""])];
        _data = [["channels"],[[["frequencyTX"],[[2001.75],[2002.75],[2003.75],[2004.75],[2005.75],[2006.75],[2007.75],[2008.75],[2009.75],[2010.75],[2011.75],[2012.75],[2013.75],[2014.75],[2015.75],[2016.75]]]]];

        [SEN_acre2_squadRadio,_presetName, _data] call acre_sys_data_fnc_registerRadioPreset;
        [SEN_acre2_squadRadio,_presetName] call acre_api_fnc_setDefaultChannels;
    };
    if (player getvariable ["SEN_team",""] isEqualTo "a" || player getvariable ["SEN_team",""] isEqualTo "a1" || player getvariable ["SEN_team",""] isEqualTo "a2") exitWith {
        _presetName = format ["SEN_%1_preset",(player getvariable ["SEN_team",""])];
        _data = [["channels"],[[["frequencyTX"],[[2101.75],[2102.75],[2103.75],[2104.75],[2105.75],[2106.75],[2107.75],[2108.75],[2109.75],[2110.75],[2111.75],[2112.75],[2113.75],[2114.75],[2115.75],[2116.75]]]]];

        [SEN_acre2_squadRadio,_presetName, _data] call acre_sys_data_fnc_registerRadioPreset;
        [SEN_acre2_squadRadio,_presetName] call acre_api_fnc_setDefaultChannels;
    };
    if (player getvariable ["SEN_team",""] isEqualTo "b" || player getvariable ["SEN_team",""] isEqualTo "b1" || player getvariable ["SEN_team",""] isEqualTo "b2") exitWith {
        _presetName = format ["SEN_%1_preset",(player getvariable ["SEN_team",""])];
        _data = [["channels"],[[["frequencyTX"],[[2201.75],[2202.75],[2203.75],[2204.75],[2205.75],[2206.75],[2207.75],[2208.75],[2209.75],[2210.75],[2211.75],[2212.75],[2213.75],[2214.75],[2215.75],[2216.75]]]]];

        [SEN_acre2_squadRadio,_presetName, _data] call acre_sys_data_fnc_registerRadioPreset;
        [SEN_acre2_squadRadio,_presetName] call acre_api_fnc_setDefaultChannels;
    };
    if (player getvariable ["SEN_team",""] isEqualTo "rh1") exitWith {
        _presetName = format ["SEN_%1_preset",(player getvariable ["SEN_team",""])];
        _data = [["channels"],[[["frequencyTX"],[[2301.75],[2302.75],[2303.75],[2304.75],[2305.75],[2306.75],[2307.75],[2308.75],[2309.75],[2310.75],[2311.75],[2312.75],[2313.75],[2314.75],[2315.75],[2316.75]]]]];

        [SEN_acre2_squadRadio,_presetName, _data] call acre_sys_data_fnc_registerRadioPreset;
        [SEN_acre2_squadRadio,_presetName] call acre_api_fnc_setDefaultChannels;
    };
    if (player getvariable ["SEN_team",""] isEqualTo "r") exitWith {
        _presetName = format ["SEN_%1_preset",(player getvariable ["SEN_team",""])];
        _data = [["channels"],[[["frequencyTX"],[[2401.75],[2402.75],[2403.75],[2404.75],[2405.75],[2406.75],[2407.75],[2408.75],[2409.75],[2410.75],[2411.75],[2412.75],[2413.75],[2414.75],[2415.75],[2416.75]]]]];

        [SEN_acre2_squadRadio,_presetName, _data] call acre_sys_data_fnc_registerRadioPreset;
        [SEN_acre2_squadRadio,_presetName] call acre_api_fnc_setDefaultChannels;
    };
};

// frequencies to be used for long range and support radios
_freqArray = [];

for "_i" from 0 to 99 do {
    _freq = 0;
    _freq = (500+(_i*2))*0.0625;
    _freqArray pushBack _freq;
};

// setup SEN_acre2_commandRadio preset data
call {
    if (SEN_acre2_commandRadio isEqualTo "ACRE_PRC148") exitWith {
        _channelArray = [];

        for "_i" from 0 to 31 do {
            private "_channelName";
            call {
                if (_i isEqualTo 0) exitWith {_channelName = "COMMAND"};
                if (_i isEqualTo 1) exitWith {_channelName = "SUPPORT"};

                _channelName = format ["CHAN %1", (_i + 1)];
            };

            _channelData = [5000,(_freqArray select _i),(_freqArray select _i),0,"BASIC",_channelName,250.3,250.3,"FM",16,1,0.2,2,256,3];
            _channelArray pushBack _channelData;
        };

        _data =
        [
            ["channels","groups"],
            [
                [
                    ["power","frequencyTX","frequencyRX","encryption","channelMode","label","CTCSSTx","CTCSSRx","modulation","trafficRate","TEK","RPTR","fade","phase","squelch"],
                    _channelArray
                ],
                [
                    ["G01",[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]],
                    ["G02",[16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]]
                ]
            ]
        ];
    };

    if (SEN_acre2_commandRadio isEqualTo "ACRE_PRC152") exitWith {
        _channelArray = [];

        for "_i" from 0 to 31 do {
            private "_channelName";
            call {
                if (_i isEqualTo 0) exitWith {_channelName = "COMMAND"};
                if (_i isEqualTo 1) exitWith {_channelName = "SUPPORT"};

                _channelName = format ["FMLOSVOC_%1", (_i + 1)];
            };

            _channelData = [(_freqArray select _i),(_freqArray select _i),5000,0,"BASIC",_channelName,250.3,250.3,"FM",1,16,256,3,8,201,false];
            _channelArray pushBack _channelData;
        };

        _data =
        [
            ["channels"],
            [
                [
                    ["frequencyTX","frequencyRX","power","encryption","channelMode","description","CTCSSTx","CTCSSRx","modulation","TEK","trafficRate","syncLength","squelch","deviation","optionCode","rxOnly"],
                    _channelArray
                ]
            ]
        ];
    };

    _data = [];

    [2,"SEN_acre2_commandRadio is an incorrect radio type."] call SEN_fnc_log;
};

[SEN_acre2_commandRadio,"SEN_commandRadio_preset", _data] call acre_sys_data_fnc_registerRadioPreset;
[SEN_acre2_commandRadio, "SEN_commandRadio_preset"] call acre_api_fnc_setDefaultChannels;

// setup SEN_acre2_supportRadio preset data
_channelArray = [];

for "_i" from 0 to 99 do {
    private "_channelName";
    call {
        if (_i isEqualTo 0) exitWith {_channelName = "COMMAND"};
        if (_i isEqualTo 1) exitWith {_channelName = "SUPPORT"};

        _channelName = format ["FMLOSVOC_%1", (_i + 1)];
    };

    _channelData = [(_freqArray select _i),(_freqArray select _i),5000,0,"BASIC",_channelName,250.3,250.3,"FM",1,16,256,3,8,201,false,true];
    _channelArray pushBack _channelData;
};

_data =
[
    ["channels"],
    [
        [
            ["frequencyTX","frequencyRX","power","encryption","channelMode","name","CTCSSTx","CTCSSRx","modulation","TEK","trafficRate","syncLength","squelch","deviation","optionCode","rxOnly","active"],
            _channelArray
        ]
    ]
];

[SEN_acre2_supportRadio,"SEN_supportRadio_preset", _data] call acre_sys_data_fnc_registerRadioPreset;
[SEN_acre2_supportRadio, "SEN_supportRadio_preset"] call acre_api_fnc_setDefaultChannels;
*/
