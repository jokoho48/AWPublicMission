//Only display vehicles for that players side, if true Opfor can only spawn Opfor vehicles and so on.
VVS_SideOnly = true;
VVS_Checkbox = true;

//Only set to true if you are making pre-made vehicle lists with VVS_x (i.e VVS_Car)
//If you are going to use Pre-set VVS Vehicles it is recommended to set this to true as it will not run through the config saving CPU resources on initialization, otherwise leave as default.
VVS_Premade_List = false;

/*
    *SENSEI EDIT*
                                    Addon Vehicles
        If your desired vehicles are not automatically fetched, place the classnames in the arrays below.
        Be sure to not place vanilla classnames in these arrays, only 3rd party content.

        Example:
        VVS_Air = ["B_mas_UH1Y_F", "B_mas_CH_47F"];
*/
VVS_Car = [];
VVS_Air = [];
VVS_Ship = [];
VVS_Armored = [];
VVS_Submarine = [];
VVS_Autonomous = [];
VVS_Support = [];
VVS_Ammo = [];

/*
                                    Vehicle restriction
        Again, similar to VAS's functionality. If you want to restrict a specific vehicle you can do it or
        you can restrict an entire vehicle set by using its base class.

        Example:
        VVS_Car = ["Quadbike_01_base_F"]; //Completely removes all quadbikes for all sides
        VVS_Air = ["B_Heli_Light_01_armed_F"]; //Removes the Pawnee
*/
VVS_R_Car = [];
VVS_R_Air = [];
VVS_R_Ship = [];
VVS_R_Armored = [];
VVS_R_Submarine = [];
VVS_R_Autonomous = [];
VVS_R_Support = [];
VVS_R_Ammo = ["GunrackTK_EP1","GunrackUS_EP1","Gunrack1","Gunrack2"];

JK_VehicleTickets = [
    //["rhs_vehclass_apc", 300],
    ["rhs_vehclass_apc_wd", 300],
    //["rhs_vehclass_ifv", 300],
    ["rhs_vehclass_ifv_wd", 300],
    //["rhs_vehclass_car", 100],
    ["rhs_vehclass_car_wd", 100],
    //["rhs_vehclass_mrap", 150],
    ["rhs_vehclass_mrap_wd", 150],
    //["rhs_vehclass_truck", 50],
    ["rhs_vehclass_truck_wd", 50],
    //["rhs_vehclass_tank", 500],
    ["rhs_vehclass_tank_wd", 500],
    ["rhs_vehclass_aircraft", 1000],
    ["rhs_vehclass_helicopter", 200],
    ["rhs_vehclass_helicopter_wd", 200],
    ["Autonomous", 200],
    ["Default", 200]
];
