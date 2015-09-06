private ["_obj", "_isGroup"];
params ["_unitsArray"];

{
    if (typeName _obj == "GROUP") then {
        {
            if (!isNull _x) then { deleteVehicle _x; };
            nil
        } count (units _obj);
    } else {
        if (!isNull _obj) then { deleteVehicle _obj; };
    };
    nil
} count _unitsArray;
