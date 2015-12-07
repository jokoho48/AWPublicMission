private ["_parameterCorrect", "_returnValue", "_cfg"];
_parameterCorrect = params [["_x",objNull,[objNull]],["_containerClassname","",["STRING"]],["_containerNumber", -1, [-1]]];
_returnValue = false;

if (_containerNumber == -1) then {
    _cfg = (configFile >> "CfgWeapons");
    if (_containerClassname isKindOf ["Uniform_Base", _cfg]) then {
        _containerNumber = 0;
    };
    if (_containerClassname isKindOf ["Vest_NoCamo_Base", _cfg] || _containerClassname isKindOf ["Vest_Camo_Base", _cfg]) then {
        _containerNumber = 1;
    };
    if (_containerClassname isKindOf "Bag_Base") then {
        _containerNumber = 2;
    };
};

_returnValue = true;
switch (_containerNumber) do {
    case 0 : {
        _uniformName = uniform _x;
        if(_containerClassname == _uniformName && _containerClassname != "") then {
            _uniform = uniformContainer _x;
            clearItemCargoGlobal _uniform;
            clearMagazineCargoGlobal _uniform;
            clearWeaponCargoGlobal _uniform;
        } else {
            removeUniform _x;
            _x forceAddUniform _containerClassname;
        };
    };
    case 1 : {
        _vestName = vest _x;
        if(_containerClassname == _vestName && _containerClassname != "") then {
            _vest = vestContainer _x;
            clearItemCargoGlobal _vest;
            clearMagazineCargoGlobal _vest;
            clearWeaponCargoGlobal _vest;
        } else {
            removeVest _x;
            _x addVest _containerClassname;
        };
    };
    case 2 : {
        _backpackName = backpack _x;
        if(_containerClassname == _backpackName && _containerClassname != "") then {
            _backpack = backpackContainer _x;
            clearItemCargoGlobal _backpack;
            clearMagazineCargoGlobal _backpack;
            clearWeaponCargoGlobal _backpack;
        } else {
            removeBackpack _x;
            _x addBackpack _containerClassname;
        };
    };
    default {
        _returnValue = false;
    };
};
_returnValue
