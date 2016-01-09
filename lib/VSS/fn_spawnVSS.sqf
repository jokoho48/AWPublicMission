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

private ["_vehicle", "_nearstObj", "_cost", "_allHitPoints", "_damages", "_count", "_earnBack", "_earnBacks"];

params [["_className", "", [""]], ["_costs", 0,[0]], ["_position", [0, 0, 0], [[]]], ["_direction", 0, [0]]];
_nearstObj = nearestObjects [_position,["landVehicle","Air","Ship","ReammoBox_F"],(7 max (ceil(sizeOf _className)))];

_earnBacks = 0;
if !(_nearstObj isEqualTo []) then {
    {
        _cost = _x getVariable "JK_VSS_Cost";
        if !(isNil "_cost") then {
            _allHitPoints = getAllHitPointsDamage _x;
            _damages = _allHitPoints select 2;
            _damage = 0;
            _count = ({
                _damage = _damage + _x;
                true
            } count _damages);

            _earnBack = round ((1 - _damage/_count) * _cost);
            _earnBacks = _earnBacks + _earnBack;
        };
        deleteVehicle _x;
        nil
    } count _nearstObj;
};

JK_TicketSystem = (JK_TicketSystem - _costs) + _earnBacks;
publicVariable "JK_TicketSystem";

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

call {
    if (_className in ["B_APC_Tracked_01_CRV_F", "C_Offroad_01_repair_F", "B_Truck_01_Repair_F"]) exitWith {
        _vehicle setVariable ["ACE_isRepairVehicle", 1, true];
    };
    if (_className in ["B_UAV_02_F", "B_UAV_02_CAS_F", "B_UGV_01_F", "B_UGV_01_rcws_F"]) exitWith {
        createVehicleCrew _vehicle;
    };
};

_vehicle allowDamage true;
