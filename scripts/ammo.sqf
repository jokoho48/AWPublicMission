if (!isServer) exitWith {};
_veh = "Box_NATO_Support_F" createVehicle getMarkerPos "ammo";

clearWeaponCargoGlobal _veh;
clearMagazineCargoGlobal _veh;
clearBackpackCargoGlobal _veh;
clearItemCargoGlobal _veh;

_veh addMagazineCargoGlobal ["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", 60];
_veh addMagazineCargoGlobal ["9Rnd_45ACP_Mag", 30];
_veh addMagazineCargoGlobal ["rhs_fim92_mag", 6];
_veh addMagazineCargoGlobal ["rhs_fgm148_magazine_AT", 6];
_veh addMagazineCargoGlobal ["rhsusf_20Rnd_762x51_m118_special_Mag", 15];
_veh addMagazineCargoGlobal ["rhsusf_5Rnd_300winmag_xm2010", 15];
_veh addMagazineCargoGlobal ["rhsusf_100Rnd_762x51", 10];
_veh addMagazineCargoGlobal ["rhs_m136_mag", 6];
_veh addItemCargoGlobal ["SmokeShellGreen", 10];
_veh addItemCargoGlobal ["SmokeShellPurple", 10];
_veh addItemCargoGlobal ["SmokeShell", 20];
_veh addItemCargoGlobal ["rhs_mag_mk84", 20];
_veh addItemCargoGlobal ["rhs_mag_m67", 20];
_veh addItemCargoGlobal ["rhs_mag_M441_HE", 30];
_veh addItemCargoGlobal ["rhs_mag_m714_White", 20];

	