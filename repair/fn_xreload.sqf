private ["_maxDistance", "_text", "_posObject", "_config", "_count", "_magazines", "_type", "_type_name"];
_endMsg = "Servicing finished";
_maxDistance = 0.5;
params ["_object"0];
_posObject = getPos _object;
_type = typeOf _object;
_type_name = getText(configFile >> "CfgVehicles" >> _type >> "displayName");
_object setVariable ["JK_MagazineReloading", nil, false];
if (_object isKindOf "ParachuteBase") exitWith {};
if (_object isKindOf "Man") exitWith {};

if (isNil "x_reload_time_factor") then {x_reload_time_factor = 1;};

if (!local _object) exitWith {};

if (!alive _object || !((_posObject distance (getPos _object)) < _maxDistance)) exitWith {};
_object setVehicleAmmo 1;    // Reload turrets / drivers magazine

[_object] call JK_repair_fnc_uiVehicleStatus;

_magazines = getArray(configFile >> "CfgVehicles" >> _type >> "magazines");
if (count _magazines > 0) then {
    _removed = [];
    {
        _object setVariable ["JK_MagazineReloading", getText(configFile >> "CfgMagazines" >> _x >> "displayName"), false];
        if (!(_x in _removed)) then {
            _object removeMagazines _x;
            _removed pushback _x;
        };
        [_object] call JK_repair_fnc_uiVehicleStatus;
        false
    } count _magazines;
    {
        _object setVariable ["JK_MagazineReloading", getText(configFile >> "CfgMagazines" >> _x >> "displayName"), false];
        [_object] call JK_repair_fnc_uiVehicleStatus;
        sleep x_reload_time_factor;
        if (!alive _object || !((_posObject distance (getPos _object)) < _maxDistance)) exitWith {_endMsg = "Servicing cancelled";};
        _object addMagazine _x;
        false
    } count _magazines;
};

_count = count (configFile >> "CfgVehicles" >> _type >> "Turrets");

if (_count > 0) then {
    for "_i" from 0 to (_count - 1) do {
        scopeName "xx_reload2_xx";
        _config = (configFile >> "CfgVehicles" >> _type >> "Turrets") select _i;
        _magazines = getArray(_config >> "magazines");
        _removed = [];
        {
            if (!(_x in _removed)) then {
                _object removeMagazines _x;
                _removed pushback  _x;
            };
            false
        } count _magazines;
        {
            //_object vehicleChat format ["Reloading %1", _x];
            _object setVariable ["JK_MagazineReloading", _x, false];
            //[_object] call JK_repair_fnc_uiVehicleStatus;
            sleep x_reload_time_factor;
            if (!alive _object || !((_posObject distance (getPos _object)) < _maxDistance)) exitWith {_endMsg = "Servicing cancelled";};
            _object addMagazine _x;
            sleep x_reload_time_factor;
            if (!alive _object || !((_posObject distance (getPos _object)) < _maxDistance)) exitWith {_endMsg = "Servicing cancelled";};
            false
        } count _magazines;
        // check if the main turret has other turrets
        _count_other = count (_config >> "Turrets");
        // this code doesn't work, it's not possible to load turrets that are part of another turret :(
        // nevertheless, I leave it here
        if (_count_other > 0) then {
            for "_i" from 0 to (_count_other - 1) do {
                _config2 = (_config >> "Turrets") select _i;
                _magazines = getArray(_config2 >> "magazines");
                _removed = [];
                {
                    if (!(_x in _removed)) then {
                        _object removeMagazines _x;
                        _removed pushback _x;
                    };
                    false
                } count _magazines;
                {
                    //_object vehicleChat format ["Reloading %1", _x];
                    _object setVariable ["JK_MagazineReloading", _x, false];
                    //[_object] call JK_repair_fnc_uiVehicleStatus;
                    sleep x_reload_time_factor;
                    if (!alive _object || !((_posObject distance (getPos _object)) < _maxDistance)) exitWith {_endMsg = "Servicing cancelled";};
                    _object addMagazine _x;
                    sleep x_reload_time_factor;
                    if (!alive _object || !((_posObject distance (getPos _object)) < _maxDistance)) exitWith {_endMsg = "Servicing cancelled";};
                    false
                } count _magazines;
            };
        };
    };
};
_object setVehicleAmmo 1;    // Reload turrets / drivers magazine

sleep x_reload_time_factor;

while {(fuel _object < 0.99 || damage _object > 0.001) } do {
    //feedback
    [_object] call JK_repair_fnc_uiVehicleStatus;
    //doing work
    if (!alive _object || !((_posObject distance (getPos _object)) < _maxDistance)) exitWith {_endMsg = "Servicing cancelled";};
    _object setFuel (((fuel _object) + 0.005) min 1);
    _object setDamage (((damage _object) - 0.005) max 0);
    sleep 0.1;
    if (!alive _object || !((_posObject distance (getPos _object)) < _maxDistance)) exitWith {_endMsg = "Servicing cancelled";};
};

[_object, _endMsg] call JK_repair_fnc_uiVehicleStatus;
