/*
Author: SENSEI

Last modified: 8/15/2015

Description: check approval on client

			 returns nothing
__________________________________________________________________*/
private ["_approvalArray","_stance","_suicide","_rebel"];

_approvalArray = call SEN_fnc_getApproval;
_stance = _approvalArray select (count _approvalArray - 1); // always last element in array
_suicide = _approvalArray select 0;
_rebel = _approvalArray select 1;

hintSilent format["%2\nCivilian Approval: %3\nChance of Suicide Attack: %4%%1\nChance of Rebel Activity: %5%1","%",_stance,round SEN_approvalCiv,(str _suicide), (str _rebel)];