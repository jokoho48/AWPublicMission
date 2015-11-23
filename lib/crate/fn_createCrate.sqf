private "_crate";
if (!(JK_ammoSuppAvail)) exitWith {
    hint "Supply Crate is not currently available"
};

JK_ammoSuppAvail = false;
publicVariable "JK_ammoSuppAvail";
params ["_args", "_marker"];
_args params ["_crateType", ["_reloadTime", 20], "_content"];

_position = ((getMarkerPos _marker) findEmptyPosition [0, 10]);
if (_position isEqualTo []) exitWith {hint "No Space to create the Crate."};
_crateObject = _crateType createVehicle _position;

_crateObject hideObjectGlobal true;

if (!isNil "_content") then {
    _crateObject setVariable ["SEN_noClean", true, true];
    clearWeaponCargoGlobal _crateObject;
    clearMagazineCargoGlobal _crateObject;
    clearItemCargoGlobal _crateObject;
    clearBackpackCargoGlobal _crateObject;
    {
        call {
            if ((_x select 0) isKindOf ["ItemCore", configFile >> "CfgWeapons"]) exitWith {
                _crateObject addItemCargoGlobal _x;
            };

            if (isClass(configFile >> "CfgMagazines" >> (_x select 0))) exitWith {
                _crateObject addMagazineCargoGlobal _x;
            };

            if ((_x select 0) isKindOf "Bag_Base") exitWith {
                _crateObject addBackpackCargoGlobal _x;
            };

            if (isClass(configFile >> "CfgWeapons" >> (_x select 0))) exitWith {
                _crateObject addWeaponCargoGlobal _x;
            };
        };
        nil
    } count _content;
    _crateObject hideObjectGlobal false;
};

[{
    JK_ammoSuppAvail = true;
    publicVariable "JK_ammoSuppAvail";
}, [], _reloadTime] call ace_common_fnc_waitAndExecute;

[[[_crateObject, _content], {
    params ["_crateObject", "_content"];
    _crateObject addAction ["<t color='#FF0000'>Delete Crate</t>", { deleteVehicle (_this select 0); JK_ammoSuppAvail = true; publicVariable "JK_ammoSuppAvail";}];
}], "BIS_fnc_call", true, false, true] call BIS_fnc_MP;
