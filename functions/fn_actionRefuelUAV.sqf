// Author: Quiksilver
// Clear inventory add action

_v = vehicle player;
clearItemCargoGlobal _v;
clearMagazineCargoGlobal _v;
inventory_cleared = true;
[] spawn {
	sleep 300;
	inventory_cleared = false;
};