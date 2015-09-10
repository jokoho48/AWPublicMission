/*
Author: SENSEI

Last modified: 8/8/2015

Description:  receive request for FOB control
__________________________________________________________________*/
private ["_requestor","_time","_id1","_id2"];

_requestor = _this select 0;
_time = time;
SEN_fobResponse = -1;

hintSilent format["%1" + " requests control of FOB construction. Reply via action menu.",name _requestor];

_id1 = player addAction ["<t color='#FF0000'>Deny Request</t>",{SEN_fobResponse = 0},[],110,false,true];
_id2 = player addAction ["<t color='#FF0000'>Accept Request</t>",{SEN_fobResponse = 1},[],110,false,true];

waitUntil {sleep 0.1; !(SEN_fobResponse isEqualTo -1) || time > (_time + 90)};

player removeAction _id1;
player removeAction _id2;

missionNamespace setVariable ["SEN_fobRequest",[_requestor,SEN_fobResponse]];
publicVariableServer "SEN_fobRequest";