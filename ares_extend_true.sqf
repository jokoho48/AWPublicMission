fn_snip_suppress = {
	params["_unit","_target","_rof","_duration"];
	snip_suppress_rof = _rof;
	snip_suppress_duration = _duration;
	(units (group _unit)) doFSM ["supression.fsm",_target,_target];
};

[
	"AI Behaviours",
	"AI Suppress Area",
	{
		private [private ["_unit", "_logic", "_allTargetsUnsorted", "_allTargets", "_targetChoices", "_dialogResult", "_selectedTarget", "_targetChooseAlgorithm", "_rateOfFire", "_duration", "_target"];
		params ["_logic"];
		_unit = [_logic] call Ares_fnc_GetUnitUnderCursor;
		_allTargetsUnsorted = allMissionObjects "Ares_Module_Behaviour_Create_Artillery_Target";
		_allTargets = [_allTargetsUnsorted, [], { _x getVariable ["SortOrder", 0]; }, "ASCEND"] call BIS_fnc_sortBy;
		_targetChoices = ["Random", "Nearest", "Farthest"];
		{
			_targetChoices pushBack (name _x);
			nil
		} count _allTargets;

		_dialogResult = [
		"Suppression Options",
		[
			["Rate of Fire", ["Low", "Normal", "Rapid", "Assault"]],
			["Duration (seconds)", ["20","40","60"]],
			["Choose Target", _targetChoices, 1]
		]] call Ares_fnc_ShowChooseDialog;

		if !(_dialogResult isEqualTo []) then {
			_dialogResult params ["_rateOfFire","_duration","_targetChooseAlgorithm"];
			if (count _allTargets > 0) then {
				_selectedTarget = switch (_targetChooseAlgorithm) do {
					case 0: {
						_allTargets call BIS_fnc_selectRandom;
					};
					case 1: {
						[getPos _unit, _allTargets] call Ares_fnc_GetNearest;
					};
					case 2: {
						[getPos _unit, _allTargets] call Ares_fnc_GetFarthest;
					};
					default {
						_allTargets select (_targetChooseAlgorithm - 3);
					};
				};
				_target = getPos _selectedTarget;
				snip_suppress_rof = ["Low", "Normal", "Rapid", "Assault"] select _rateOfFire;
				snip_suppress_duration = [20,40,60] select _duration;


				[[[_unit,_target,snip_suppress_rof,snip_suppress_duration], fn_snip_suppress],"BIS_fnc_call",_unit] call BIS_fnc_MP;
				[objNull, "Units will now suppress"] call bis_fnc_showCuratorFeedbackMessage;
			} else {
				[objNull, "No targets in range"] call bis_fnc_showCuratorFeedbackMessage;
			};
		};
	}
] call Ares_fnc_RegisterCustomModule;
