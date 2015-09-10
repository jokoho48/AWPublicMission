/*
Author: SENSEI

Last modified: 8/5/2015

Description: TFAR settings

        NOTE: created with TFAR 0.9.8 / TS 3.0.16
__________________________________________________________________*/
if (!isServer) exitWith {};

// TFR mod configuration
#include "\task_force_radio\functions\common.sqf";

tf_give_personal_radio_to_regular_soldier = false;
publicVariable "tf_give_personal_radio_to_regular_soldier";
tf_no_auto_long_range_radio = true;
publicVariable "tf_no_auto_long_range_radio";
tf_give_microdagr_to_soldier = false;
publicVariable "tf_give_microdagr_to_soldier";
tf_same_sw_frequencies_for_side = true;
publicVariable "tf_same_sw_frequencies_for_side";
tf_same_lr_frequencies_for_side = true;
publicVariable "tf_same_lr_frequencies_for_side";
tf_default_radioVolume = 4;
publicVariable "tf_default_radioVolume";
SEN_tfr_rf = "tf_rf7800str"; // rifleman radio
publicVariable "SEN_tfr_rf";
SEN_tfr_sw = "tf_anprc152"; // shortwave radio
publicVariable "SEN_tfr_sw";
SEN_tfr_lr = "tf_rt1523g_big"; // long range radio
publicVariable "SEN_tfr_lr";
