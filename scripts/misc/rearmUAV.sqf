private ["_veh"];
_veh = _this select 0;

if (_veh isKindOf "ParachuteBase" || !alive _veh) exitWith {};

if (!(_veh isKindOf "B_UAV_02_CAS_F")) exitWith { 
	_veh vehicleChat "Dieser Platz ist nur für Drohen, Soldat!"; 
};

_veh vehicleChat "Drohne wird gewartet, bitte warten ...";

_veh setFuel 0;

//---------- RE-ARMING

sleep 10;

_veh vehicleChat "Aufmunitionieren ...";

//---------- REPAIRING

sleep 10;

_veh vehicleChat "Reparieren ...";

//---------- REFUELING

sleep 10;

_veh vehicleChat "Betanken ...";

//---------- FINISHED

sleep 10;

_veh setDamage 0;
_veh vehicleChat "Reperatur (100%).";

_veh setVehicleAmmo 1;
_veh vehicleChat "Aufmunitionierung (100%).";

_veh setFuel 1;
_veh vehicleChat "Betankung (100%).";

sleep 2;

_veh vehicleChat "Wartung beendet.";