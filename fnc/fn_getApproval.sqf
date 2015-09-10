/*
Author: SENSEI

Last modified: 1/1/2015

Description: gets numbers to be used as percentages in approval related functionality

			 returns array
__________________________________________________________________*/
private ["_return","_chance","_stance"];

_return = [];

// suicide attacks
_chance = [5.0,40.0,18.0,0.06] call SEN_fnc_getApprovalNumber;
_return pushBack _chance;

// rebel attacks
_chance = [15.0,80.0,50.0,0.2] call SEN_fnc_getApprovalNumber;
_return pushBack _chance;

// general civilian stance
call {
	if (SEN_approvalCiv <= -250) exitWith {
		_stance = "The local population does not support you!";
	};
	if (SEN_approvalCiv > -250 && {SEN_approvalCiv <= -100}) exitWith {
		_stance = "The local population is displeased with you.";
	};
	if (SEN_approvalCiv > -100 && {SEN_approvalCiv <= 100}) exitWith {
		_stance = "The local population is indifferent to you.";
	};
	if (SEN_approvalCiv > 100 && {SEN_approvalCiv <= 250}) exitWith {
		_stance = "The local population is pleased with you.";
	};
	if (SEN_approvalCiv > 250) exitWith {
		_stance = "The local population supports you!";
	};

	_stance = "The local population is indifferent to you.";
};

_return pushBack _stance;

_return