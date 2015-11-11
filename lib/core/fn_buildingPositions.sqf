/*
 * Author: joko // Jonas
 * Retrun a Array with all Building Postions (original Idea by BI)
 *
 * Arguments:
 * 0: Building Object
 *
 * Return Value:
 * Array with AllBuilding Postions
 *
 */

private ["_availablePositions", "_index"];
//Parameters
params [["_building", objNull, [objNull]]];

//The number of available positions

_availablePositions = [];

//The index
_index = 0;

//Loop limit and find available positions
while { (_building buildingPos _index) distance [0,0,0] > 0 && _index < _max } do {
    //Add position to the pool
    _availablePositions pushBack (_building buildingPos _index);

    //Increment index
    _index = _index + 1;
};

//Return
_availablePositions
