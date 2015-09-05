/*
Author: 

	Jester [AW] & Quiksilver

Last modified: 

	16/04/2014 by QS
	
Description:

	When AO is complete, a chance that OPFOR will counterattack.
	
	Create AO detection trigger
	At end of sequence, count WEST.
	if (WEST < 1) exitWith {lost};
	if (WEST > 0) exitWith (held);
	
	Also, APCs spawned with EOS do not engage for whatever reason
_______________________________________________________*/

private ["_pos","_rad","_survivors","_type"];

sleep 1;

if(random 1 >= 0.35) then {
	
	_defendMessages = [
		"Feindliche Einheiten nähern sich! Suchen Sie sofort Deckung und verteidigen Sie die Stellung!",
		"Der Feind hat es geschafft Verstärkungen zu rufen! Bilden Sie einen Verteidigungsring um die Stellung!"
	];
	_targetStartText = format [
		"<t align='center' size='2.2'>Stellung verteidigen</t><br/><t size='1.5' align='center' color='#0d4e8f'>%1</t><br/>____________________<br/>Wir haben ein Problem. Der Feind schaffte es Verstärkung zu alarmieren. Diese sind auf dem Weg zu der zuletzt eingenommenen Stellung. Sie müssen die Stellung um jeden Preis verteidigen!",
		currentAO
	];

	GlobalHint = _targetStartText; publicVariable "GlobalHint"; hint parseText GlobalHint;
	showNotification = ["NewMainDefend", currentAO]; publicVariable "showNotification";

	{_x setMarkerPos (getMarkerPos currentAO);} forEach ["aoCircle_2","aoMarker_2"];
	"aoMarker_2" setMarkerText format["Defend %1",currentAO];

	sleep 10;
	//publicVariable "refreshMarkers";
	publicVariable "currentAO";
	currentAOUp = true; publicVariable "currentAOUp";
	radioTowerAlive = false; publicVariable "radioTowerAlive";

	_playersOnlineHint = format [
		"<t size='1.5' align='left' color='#C92626'>Feind greift an %1!</t><br/><br/>____________________<br/>Fertig machen, die Jungs sind fast hier!", currentAO
	];

	_defendTimer1 = 480;			// 480
	_defendTimer2 = random 120;		// 120
	
	GlobalHint = _playersOnlineHint; publicVariable "GlobalHint"; hint parseText GlobalHint;

	sleep 10;

	hqSideChat = _defendMessages call BIS_fnc_selectRandom; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;

	_type = [1,2,3];
	_selectedType = _type select (floor (random (count _type)));
	
	if (_selectedType == 1) then {
		null = [["aoCircle_2"],[6,5],[3,2],[0],[1,0],[0,0,EAST],[0,1,120,false,true]] call Bastion_Spawn;
	};
	if (_selectedType == 2) then {
		null = [["aoCircle_2"],[6,5],[3,2],[0],[2,0],[0,0,EAST],[0,1,120,false,true]] call Bastion_Spawn;
	};
	if (_selectedType == 3) then {
		null = [["aoCircle_2"],[6,5],[3,2],[3],[1,0],[0,0,EAST],[0,1,120,false,true]] call Bastion_Spawn;
	};
		
	hint "Thermalaufnahmen zeigen Feinde im nahen Umfeld des Einsatzgebietes!";
			
	sleep 5;
			
	hqSideChat = "Der Angriff endet in voraussichtlich 10 Minuten."; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
			
	sleep _defendTimer1;
		
	hqSideChat = "Der Angriff ist fast vorüber!"; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
	
	sleep _defendTimer2;

	[["aoCircle_2"]] call EOS_deactivate;
};