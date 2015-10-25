// TFR mod configuration
#include "\task_force_radio\functions\common.sqf";

tf_give_personal_radio_to_regular_soldier = true;
tf_no_auto_long_range_radio = true;
tf_give_microdagr_to_soldier = false;
tf_same_sw_frequencies_for_side = true;
tf_same_lr_frequencies_for_side = true;
tf_default_radioVolume = 4;

//radios
BLU_F_personal_tf_faction_radio = "tf_anprc152";
BLU_G_F_personal_tf_faction_radio = "tf_anprc148jem";
BLU_F_rifleman_tf_faction_radio = "tf_rf7800str";
BLU_G_F_rifleman_tf_faction_radio = "tf_anprc154";

IND_F_personal_tf_faction_radio = "tf_anprc148jem";
IND_F_rifleman_tf_faction_radio = "tf_anprc154";

OPF_F_personal_tf_faction_radio = "tf_fadak";
OPF_F_rifleman_tf_faction_radio = "tf_pnr1000a";

// TS Channel Stuff
tf_radio_channel_name = "LaufendeMission";
tf_radio_channel_password = "armaworld";

if(hasInterface) then {
    private ["_swFreq","_swRadio","_lrFreq","_lrRadio"];
    _swFreq = ["110", "120", "130", "140", "150", "160", "100", "30"];
    if(call TFAR_fnc_haveSWRadio) then {
        _swFreq resize (count _swFreq min 8);
        _swRadio = call TFAR_fnc_activeSwRadio;
        {
            [_swRadio, (_forEachIndex + 1), _x] call TFAR_fnc_SetChannelFrequency;
        } foreach _swFreq;
    };

    _lrFreq = ["30", "31", "32", "33", "34", "35", "36", "37", "38"];
    if(call TFAR_fnc_haveLRRadio) then {
        _lrFreq resize (count _lrFreq min 9);
        _lrRadio = call TFAR_fnc_activeLrRadio;
        {
            [_lrRadio, (_forEachIndex + 1), _x] call TFAR_fnc_SetChannelFrequency;
        } foreach _lrFreq;
    };
};
