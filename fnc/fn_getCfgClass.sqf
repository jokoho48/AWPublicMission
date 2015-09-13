/*
Author: SENSEI

Last modified: 10/2/2014

Description: scans config classes based on passed string. removes unwanted classnames from final array

             NOTE: allowed strings: "ITEM","BACKPACK,"HELMET","VEST","UNIFORM","WEAPON","MAGAZINE","GLASSES"

             returns array of class names
__________________________________________________________________*/
private ["_cfg","_array","_class","_base","_master","_type","_category","_formatted","_display","_parentArray","_scope","_blacklist"];
params [["_category", "", [""]], ["_blacklist", [], [[]]]];

_array = [];
_formatted = toUpper _category;

switch (_formatted) do {
    case ("ITEM"):
    {
        _master = configFile >> "CfgWeapons";

        for "_i" from 0 to (count _master) - 1 do {
            _class = _master select _i;

            if (isClass _class) then {
                _name = configName _class;
                _type = getNumber (_class >> "type");
                _scope = getNumber (_class >> "scope");
                _display = gettext (_class >> "displayName");
                _parentArray = [_class,true] call BIS_fnc_returnParents;

                if ((_type isEqualTo 131072 || _type isEqualTo 4096) && {_display != ""} && {!("Uniform_Base" in _parentArray)} && {!("Vest_Camo_Base" in _parentArray)} && {!("Vest_NoCamo_Base" in _parentArray)} && {!("H_HelmetB" in _parentArray)} && {!("ItemRadio" in _parentArray)} && {_scope >= 2} && {!(_name in _blacklist)}) then {
                    _array pushBack _name;
                    /*[0,"fn_getCfgClass adding %1 to array.",_name] call SEN_fnc_log;*/
                };
            };
        };
    };

    case ("BACKPACK"):
    {
        _master = configFile >> "CfgVehicles";

        for "_i" from 0 to (count _master) - 1 do {
            _class = _master select _i;

            if (isClass _class) then {
                _name = configName _class;
                _type = getText (_class >> "vehicleClass");
                _scope = getNumber (_class >> "scope");
                _display = gettext (_class >> "displayName");

                if (_type isEqualTo "Backpacks" && {_display != ""} && {_scope >= 2} && {!(_name in _blacklist)}) then {
                    _array pushBack _name;
                    /*[0,"fn_getCfgClass adding %1 to array.",_name] call SEN_fnc_log;*/
                };
            };
        };
    };

    case ("HELMET"):
    {
        _master = configFile >> "CfgWeapons";

        for "_i" from 0 to (count _master) - 1 do {
            _class = _master select _i;

            if (isClass _class) then {
                _name = configName _class;
                _type = getNumber (_class >> "type");
                _scope = getNumber (_class >> "scope");
                _display = gettext (_class >> "displayName");
                _parentArray = [_class,true] call BIS_fnc_returnParents;

                if (_type isEqualTo 131072 && {_display != ""} && {("H_HelmetB" in _parentArray)} && {_scope >= 2} && {!(_name in _blacklist)}) then {
                    _array pushBack _name;
                    /*[0,"fn_getCfgClass adding %1 to array.",_name] call SEN_fnc_log;*/
                };
            };
        };
    };

    case ("VEST"):
    {
        _master = configFile >> "CfgWeapons";

        for "_i" from 0 to (count _master) - 1 do {
            _class = _master select _i;

            if (isClass _class) then {
                _name = configName _class;
                _type = getNumber (_class >> "type");
                _scope = getNumber (_class >> "scope");
                _display = gettext (_class >> "displayName");
                _parentArray = [_class,true] call BIS_fnc_returnParents;

                if (_type isEqualTo 131072 && {_display != ""} && {(("Vest_NoCamo_Base" in _parentArray) || ("Vest_Camo_Base" in _parentArray))} && {_scope >= 2} && {!(_name in _blacklist)}) then {
                    _array pushBack _name;
                    /*[0,"fn_getCfgClass adding %1 to array.",_name] call SEN_fnc_log;*/
                };
            };
        };
    };

    case ("UNIFORM"):
    {
        _master = configFile >> "CfgWeapons";

        for "_i" from 0 to (count _master) - 1 do {
            _class = _master select _i;

            if (isClass _class) then {
                _name = configName _class;
                _type = getNumber (_class >> "type");
                _scope = getNumber (_class >> "scope");
                _display = gettext (_class >> "displayName");
                _parentArray = [_class,true] call BIS_fnc_returnParents;

                if (_type isEqualTo 131072 && {_display != ""} && {("Uniform_Base" in _parentArray)} && {_scope >= 2} && {!(_name in _blacklist)}) then {
                    _array pushBack _name;
                    /*[0,"fn_getCfgClass adding %1 to array.",_name] call SEN_fnc_log;*/
                };
            };
        };
    };

    case ("WEAPON"):
    {
        _master = configFile >> "CfgWeapons";

        for "_i" from 0 to (count _master) - 1 do {
            _class = _master select _i;

            if (isClass _class) then {
                _name = configName _class;
                _type = getNumber (_class >> "type");
                _scope = getNumber (_class >> "scope");
                _display = gettext (_class >> "displayName");

                if (_type in [1,2,4,5] && {_display != ""} && {_scope >= 2} && {!(_name in _blacklist)}) then {
                    _array pushBack _name;
                    /*[0,"fn_getCfgClass adding %1 to array.",_name] call SEN_fnc_log;*/
                };
            };
        };
    };

    case ("MAGAZINE"):
    {
        _master = configFile >> "CfgMagazines";

        for "_i" from 0 to (count _master) - 1 do {
            _class = _master select _i;

            if (isClass _class) then {
                _name = configName _class;
                _scope = getNumber (_class >> "scope");
                _display = gettext (_class >> "displayName");

                if (_display != "" && {_scope >= 1} && {!(_name in _blacklist)}) then {
                    _array pushBack _name;
                    /*[0,"fn_getCfgClass adding %1 to array.",_name] call SEN_fnc_log;*/
                };
            };
        };
    };

    case ("GLASSES"):
    {
        _master = configFile >> "CfgGlasses";

        for "_i" from 0 to (count _master) - 1 do {
            _class = _master select _i;

            if (isClass _class) then {
                _name = configName _class;
                _scope = getNumber (_class >> "scope");
                _display = gettext (_class >> "displayName");

                if (_display != "" && {_scope >= 2} && {!(_name in _blacklist)}) then {
                    _array pushBack _name;
                    /*[0,"fn_getCfgClass adding %1 to array.",_name] call SEN_fnc_log;*/
                };
            };
        };
    };
    default { [2,"Unknown string passed to fn_getCfgClass."] call SEN_fnc_log };
};

_array
