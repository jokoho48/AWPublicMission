/*
 * Author: joko // Jonas
 * Description
 *
 * Arguments:
 * 0: Argument Description <TYPE>
 *
 * Return Value:
 * Return description <TYPE>
 *
 */

params ["_building"];
_index = (JK_allBuildingPositions select 0) find _building;

// Fail Save if Building Classnames Changed
if (_index == -1) exitWith {
    _allPostemp = [_building, 99999999999999] call BIS_fnc_buildingPositions;
    _allPos = [];
    {
        _allPos pushBack (_building modelToWorld _x);
        nil
    } count _allPostemp;
    (JK_allBuildingPositions select 0) pushBack (typeOf _building);
    (JK_allBuildingPositions select 1) pushBack _allPos;

    [_building] call JK_Core_fnc_buildingPositions;
};

(JK_allBuildingPositions select 1) select _index;
