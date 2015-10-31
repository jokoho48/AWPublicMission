﻿/*
loadout script by joko
Idea by Belbo
adds the loadouts to the specific playable units for the side West
Call from initPlayerLocal.sqf via:
[Object] call JK_loadOut_fnc_loadoutsInit;
*/

///// No editing necessary below this line /////

params [["_target", player, [objNull]]];
[_target] call jk_loadOut_fnc_applyLoadout;
[SEN_arsenal] call JK_loadOut_fnc_chooseLoadout;