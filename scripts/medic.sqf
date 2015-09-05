if (!isServer) exitWith {};
_veh = "Box_NATO_Support_F" createVehicle getMarkerPos "medic";

clearWeaponCargoGlobal _veh;
clearMagazineCargoGlobal _veh;
clearBackpackCargoGlobal _veh;
clearItemCargoGlobal _veh;

_veh addItemCargoGlobal ["ACE_salineIV_500", 20];
_veh addItemCargoGlobal ["ACE_quikclot", 20];
_veh addItemCargoGlobal ["ACE_personalAidKit", 10];
_veh addItemCargoGlobal ["ACE_packingBandage", 30];
_veh addItemCargoGlobal ["ACE_morphine", 15];
_veh addItemCargoGlobal ["ACE_epinephrine", 15];
_veh addItemCargoGlobal ["ACE_fieldDressing", 30];
_veh addItemCargoGlobal ["ACE_elasticBandage", 30];