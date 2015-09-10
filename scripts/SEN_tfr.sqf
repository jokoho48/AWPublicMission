/*
Author: SENSEI

Last modified: 8/5/2015

Description: TFAR clientside settings

        NOTE: created with TFAR 0.9.8 / TS 3.0.16
__________________________________________________________________*/
waitUntil {sleep 0.1; !isNil "SEN_tfr_sw"};
// channels are zero based!! _tfr_ch_plt = 0 means Platoon team is on ch 1
// channels are zero based!! _tfr_ch_plt = 0 means Platoon team is on ch 1

// COMMAND Net
_tfr_ch_command = 5;

// SUPPORT Net
_tfr_ch_support = 6; // LR

// SQUAD Net
_tfr_ch_plt = 0;
_tfr_ch_a = 1;
_tfr_ch_b = 2;
_tfr_ch_rh1 = 3;
_tfr_ch_r = 4;

_default_add = -1;

// set defaults
// SEN_tfr_ch_sw = squad/team ch on short wave radio
// ex. All members of Alpha squad are on ch 2 by default

// SEN_tfr_add_sw = additional ch for short wave radio depending on comm net
// ex. plt_co is part of COMMAND Net, so additional ch is 6 by default

// SEN_tfr_ch_lr = long range radio default ch.
// players on SUPPORT Net are given LR radios by default

call {
    if (player getvariable ["SEN_team",""] isEqualTo "plt") exitWith {
        if (player getvariable ["SEN_commNet",""] isEqualTo "command") then {
            SEN_tfr_ch_sw = _tfr_ch_plt;
            SEN_tfr_add_sw = _tfr_ch_command;
        } else {
            SEN_tfr_ch_sw = _tfr_ch_plt;
            SEN_tfr_add_sw = _default_add;
        };
        SEN_tfr_ch_lr = _tfr_ch_support;
    };
    if (player getvariable ["SEN_team",""] isEqualTo "a" || {player getvariable ["SEN_team",""] isEqualTo "a1"} || {player getvariable ["SEN_team",""] isEqualTo "a2"}) exitWith {
        if (player getvariable ["SEN_commNet",""] isEqualTo "command") then {
            SEN_tfr_ch_sw = _tfr_ch_a;
            SEN_tfr_add_sw = _tfr_ch_command;
        } else {
            SEN_tfr_ch_sw = _tfr_ch_a;
            SEN_tfr_add_sw = _default_add;
        };
        SEN_tfr_ch_lr = _tfr_ch_support;
    };
    if (player getvariable ["SEN_team",""] isEqualTo "b" || {player getvariable ["SEN_team",""] isEqualTo "b1"} || {player getvariable ["SEN_team",""] isEqualTo "b2"}) exitWith {
        if (player getvariable ["SEN_commNet",""] isEqualTo "command") then {
            SEN_tfr_ch_sw = _tfr_ch_b;
            SEN_tfr_add_sw = _tfr_ch_command;
        } else {
            SEN_tfr_ch_sw = _tfr_ch_b;
            SEN_tfr_add_sw = _default_add;
        };
        SEN_tfr_ch_lr = _tfr_ch_support;
    };
    if (player getvariable ["SEN_team",""] isEqualTo "rh1") exitWith {
        SEN_tfr_ch_sw = _tfr_ch_rh1;
        SEN_tfr_add_sw = _default_add;
        SEN_tfr_ch_lr = _tfr_ch_support;
    };
    if (player getvariable ["SEN_team",""] isEqualTo "r") exitWith {
        SEN_tfr_ch_sw = _tfr_ch_r;
        SEN_tfr_add_sw = _default_add;
        SEN_tfr_ch_lr = _tfr_ch_support;
    };
};
call SEN_fnc_setTfrRadio;
