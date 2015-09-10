/*
Author: SENSEI

Last modified: 7/18/2015

Description:  assigns acre radio

			returns nothing
__________________________________________________________________*/
private ["_backpack","_role","_radioInInv"];

_backpack = "B_Kitbag_cbr";
_role = roleDescription player;
_radioInInv = [];

if ([player] call acre_api_fnc_hasRadio) then {
	{ player removeItem _x } forEach ([] call acre_api_fnc_getCurrentRadioList);
};

call {
	if (player getvariable ["SEN_commNet",""] isEqualTo "command") exitWith {
		if (player canAdd SEN_acre2_squadRadio) then {
			player addItem SEN_acre2_squadRadio;
		} else {
			if ((backpack player) isEqualTo "") then {
				player addBackpack _backpack;
				player addItem SEN_acre2_squadRadio;
			};
		};

		if (player canAdd SEN_acre2_commandRadio) then {
			player addItem SEN_acre2_commandRadio;
		} else {
			if ((backpack player) isEqualTo "") then {
				player addBackpack _backpack;
				player addItem SEN_acre2_commandRadio;
			};
		};

		waitUntil {([] call acre_api_fnc_isInitialized)};

		call {
			{_radioInInv pushBack ([_x] call acre_api_fnc_getBaseRadio)} forEach ([] call acre_api_fnc_getCurrentRadioList);

			if (count _radioInInv isEqualTo 0) exitWith {hintSilent "Cannot add ACRE2 radios to inventory\nComm Net Access: NONE"};
			if (SEN_acre2_squadRadio in _radioInInv && {SEN_acre2_commandRadio in _radioInInv}) exitWith {hintSilent format ["%3:\nAdded ACRE2 radios to inventory:\n%1\n%2\nComm Net Access: COMMAND, SQUAD",SEN_acre2_commandRadio,SEN_acre2_squadRadio,_role];};
			if (SEN_acre2_squadRadio in _radioInInv && {!(SEN_acre2_commandRadio in _radioInInv)}) exitWith {hintSilent format ["%2:\nAdded ACRE2 radios to inventory:\n%1\nComm Net Access: SQUAD",SEN_acre2_squadRadio,_role];};
			if (!(SEN_acre2_squadRadio in _radioInInv) && {SEN_acre2_commandRadio in _radioInInv}) exitWith {hintSilent format ["%2:\nAdded ACRE2 radios to inventory:\n%1\nComm Net Access: COMMAND",SEN_acre2_commandRadio,_role];};
		};
	};

	if (player getvariable ["SEN_commNet",""] isEqualTo "support") exitWith {
		if (player canAdd SEN_acre2_squadRadio) then {
			player addItem SEN_acre2_squadRadio;
		} else {
			if ((backpack player) isEqualTo "") then {
				player addBackpack _backpack;
				player addItem SEN_acre2_squadRadio;
			};
		};

		if (player canAdd SEN_acre2_supportRadio) then {
			player addItem SEN_acre2_supportRadio;
		} else {
			if ((backpack player) isEqualTo "") then {
				player addBackpack _backpack;
				player addItem SEN_acre2_supportRadio;
			};
		};

		waitUntil {([] call acre_api_fnc_isInitialized)};

		call {
			{_radioInInv pushBack ([_x] call acre_api_fnc_getBaseRadio)} forEach ([] call acre_api_fnc_getCurrentRadioList);

			if (count _radioInInv isEqualTo 0) exitWith {hintSilent "Cannot add ACRE2 radios to inventory\nComm Net Access: NONE"};
			if (SEN_acre2_squadRadio in _radioInInv && {SEN_acre2_supportRadio in _radioInInv}) exitWith {hintSilent format ["%3:\nAdded ACRE2 radios to inventory:\n%1\n%2\nComm Net Access: SUPPORT, SQUAD",SEN_acre2_supportRadio,SEN_acre2_squadRadio,_role];};
			if (SEN_acre2_squadRadio in _radioInInv && {!(SEN_acre2_supportRadio in _radioInInv)}) exitWith {hintSilent format ["%2:\nAdded ACRE2 radios to inventory:\n%1\nComm Net Access: SQUAD",SEN_acre2_squadRadio,_role];};
			if (!(SEN_acre2_squadRadio in _radioInInv) && {SEN_acre2_supportRadio in _radioInInv}) exitWith {hintSilent format ["%2:\nAdded ACRE2 radios to inventory:\n%1\nComm Net Access: SUPPORT",SEN_acre2_supportRadio,_role];};
		};
	};

	if (player getvariable ["SEN_commNet",""] isEqualTo "squad") exitWith {
		if (player canAdd SEN_acre2_squadRadio) then {
			player addItem SEN_acre2_squadRadio;
		} else {
			if ((backpack player) isEqualTo "") then {
				player addBackpack _backpack;
				player addItem SEN_acre2_squadRadio;
			};
		};

		waitUntil {([] call acre_api_fnc_isInitialized)};

		call {
			{_radioInInv pushBack ([_x] call acre_api_fnc_getBaseRadio)} forEach ([] call acre_api_fnc_getCurrentRadioList);

			if (count _radioInInv isEqualTo 0) exitWith {hintSilent "Cannot add ACRE2 radios to inventory\nComm Net Access: NONE"};
			hintSilent format ["%2:\nACRE2: Added radios to inventory:\n%1\nComm Net Access: SQUAD",SEN_acre2_squadRadio,_role];
		};
	};
};

// set channels

// waitUntil {([] call acre_api_fnc_isInitialized)};

if (player getvariable ["SEN_commNet",""] isEqualTo "command") then {
	[([SEN_acre2_commandRadio] call acre_api_fnc_getRadioByType), 1] call acre_api_fnc_setRadioChannel;
};
if (player getvariable ["SEN_commNet",""] isEqualTo "support") then {
	[([SEN_acre2_supportRadio] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel;
};
if (player getvariable ["SEN_team",""] isEqualTo "plt") exitWith {
	[([SEN_acre2_squadRadio] call acre_api_fnc_getRadioByType), 1] call acre_api_fnc_setRadioChannel;
};
if (player getvariable ["SEN_team",""] isEqualTo "a" || {player getvariable ["SEN_team",""] isEqualTo "a1"} || {player getvariable ["SEN_team",""] isEqualTo "a2"}) exitWith {
	[([SEN_acre2_squadRadio] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel;
};
if (player getvariable ["SEN_team",""] isEqualTo "b" || {player getvariable ["SEN_team",""] isEqualTo "b1"} || {player getvariable ["SEN_team",""] isEqualTo "b2"}) exitWith {
	[([SEN_acre2_squadRadio] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel;
};
if (player getvariable ["SEN_team",""] isEqualTo "rh1") exitWith {
	[([SEN_acre2_squadRadio] call acre_api_fnc_getRadioByType), 4] call acre_api_fnc_setRadioChannel;
};
if (player getvariable ["SEN_team",""] isEqualTo "r") exitWith {
	[([SEN_acre2_squadRadio] call acre_api_fnc_getRadioByType), 5] call acre_api_fnc_setRadioChannel;
};