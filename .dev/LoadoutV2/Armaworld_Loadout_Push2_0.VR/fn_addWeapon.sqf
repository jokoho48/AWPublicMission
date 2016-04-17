// add Weapon Wraper and magazine
params ["_unit", "_weapon", "_magazineClassName", "_magazineCount"];
for "_i" from 0 to _magazineCount do {
    _unit addMagazine _magazineClassName;
};
_unit addWeapon _weapon;
