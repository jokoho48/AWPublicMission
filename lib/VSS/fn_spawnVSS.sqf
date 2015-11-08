/*
 * Author: joko // Jonas, SENSEI, Tonic
 * Add Action for Selling Vehicles
 *
 * Arguments:
 * 0: Classname <String>
 * 1: Vehicle Costs <Number>
 * 2: Spawn Postion <Array>
 *    0: Postion X
 *    1: Postion Y
 *    2: Postion Z
 * 3: Direction <Number>
 *
 * Return Value:
 * None
 */
if !(isServer) exitWith {};

private "_vehicle";

params [["_className", "", [""]], ["_costs", 0,[0]], ["_position", [0, 0, 0], [[]]], ["_direction", 0, [0]]];

if (0 != count (nearestObjects [_position,["landVehicle","Air","Ship","ReammoBox_F"],(7 max (ceil(sizeOf _className)))])) exitWith {
    hint format ["Fail to spawn %1, not Enoth space.", _className];
};

JK_TicketSystem = JK_TicketSystem - _costs;
publicVariable "JK_TicketSystem";

uiSleep 0.1;
_position set [2,0.5];

_vehicle = _className createVehicle _position;

_vehicle allowDamage false;
_vehicle setDir _direction;
if !(surfaceIsWater _position) then {_vehicle setPosATL _position} else {_vehicle setPosASL _position};
_vehicle setVectorUp [0,0,1];
_vehicle setVariable ["JK_VSS_Cost", _costs, true];
clearWeaponCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;

uiSleep 5;

_vehicle allowDamage true;
