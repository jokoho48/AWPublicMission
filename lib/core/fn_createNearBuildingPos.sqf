/*
 * Author: joko // Jonas
 * Create a Array with all Building and BuildingPositons in it
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * ["example value"] call ace_module_fnc_functionName
 *
 * Public: No
 */
if !(isServer) exitWith {};
if !(isNil "JK_allBuildingPositions") exitWith {};
_tempAllPos = [];
_tempAllBuildings = [];
{
    private ["_allPos", "_type"];
    _type = typeOf _x;
    if !(_type in _tempAllBuildings) then {
        _allPostemp = [_x, 99999999999999] call BIS_fnc_buildingPositions;
        _allPos = [];
        {
            _allPos pushBack (_allPos modelToWorld _x);
            nil
        } count _allPostemp;
        _tempAllPos pushBack _allPos;
        _tempAllBuildings pushBack _type;
    };
    nil
} count ([(worldSize / 2), (worldSize / 2), 0] nearObjects ["House", (worldSize / 2)]);
JK_allBuildingPositions = [_tempAllBuildings, _tempAllPos];
publicVariable "JK_allBuildingPositions";
