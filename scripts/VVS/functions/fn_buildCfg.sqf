/*
    File: fn_buildCfg.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Builds our configuration arrays for vehicles to display.

    0: classname
    1: scope
    2: picture
    3: displayname
    4: vehicleclass
    5: side
    6: faction
*/

if !(JK_buildNotDone) exitWith {};
if (JK_vvsArray isEqualTo []) exitWith {};
//Setup our final arrays.
VVS_pre_Ship = [];
VVS_pre_Submarine = [];
VVS_pre_Car = [];
VVS_pre_Air = [];
VVS_pre_Armored = [];
VVS_pre_Autonomous = [];
VVS_pre_Support = [];

VVS_R_Vehicles = [];
VVS_R_Vehicles append VVS_R_Car;
VVS_R_Vehicles append VVS_R_Air;
VVS_R_Vehicles append VVS_R_Ship;
VVS_R_Vehicles append VVS_R_Submarine;
VVS_R_Vehicles append VVS_R_Armored;
VVS_R_Vehicles append VVS_R_Autonomous;
VVS_R_Vehicles append VVS_R_Support;
VVS_R_Vehicles append VVS_R_Ammo;

call {
    private "_Cfg";
    _Cfg = configFile >> "CfgVehicles";
    for "_i" from 0 to (count _Cfg) - 1 do {
        private ["_class", "_className", "_cfgInfo"];
        _class = _Cfg select _i;
        if(isClass _class) then {
            _className = configName _class;
            if(_className != "") then {
                _cfgInfo = [_className] call VVS_fnc_cfgInfo;
                if(count _cfgInfo > 0) then {
                    _cfgInfo params ["", "_scope", "_picture", "_displayName", "_vehicleClass", "_side", "", "_superClass"];
                    if (_scope >= 2 && { _picture != ""} && {_displayName != ""}) then {
                        if ((_className in JK_vvsArray) || {(_superClass in JK_vvsArray)} || {(_vehicleClass in JK_vvsArray)}) then {
                            if (!(_vehicleClass in VVS_R_Vehicles) || {!(_className in VVS_R_Vehicles)} || {!(_superClass in VVS_R_Vehicles)}) then {
                                call {
                                    if (_vehicleClass in ["rhs_vehclass_car", "rhs_vehclass_car_wd", "rhs_vehclass_mrap", "rhs_vehclass_mrap_wd", "rhs_vehclass_truck", "rhs_vehclass_truck_wd"] || {_className in ["B_Quadbike_01_F", "rhsusf_rg33_m2_usmc_wd", "rhsusf_rg33_usmc_wd"]}) exitWith {VVS_pre_Car pushBack _className};
                                    if (_vehicleClass in ["rhs_vehclass_aircraft", "rhs_vehclass_helicopter", "rhs_vehclass_helicopter_wd"] || {_className in ["B_Heli_Light_01_F", "B_Heli_Light_01_armed_F", "B_Heli_Light_01_stripped_F"]}) exitWith {VVS_pre_Air pushBack _className};
                                    if (_vehicleClass in ["rhs_vehclass_apc", "rhs_vehclass_apc_wd", "rhs_vehclass_ifv", "rhs_vehclass_ifv_wd", "rhs_vehclass_tank", "rhs_vehclass_tank_wd"]) exitWith {VVS_pre_Armored pushBack _className};
                                    if (_vehicleClass isEqualTo "Autonomous") then {VVS_pre_Autonomous pushBack _className};
                                };
                            };
                        };
                    };
                };
            };
        };
        sleep 0.0000001;
    };
};
JK_buildNotDone = false;
