params ["_unit"];

private _typeOf = typeOf _unit;
if !(_typeOf in JK_ins_types) exitWith {};
private _uniform = selectRandom JK_ins_Uniform;
private _vest = selectRandom JK_ins_Vests;
private _headgear = selectRandom JK_ins_HeadGear;
private _backpack = "";
private _weapon = "";
private _weaponBack = "";

switch (_typeOf) do {
    case "AW_ins_AT": {
        _backpack = "CUP_B_RPGPack_Khaki";
        _weaponBack = selectRandom JK_ins_AT_weapons;
        _weapon = selectRandom JK_ins_RF_weapons;
    };
    case "AW_ins_MG": {
        _backpack = selectRandom JK_ins_Backpacks;
        _weapon = selectRandom JK_ins_MG_weapons;
    };
    case "AW_ins_GL": {
        _weapon = selectRandom JK_ins_GL_weapons;
    };
    case "AW_ins_RF": {
        _weapon = selectRandom JK_ins_RF_weapons;
    };
    case "AW_ins_AR": {
        _weapon = selectRandom JK_ins_AR_weapons;
    };
    case "AW_ins_MK": {
        _weapon = selectRandom JK_ins_MK_weapons;
    };
};
removeUniform _unit;
removeVest _unit;
removeHeadgear _unit;
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
