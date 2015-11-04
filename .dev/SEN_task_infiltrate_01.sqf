/*
Author: SENSEI

Last modified: 12/23/2014

Description: infiltrate and plant explosives task

        NOTE: task is on hold until I find a cleaner way to create the scenario
__________________________________________________________________*/
if (!isServer) exitWith {};
/*
private ["_isEmpty","_heliPos","_pos","_trojanType"];

// declare disguise fnc
SEN_fnc_disguise = {
    private ["_uniform","_vest","_backpack","_helmet","_enemies","_uItems","_vItems","_bItems","_EH"];
    _uniform =_this select 0;
    _vest =_this select 1;
    _backpack =_this select 2;
    _helmet =_this select 3;
    _enemies =_this select 4;

    _uItems = uniformItems player;
    _vItems = vestItems player;
    _bItems = backpackItems player;

    removeUniform player;
    removeVest player;
    removeBackpack player;
    removeHeadgear player;

    sleep 0.1;

    player forceAddUniform _uniform;
    player addVest _vest;
    player addBackpack _backpack;
    if !(_helmet isEqualTo "") then {player addHeadgear _helmet};

    {player addItemToUniform _x} forEach _uItems;
    {player addItemToVest _x} forEach _vItems;
    {player addItemToBackpack _x} forEach _vItems;

    player setcaptive true;
    _EH = player addEventHandler ["fired", {if (captive (_this select 0)) then {(_this select 0) setCaptive false}}];

    // discovered if too close to enemy
    [_enemies] spawn {
        while {getMarkerColor "SEN_infil_base" != ""} do {
            if ((random 1 < 0.25) && {{player distance _x < 1.5} count (units (_this select 0)) > 0}) then {
                player setCaptive false;
            };
            sleep 5;
        };
    };

    // playsound "";
    [player, "SEN_LOG", "Equipping enemy uniform. You are now in disguise."] call CSE_fnc_sendDisplayMessageTo;
};

publicVariable "SEN_fnc_disguise";

_infilArray = [];
_mrkArray = [];

call {
    if (SEN_enemySide isEqualTo EAST) exitWith {_trojanType = "O_Heli_Light_02_unarmed_F"};
    if (SEN_enemySide isEqualTo RESISTANCE) exitWith {_trojanType = "I_Heli_light_03_unarmed_F"};

    _trojanType = "O_Heli_Light_02_unarmed_F";
};

while {true} do {
    sleep 0.2;

    _pos = [SEN_centerPos,SEN_range,150] call SEN_fnc_findRuralFlatPos;
    if (!(_pos isEqualTo [])) then {
        _heliPos = [_pos,(SEN_range/3),(SEN_range/2)] call SEN_fnc_findRandomPos;
        if (_heliPos distance SEN_centerPos < SEN_range) then {
            _isEmpty = _heliPos isFlatEmpty [18, 0, 1, 18, 0, false, objNull];
        };
    };
    if (!(count _isEmpty isEqualTo 0) && {!(_pos isEqualTo [])}) exitWith {};
};

_grpArray = [_pos,1,SEN_enemySide,true] call SEN_fnc_spawnSquad;
_baseArray = _grpArray select 0;
_lz = _baseArray select 1;
_baseArray = _baseArray select 0;
_vehArray = _grpArray select 1;
_grp = _grpArray select 2;
[_vehArray] spawn SEN_fnc_cleanup;
[_grp,90] spawn SEN_fnc_setPatrolGroup;

// get disguise
_uniform = uniform (leader _grp);
_vest = if !(vest (leader _grp) isEqualTo "") then {vest (leader _grp)} else {"V_PlateCarrier1_blk"};
_helmet = if !(headgear (leader _grp) isEqualTo "") then {headgear (leader _grp)} else {""};
_backpack = if !(backpack (leader _grp) isEqualTo "") then {backpack (leader _grp)} else {"B_Carryall_cbr"};

// get target
_tar = (_pos nearObjects ["Land_Device_disassembled_F",100]) select 0;

_trojan = createVehicle [_trojanType, _heliPos, [], 0, "NONE"];
_pilot = createGroup WEST createUnit ["B_Helipilot_F", [0,0,0], [], 0, "NONE"];
_pilot assignAsDriver _trojan;
_pilot moveInDriver _trojan;
_pilot setcaptive true;

_mrk = createMarker ["SEN_infil_heli",_heliPos];
_mrk setMarkerColor "ColorWEST";
_mrk setMarkerType "mil_pickup";
_mrk setMarkerText "Infiltration Pickup";

_mrk1 = createMarker ["SEN_infil_base",_pos];
_mrk1 setMarkerColor "ColorEAST";
_mrk1 setMarkerType "o_hq";
_mrk1 setMarkerText "Infiltrate Base";

[["infiltrate_01", "According to intel, a nearby enemy base is housing newly developed technology that may jepordize the security of MOB Dodge./n",
"Infiltrate Enemy Base and Destroy Advanced Tech", "assigned"]] call FHQ_TT_addTasks;

waitUntil {sleep 5; {isPlayer _x} count crew _trojan > 0};

_trojan engineOn true;

sleep 30;

_trojan move _lz;

{
    if (isPlayer _x) then {
        [[_uniform,_vest,_backpack,_helmet,_grp],"SEN_fnc_disguise",owner _x] spawn BIS_fnc_MP;
        _infilArray pushBack _x;
    };
} forEach crew _trojan;

waitUntil {sleep 1; (unitReady _pilot)};

_trojan land "LAND";

waitUntil {sleep 1; ((isTouchingGround _trojan) && {(_trojan distance _lz < 50)})};

{moveOut _x} forEach _infilArray;

_trojan move [0,0,0];
[[_trojan],[],1000] spawn SEN_fnc_cleanup;

waitUntil {sleep 5; damage _tar > 0.8};

[_pos] spawn {
    _alarm = ((_this select 0) nearObjects ["Land_Loudspeakers_F",100]) select 0;

    for "_t" from 0 to 5 do {
        playSound3D ["A3\Sounds_F\sfx\alarm_independent.wss", _alarm];

        sleep 10;
    };
};

waitUntil {sleep 5; [_lz,SEN_enemySide,2] call SEN_fnc_spawnReinforcements};

_enemies = [];

{ if (side _x isEqualTo SEN_enemySide) then {_enemies pushBack _x}} foreach (_pos nearEntities ["CAManBase",150]);

_count = ceil ((count _enemies)*0.25);

waitUntil {sleep 10; ({alive _x} count _enemies) <= _count};*/
