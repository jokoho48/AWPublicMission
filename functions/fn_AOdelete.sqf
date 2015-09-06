params ["_unitsArray"];
private ["_obj"];
{
    sleep 1;
    if (typeName _x == "GROUP") then {
        {
            if (vehicle _x != _x) then {
                deleteVehicle (vehicle _x);
            };
            deleteVehicle _x;
            nil
        } count (units _x);
    } else {
        if (vehicle _x != _x) then {
            deleteVehicle (vehicle _x);
        };
        if !(_x isKindOf "Man") then {
            {
                deleteVehicle _x;
                nil
            } count (crew _x)
        };
        deleteVehicle _x;
    };
    nil
} count _unitsArray;

sleep 1;

{

    if ((typeName _obj == "GROUP")) then {
        {
            if (!isNull _x) then { deleteVehicle _x; };
            nil
        } count (units _obj);
    } else {
        if (!isNull _obj) then { deleteVehicle _obj; };
    };
    nil
} count _unitArray;
