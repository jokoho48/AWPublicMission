// Author: Quiksilver
// Clear inventory add action

_v = vehicle player;
clearItemCargoGlobal _v;
clearMagazineCargoGlobal _v;
inventory_cleared = true;
[{
    inventory_cleared = false;
}, 300, []] call ace_common_fnc_waitAndExecute;
