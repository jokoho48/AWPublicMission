params ["_vehicles", ["_deleteVehicles", true]];

{
    if (_deleteVehicles) then { deleteVehicle (vehicle _x); } else{ moveOut _x; };
    deleteVehicle _x;
    true
} count _vehicles;

[] spawn QS_fnc_cleanGroups;
