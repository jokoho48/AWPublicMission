/*
Author: SENSEI

Last modified: 7/25/2015

Description: create triggers over occupied locations that monitor enemy count
__________________________________________________________________*/
if (!isServer) exitWith {};

{
    _townPos = getpos _x;
    _townPos set [2,0];
    _townName = text _x;
    _townType = type _x;
    _townSize = size _x;

    call {
        if (_townType isEqualTo "NameCityCapital") exitWith {
            _mrkOccupy = createMarker [format["SEN_occupy_mrk_%1", _townName], [((_townPos) select 0), ((_townPos) select 1) - 70]];
            _mrkOccupy setMarkerType "o_unknown";
            _mrkOccupy setMarkerText "Occupied Capital";
            _mrkOccupy setMarkerColor "ColorEAST";

            _trgOccupy = createTrigger ["EmptyDetector", _townPos];
            _trgOccupy setTriggerArea [((_townSize select 0) + 100),((_townSize select 1) + 100), 0, false];
            _trgOccupy setTriggerActivation ["WEST", "PRESENT", false];
            _var = format ["SEN_occupiedLocation select %1",_forEachIndex];
            _trgAct = format ["[%1,%2] spawn compile preprocessFileLineNumbers 'scripts\SEN_occupyTrgAct.sqf'",str _var,str _mrkOccupy];
            _trgOccupy setTriggerStatements ["this", _trgAct, ""];

        };
        if (_townType isEqualTo "NameCity") exitWith {
            _mrkOccupy = createMarker [format["SEN_occupy_mrk_%1", _townName], [((_townPos) select 0), ((_townPos) select 1) - 70]];
            _mrkOccupy setMarkerType "o_unknown";
            _mrkOccupy setMarkerText "Occupied City";
            _mrkOccupy setMarkerColor "ColorEAST";

            _trgOccupy = createTrigger ["EmptyDetector", _townPos];
            _trgOccupy setTriggerArea [((_townSize select 0) + 100),((_townSize select 1) + 100), 0, false];
            _trgOccupy setTriggerActivation ["WEST", "PRESENT", false];
            _var = format ["SEN_occupiedLocation select %1",_forEachIndex];
            _trgAct = format ["[%1,%2] spawn compile preprocessFileLineNumbers 'scripts\SEN_occupyTrgAct.sqf'",str _var,str _mrkOccupy];
            _trgOccupy setTriggerStatements ["this", _trgAct, ""];
        };

        _mrkOccupy = createMarker [format["SEN_occupy_mrk_%1", _townName], [((_townPos) select 0), ((_townPos) select 1) - 70]];
        _mrkOccupy setMarkerType "o_unknown";
        _mrkOccupy setMarkerText "Occupied Town";
        _mrkOccupy setMarkerColor "ColorEAST";

        _trgOccupy = createTrigger ["EmptyDetector", _townPos];
        _trgOccupy setTriggerArea [((_townSize select 0) + 100),((_townSize select 1) + 100), 0, false];
        _trgOccupy setTriggerActivation ["WEST", "PRESENT", false];
        _var = format ["SEN_occupiedLocation select %1",_forEachIndex];
        _trgAct = format ["[%1,%2] spawn compile preprocessFileLineNumbers 'scripts\SEN_occupyTrgAct.sqf'",str _var,str _mrkOccupy];
        _trgOccupy setTriggerStatements ["this", _trgAct, ""];
    };

    if (SEN_debug isEqualTo 1) then {
        _radius = (((_townSize select 0) + (_townSize select 1))/2) + 100;
        _mrk = createMarker [format["SEN_occupy_AO_%1",_townName],_townPos];
        _mrk setMarkerShape "ELLIPSE";
        _mrk setMarkerSize [_radius,_radius];
        _mrk setMarkerColor "ColorEAST";
    };

} forEach SEN_occupiedLocation;
