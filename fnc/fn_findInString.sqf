/*
Author: Killzone_Kid

Last modified:

Description: Find a string within a string (case insensitive)

             NOTE: ["look for this", "look in this"] call KK_fnc_inString;

             returns boolean
__________________________________________________________________*/
private ["_needle","_haystack","_needleLen","_hay","_found"];
params [["_needle", "", [""]], ["_haystack", "", [""]]];
_haystack = toArray _haystack;
_needleLen = count toArray _needle;
_hay = +_haystack;
_hay resize _needleLen;
_found = false;
for "_i" from _needleLen to count _haystack do {
    if (toString _hay isEqualTo _needle) exitWith {_found = true};
    _hay set [_needleLen, _haystack select _i];
    _hay set [0, "x"];
    _hay = _hay - ["x"]
};
_found
