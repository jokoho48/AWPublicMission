/*
Author: SENSEI

Last modified: 7/22/2015

Description:  assigns TFAR radio and channels

        returns nothing
__________________________________________________________________*/
private ["_role","_radios","_bItems"];

// remove any radios in inventory
_radios = player call TFAR_fnc_radiosList;
{player unlinkItem _x} forEach _radios;

_role = roleDescription player;
// if player on COMMAND Net - assign radio, set short wave channel (team ch) and set short wave additional channel (command ch)
if (player getvariable ["SEN_commNet",""] isEqualTo "command") exitWith {
    player linkItem SEN_tfr_sw;
    waitUntil {sleep 0.1; count (player call TFAR_fnc_radiosList) > 0};
    [(call TFAR_fnc_activeSwRadio), SEN_tfr_ch_sw] call TFAR_fnc_setSwChannel;
    [(call TFAR_fnc_activeSwRadio), SEN_tfr_add_sw] call TFAR_fnc_setAdditionalSwChannel;
    [(call TFAR_fnc_ActiveSWRadio), tf_default_radioVolume] call TFAR_fnc_setSwVolume;
    hintSilent format["%1:\nYou have access to COMMAND and SQUAD communications network.",_role];
};

if (player getvariable ["SEN_commNet",""] isEqualTo "support") exitWith {
    player linkItem SEN_tfr_sw;
    waitUntil {sleep 0.1; count (player call TFAR_fnc_radiosList) > 0};
    [(call TFAR_fnc_activeSwRadio), SEN_tfr_ch_sw] call TFAR_fnc_setSwChannel;
    [(call TFAR_fnc_activeSwRadio), SEN_tfr_add_sw] call TFAR_fnc_setAdditionalSwChannel;
    _bItems = backpackItems player;
    removeBackpack player;
    player addbackpack SEN_tfr_lr;
    {player addItemToBackpack _x} forEach _bItems;
    [(call TFAR_fnc_activeLrRadio) select 0, (call TFAR_fnc_activeLrRadio) select 1, SEN_tfr_ch_lr] call TFAR_fnc_setLrChannel;
    [(call TFAR_fnc_ActiveSWRadio), tf_default_radioVolume] call TFAR_fnc_setSwVolume;
    [(call TFAR_fnc_activeLrRadio) select 0, (call TFAR_fnc_activeLrRadio) select 1, tf_default_radioVolume] call TFAR_fnc_setLrVolume;
    hintSilent format["%1:\nYou have access to SUPPORT and SQUAD communications network.",_role];
};

if (player getvariable ["SEN_commNet",""] isEqualTo "squad") exitWith {
    player linkItem SEN_tfr_sw;
    waitUntil {sleep 0.1; count (player call TFAR_fnc_radiosList) > 0};
    [(call TFAR_fnc_activeSwRadio), SEN_tfr_ch_sw] call TFAR_fnc_setSwChannel;
    [(call TFAR_fnc_activeSwRadio), SEN_tfr_add_sw] call TFAR_fnc_setAdditionalSwChannel;
    [(call TFAR_fnc_ActiveSWRadio), tf_default_radioVolume] call TFAR_fnc_setSwVolume;
    hintSilent format["%1:\nYou have access to SQUAD communications network.",_role];
};
