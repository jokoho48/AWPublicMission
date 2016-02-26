[] spawn {
    waitUntil {sleep 2; !isNull (findDisplay 46)};
    if !(didJIP && (isNil "JK_registerPlayer")) exitWith {};
    [] execVM "initPlayerLocal.sqf";
};
