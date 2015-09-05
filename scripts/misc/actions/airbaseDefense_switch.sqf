if (AIRBASEDEFENSE_SWITCH) exitWith {
	hint "Luftverteidigung aktuell nicht verfügbar."
};

[[player,"AinvPercMstpSrasWrflDnon_Putdown_AmovPercMstpSrasWrflDnon"],"QS_fnc_switchMoveMP",nil,false] spawn BIS_fnc_MP;

//-------------------- Wait for player to action

sleep 1;

//-------------------- Send hint to player that he's planted the bomb

hint "Aktiviere Luftverteidigung des HQ ...";

sleep 3;

//---------- Send notice to all players that charge has been set.

AIRBASEDEFENSE_SWITCH = true; publicVariable "AIRBASEDEFENSE_SWITCH";