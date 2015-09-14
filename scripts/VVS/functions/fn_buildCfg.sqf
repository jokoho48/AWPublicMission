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
private["_CfgCar","_CfgAir","_CfgShip","_CfgSub","_CfgArmor"];
_Cfg = configFile >> "CfgVehicles";


//Setup our final arrays.
VVS_pre_Car = [];
VVS_pre_Air = [];
VVS_pre_Ship = [];
VVS_pre_Armored = [];
VVS_pre_Submarine = [];
VVS_pre_Autonomous = [];
VVS_pre_Support = [];
VVS_pre_Ammo = [];

//Skim over and make sure VVS_x isn't built for a pre-made vehicle list.
/*if(count VVS_Car > 0) then {VVS_pre_Car = VVS_Car;};
if(count VVS_Air > 0) then {VVS_pre_Car = VVS_Air;};
if(count VVS_Ship > 0) then {VVS_pre_Car = VVS_Ship;};
if(count VVS_Submarine > 0) then {VVS_pre_Car = VVS_Submarine;};
if(count VVS_Armored > 0) then {VVS_pre_Car = VVS_Armored;};
if(count VVS_Autonomous > 0) then {VVS_pre_Autonomous = VVS_Autonomous;};
if(count VVS_Support > 0) then {VVS_pre_Support = VVS_Support;};
if(count VVS_Ammo > 0) then {VVS_pre_Ammo = VVS_Ammo;};*/

//if(VVS_Premade_List) exitWith {}; //No need to waste CPU processing time as the mission designer already setup a list.

for "_i" from 0 to (count _Cfg)-1 do
{
    _class = _Cfg select _i;
    if(isClass _class) then
    {
        _className = configName _class;
        if(_className != "") then
        {
        //    systemChat _className;
            _cfgInfo = [_className] call VVS_fnc_cfgInfo;
            //systemChat str(_cfgInfo);
            if(count _cfgInfo > 0) then
            {
                _cfgInfo params ["", "_scope", "_picture", "_displayName", "_vehicleClass", "_side", "", "_superClass"];
                if (
                _scope >= 2
                && {_picture != ""}
                && {_displayName != ""}
                && {_vehicleClass in ["rhs_vehclass_apc","rhs_vehclass_apc_wd","rhs_vehclass_ifv","rhs_vehclass_ifv_wd","rhs_vehclass_car","rhs_vehclass_car_wd","rhs_vehclass_mrap","rhs_vehclass_mrap_wd","rhs_vehclass_truck","rhs_vehclass_truck_d","rhs_vehclass_truck_wd","rhs_vehclass_tank","rhs_vehclass_tank_wd","rhs_vehclass_aircraft","rhs_vehclass_helicopter","rhs_vehclass_helicopter_wd"]}
                && {!(_className in VVS_R_Car)} && {!(_superClass in VVS_R_Car)}
                && {!(_className in VVS_R_Air)} && {!(_superClass in VVS_R_Air)}
                && {!(_className in VVS_R_Ship)} && {!(_superClass in VVS_R_Ship)}
                && {!(_className in VVS_R_Submarine)} && {!(_superClass in VVS_R_Submarine)}
                && {!(_className in VVS_R_Armored)} && {!(_superClass in VVS_R_Armored)}
                && {!(_className in VVS_R_Autonomous)} && {!(_superClass in VVS_R_Autonomous)}
                && {!(_className in VVS_R_Support)} && {!(_superClass in VVS_R_Support)}
                && {!(_className in VVS_R_Ammo)} && {!(_superClass in VVS_R_Ammo)}
                ) then
                {
                    call {
                        if (_vehicleClass isEqualTo "rhs_vehclass_car" || {_vehicleClass isEqualTo "rhs_vehclass_car_wd"} || {_vehicleClass isEqualTo "rhs_vehclass_mrap"} || {_vehicleClass isEqualTo "rhs_vehclass_mrap_wd"} || {_vehicleClass isEqualTo "rhs_vehclass_truck"} || {_vehicleClass isEqualTo "rhs_vehclass_truck_d"} || {_vehicleClass isEqualTo "rhs_vehclass_truck_wd"}) exitWith {VVS_pre_Car pushBack _className};

                        if (_vehicleClass isEqualTo "rhs_vehclass_aircraft" || {_vehicleClass isEqualTo "rhs_vehclass_helicopter"} || {_vehicleClass isEqualTo "rhs_vehclass_helicopter_d"} || {_vehicleClass isEqualTo "rhs_vehclass_helicopter_wd"}) exitWith {VVS_pre_Air pushBack _className};

                        if (_vehicleClass isEqualTo "rhs_vehclass_apc" || {_vehicleClass isEqualTo "rhs_vehclass_apc_wd"} || {_vehicleClass isEqualTo "rhs_vehclass_ifv"} || {_vehicleClass isEqualTo "rhs_vehclass_ifv_wd"} || {_vehicleClass isEqualTo "rhs_vehclass_tank"} || {_vehicleClass isEqualTo "rhs_vehclass_tank_wd"} || {_vehicleClass isEqualTo "rhs_vehclass_artillery"}) exitWith {VVS_pre_Armored pushBack _className};
                        /*
                        if (_vehicleClass isEqualTo "Ship") exitWith {VVS_pre_Ship pushBack _className};

                        if (_vehicleClass isEqualTo "Submarine") exitWith {VVS_pre_Submarine pushBack _className};

                        if (_vehicleClass isEqualTo "Autonomous") exitWith {VVS_pre_Autonomous pushBack _className};

                        if (_vehicleClass isEqualTo "Support") exitWith {VVS_pre_Support pushBack _className};

                        if (_vehicleClass isEqualTo "Ammo") exitWith {VVS_pre_Ammo pushBack _className};
                        */
                    };
                };
            };
        };
    };
};
