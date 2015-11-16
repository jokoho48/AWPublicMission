/*
	@file Title: Test Framework by Creedcoder
	@file Version: 1.0
	@file Name: init.sqf
	@file Author: Creedcoder
	@file edit: 07.07.2015
	Copyright © 2015 Creedcoder, All rights reserved

	Do not use without permission!

	This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
	To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/ or send a letter to Creative Commons,
	444 Castro Street, Suite 900, Mountain View, California, 94041, USA.
*/

finishMissionInit;
enableSaving [false,false];

JK_USMC = ["MC_COMMAND", "MC_RADIOOP", "MC_LEADER", "MC_FTL", "MC_MEDIC", "MC_ARMAN", "MC_MG", "MC_ASSMG", "MC_AA", "MC_AAASS", "MC_AT", "MC_ATMK153", "MC_ATASS", "MC_ATASSMK153", "MC_GRENADIER", "MC_RIFLEMAN", "MC_STORMTROOPER", "MC_MARKSMAN", "MC_SPECIALIST", "MC_MORTARTEAMBIPOD", "MC_MORTARTEAMTUBE", "MC_M2TEAMGUN", "MC_M2TEAMTRIPOD"];
JK_USARMY = ["AR_COMMAND", "AR_RADIOOP", "AR_LEADER", "AR_FTL", "AR_MEDIC", "AR_ARMAN", "AR_MG", "AR_ASSMG", "AR_AA", "AR_AAASS", "AR_AT", "AR_ATMK153", "AR_ATASS", "AR_ATASSMK153", "AR_GRENADIER", "AR_RIFLEMAN", "AR_STORMTROOPER", "AR_MARKSMAN", "AR_SPECIALIST", "AR_MORTARTEAMBIPOD", "AR_MORTARTEAMTUBE", "AR_M2TEAMGUN", "AR_M2TEAMTRIPOD"];
JK_USSOF = ["SO_LEADER", "SO_GRENADIER", "SO_AT", "SO_ARMAN", "SO_MARKSMAN", "SO_SPECOPS","SO_AA", "SO_SPECIALIST"];
JK_USSOFLIGHT = ["SOL_LEADER", "SOL_AT", "SOL_ARMAN", "SOL_GRENADIER", "SOL_MARKSMAN", "SOL_SPECIALIST", "SOL_SPECOPS", "SOL_AA"];
JK_PARA = ["PARA_LEADER", "PARA_TROOPER", "PARA_ARMAN", "PARA_DROPMEDIC", "PARA_EXEXPERT", "PARA_GRENADIER", "PARA_MARKSMAN", "PARA_STORMTROOPER", "PARA_ASSAR"];
JK_SPECIALCLASSES = ["SC_PJMEDIC", "SC_PILOT", "SC_JETPILOT", "SC_CREW", "SC_DIVER"];
JK_CLASSES = JK_USMC + JK_USARMY + JK_USSOF + JK_USSOFLIGHT + JK_PARA + JK_SPECIALCLASSES;

/*
{
	[_x,(call compile format["JK_loadOut_fnc_%1",_x]),1] spawn db_fnc_codesave;
	nil;
} count JK_CLASSES;
*/

{
	private "_path";
	_path = "";
	call {
		if (_x in JK_USMC) exitWith {
			_path = "lib\gear\loadouts\USMC\";
		};
		if (_x in JK_USARMY) exitWith {
			_path = "lib\gear\loadouts\USARMY\";
		};
		if (_x in JK_USSOF) exitWith {
			_path = "lib\gear\loadouts\USSOF\";
		};
		if (_x in JK_USSOFLIGHT) exitWith {
			_path = "lib\gear\loadouts\USSOFlight\";
		};
		if (_x in JK_SPECIALCLASSES) exitWith {
			_path = "lib\gear\loadouts\special\";
		};
		if (_x in JK_PARA) exitWith {
			_path = "lib\gear\loadouts\parachute\";
		};
	};
	["Loadouts:"+ _x,(compile preprocessFileLineNumbers format["%1fn_%2.sqf", _path, _x]), 1] spawn db_fnc_codesave;
	nil;
} count JK_CLASSES;
