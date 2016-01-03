params ["_unit"];

private _typeOf = typeOf _unit;
if !(_typeOf in JK_ins_types) exitWith {};
private _uniform = JK_ins_Uniform call BIS_fnc_selectRandom;
private _vest = JK_ins_Vests call BIS_fnc_selectRandom;
private _headgear = JK_ins_HeadGear call BIS_fnc_selectRandom;
private _backpack = "";
private _weapon = "";
private _weaponBack = "";

switch (_typeOf) do {
    case "AW_ins_AT": {
        _backpack = "CUP_B_RPGPack_Khaki";
        _weaponBack = JK_ins_AT_weapons call BIS_fnc_selectRandom;
        _weapon = JK_ins_RF_weapons call BIS_fnc_selectRandom;
    };
    case "AW_ins_MG": {
        _backpack = JK_ins_Backpacks call BIS_fnc_selectRandom;
        _weapon = JK_ins_MG_weapons call BIS_fnc_selectRandom;
    };
    case "AW_ins_GL": {
        _weapon = JK_ins_GL_weapons call BIS_fnc_selectRandom;
    };
    case "AW_ins_RF": {
        _weapon = JK_ins_RF_weapons call BIS_fnc_selectRandom;
    };
    case "AW_ins_AR": {
        _weapon = JK_ins_AR_weapons call BIS_fnc_selectRandom;
    };
};

_unit forceAddUniform _uniform;
_unit addVest _vest;
_unit addHeadgear _headgear;
if !(_backpack isEqualTo "") then {
    _unit addBackpack _backpack;
};

[_unit, _weapon, 5] call BIS_fnc_addWeapon;
if !(_weaponBack isEqualTo "") then {
    [_unit, _weaponBack, 2] call BIS_fnc_addWeapon;
};
