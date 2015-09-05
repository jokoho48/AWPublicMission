	private ["_veh","_vehName","_vehVarname","_completeText","_reward","_GAU","_rabbit","_mortar"];

smRewards =
[
	["einen M1025 MK19 HMMWV","rhsusf_m1025_d_mk19"],
	["einen M998 Cargo HMMWV","rhsusf_m998_d_4dr_fulltop"]
];
smMarkerList =
["smReward1"],["smReward2"];

_veh = smRewards call BIS_fnc_selectRandom;

_vehName = _veh select 0;
_vehVarname = _veh select 1;

_completeText = format[
"<t align='center'><t size='2.2'>Nebenmission</t><br/><t size='1.5' color='#08b000'>BEENDET</t><br/>____________________<br/>Fantastische Arbeit! Der Feind wird es auf dieser Insel nicht mehr lange aushalten, wenn ihr so weiter macht!<br/><br/>Wir haben euch einen %1 um euch im Kampf zu unterstützen. Ihr findest das Fahrzeug im Hauptquartier.<br/><br/>Konzentriert euch jetzt auf unser Hauptziel; unsere Aufklärungseinheit wertet aktuell die Daten aus. Wir melden uns in etwa 10-15 Minuten wieder bei euch, sobald ein neues Ziel ausgemacht wurde.</t>",_vehName];

_reward = createVehicle [_vehVarname, getMarkerPos "smReward1",smMarkerList,0,"NONE"];
waitUntil {!isNull _reward};

_reward setDir 284;

GlobalHint = _completeText; publicVariable "GlobalHint"; hint parseText _completeText;
showNotification = ["BeendetNebenmission", sideMarkerText]; publicVariable "showNotification";
showNotification = ["Belohnung", format["Dein Team erhielt %1!", _vehName]]; publicVariable "showNotification";

{
	_x addCuratorEditableObjects [[_reward], false];
} foreach adminCurators;