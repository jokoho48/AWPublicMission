/*
 * Author: joko // Jonas
 * Create a Animated Marker
 * This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International Public License.
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/ or send a letter to Creative Commons,
 * 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.
 *
 * Arguments:
 * 0: Postion <Array, Object, String>
 * 1: Color of Marker <String> (default: "ColorRed")
 * 2: Maximal Size of Marker <Float> (default: 100)
 * 3: Speed of the Animation <Float> (default: 40)
 *
 * Return Value:
 * Thread to Kill the Animation <Script Handle>
 */
params [["_pos", objNull, [[], objNull, ""]],["_color", "ColorRed", [""]],["_maxSize", 100],["_speed", 40]];

JK_allowedColors = [
    "Default",
    "ColorBlack",
    "ColorGrey",
    "ColorRed",
    "ColorGreen",
    "ColorBlue",
    "ColorYellow",
    "ColorOrange",
    "ColorWhite",
    "ColorPink",
    "ColorBrown",
    "ColorKhaki",
    "ColorWEST",
    "ColorEAST",
    "ColorGUER",
    "ColorCIV",
    "ColorUNKNOWN",
    "Color1_FD_F",
    "Color2_FD_F",
    "Color3_FD_F",
    "Color4_FD_F",
    "ColorBLUFOR",
    "ColorCivilian",
    "ColorIndependent",
    "ColorOPFOR"
];

if !(_color in JK_allowedColors) then {
    _color = JK_allowedColors call BIS_fnc_selectRandom;
};

_pos = switch (typeName _pos) do {
    case ("OBJECT"): {
        getPos _pos
    };
    case ("STRING"): {
        getMarkerPos _pos
    };
    case ("ARRAY"): {
        _pos
    };
};

private _name = format ["%1%2%3%4%5%6%7%8%9", random 100, random 100, random 100, random 100, random 100, random 100, random 100, random 100, random 100];
private _mrkOutLine = createMarkerLocal [format["JK_Marker_OutLine_%1",_name], _pos];
private _mrkFiller = createMarkerLocal [format["JK_Marker_Filler_%1",_name], _pos];
_mrkFiller setMarkerColorLocal _color;
_mrkOutLine setMarkerColorLocal _color;

_mrkFiller setMarkerAlphaLocal 0;
_mrkOutLine setMarkerAlphaLocal 1;

_mrkFiller setMarkerShapeLocal "ELLIPSE";
_mrkOutLine setMarkerShapeLocal "ELLIPSE";

_mrkFiller setMarkerSizeLocal [0,0];
_mrkOutLine setMarkerSizeLocal [0,0];

_mrkFiller setMarkerBrushLocal "SolidFull";
_mrkOutLine setMarkerBrushLocal "Border";

private _addionAlpha = 1 / _speed;
private _addionSize = _maxSize / _speed;

[_mrkOutLine, _mrkFiller, _maxSize, _speed] spawn {
    params ["_mrkOutLine", "_mrkFiller", "_maxSize", "_speed"];

    private _currentSize = 0;
    private _currentAlpha = 0;
    while { true } do {

        _currentAlpha = (_currentAlpha + _addionAlpha) mod 1;
        _currentSize = (_currentSize + _addionSize) mod _maxSize;

        _mrkFiller setMarkerSizeLocal [_currentSize,_currentSize];
        _mrkOutLine setMarkerSizeLocal [_currentSize,_currentSize];

        _mrkFiller setMarkerAlphaLocal (1 - _currentAlpha);

        sleep 0.025;
    };
};
