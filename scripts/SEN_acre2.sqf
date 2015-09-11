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
