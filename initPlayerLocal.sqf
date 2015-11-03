/*
Author: SENSEI

Last modified: 8/14/2015
__________________________________________________________________*/
if (!hasInterface) exitWith {}; // headless client exit
private "_fnc_tfarSettings";
[] spawn compile preprocessFileLineNumbers "scripts\intro.sqf";
_fnc_tfarSettings = compile preprocessFileLineNumbers "tfarSettings.sqf";
call _fnc_tfarSettings;
["JK_AssignTFARFrequencies", "OnRadiosReceived", _fnc_tfarSettings, player] call TFAR_fnc_addEventHandler;
[] call compile PreprocessFileLineNumbers "scripts\VVS\configuration.sqf";
[player] call JK_loadOut_fnc_loadoutsInit;
private "_prefix";
// workaround for acre, if inventory full and can't add radio, acre throws rpt error: (Warning: Radio ID ACRE_PRC343_ID_1 was returned for a non-existent baseclass...)
if ((backpack player) isEqualTo "") then {player addBackpack "B_Kitbag_cbr"};

// setup debug
if (SEN_debug) then {
    player allowDamage false;
    player addEventHandler ["respawn",{(_this select 0) allowDamage false}];
};

// setup eventhandlers
player addEventHandler["Fired", {
    if (((_this select 0) distance (getmarkerpos "SEN_safezone_mrk")) < (getMarkerSize "SEN_safezone_mrk") select 0) then {
        deleteVehicle (_this select 6);
        ["<t size='0.6'>WEAPON DISCHARGE IS NOT PERMITTED AT THE MAIN OPERATING BASE!</t>"] spawn bis_fnc_dynamicText;
    };
}];

// check if addons enabled
SEN_acreEnabled = (isClass (configfile >> "CfgPatches" >> "acre_main"));
SEN_tfrEnabled = (isClass (configfile >> "CfgPatches" >> "task_force_radio"));

// comm net setup
// _role refers to player's role/slot - ex. "plt_co" is Platoon Commander
// _prefix refers to player's team - ex. "plt" is Platoon fireteam

// more comm net settings in files listed below
    // scripts\SEN_tfr.sqf
    // fnc\fn_setTfrRadio.sqf
    // scripts\SEN_acre2.sqf
    // fnc\fn_setAcreRadio.sqf

_commandNet = ["plt_co","a_sl","b_sl"]; // players allowed on command net, all other players are on squad specific net
_supportNet = ["plt_sgt","r","rh1"]; // players allowed on support net, all other players are on squad specific net

// set prefix variable
_role = str player;

for "_i" from 1 to (count _role) do { // move through unit name until underscore found. Anything preceeding underscore is _prefix
    if ((_role select [_i,1]) isEqualTo "_") exitWith {
        _prefix = _role select [0,_i];
    };
};

player setVariable ["SEN_team", _prefix];

// set comm net variable
call {
    if (_role in _commandNet || {_prefix in _commandNet}) exitWith {player setVariable ["SEN_commNet","command"]};
    if (_role in _supportNet || {_prefix in _supportNet}) exitWith {player setVariable ["SEN_commNet","support"]};
    player setVariable ["SEN_commNet","squad"];
};

JK_registerPlayer = player;
publicVariableServer "JK_registerPlayer";

// misc settings
SEN_civQuestioned = [];
player setVariable ["SEN_inProgress",false];
//[] spawn {call compile preprocessFileLineNumbers "scripts\VehicleHud\hud_teamlist.sqf";};
[] spawn {
    while {true} do {
        if (rating player < 0) then {
            player addrating (-1*(rating player))
        };
        uiSleep 120;
    };
};

if ((paramsArray select 2) isEqualTo 1 && {SEN_debug isEqualTo 0}) then {
    [] spawn {
        while {true} do {
            uiSleep 10;
            if (cameraOn isEqualTo player && {cameraView isEqualTo "EXTERNAL"}) then {
                hintSilent "Third person camera is disabled.";
                player switchCamera "INTERNAL";
            };
        };
    };
};


JK_var_PilotsOnly_EVH = addMissionEventHandler ["Draw3D", {
    if (alive player && !(player getVariable ["JK_isPilot", false])) then {
        if ((vehicle player isKindOf "Air" || vehicle player isKindOf "ParachuteBase") && (player == assignedDriver vehicle player || player == (vehicle player) turretUnit [0])) then {
            doGetOut player;
            hintSilent "Only Pilots are allowed to fly.";
        };
    };
}];

waitUntil {sleep 0.1; !isNull (findDisplay 46)};

// setup briefing
player createDiarySubject ["rules", "Regeln"];
player createDiarySubject ["teamspeak", "Teamspeak"];

//-------------------------------------------------- Rules

player createDiaryRecord ["rules",
[
"Bestrafungen",
"
<br />Die unten genannten Regeln dienen dazu, dass jeder Spieler mit Spaß und entspannt auf diesem Server spielen kann.
<br />
<br />Serverregeln sind als Mittel zum Zweck vorhanden.
<br />
<br />Richtlinien zu den Bestrafungen:
<br />
<br />-    Unbewusster Regelverstoß und störendes Verhalten:
<br />
<br />        = Mündlich / Schriftliche Mitteilung zur Unterlassung, oder Verwarnung.
<br />
<br />-    Geringfügige oder erstmaliger Regelverstoß:
<br />
<br />        = Kick, oder 0 - 3 Tage Bann.
<br />
<br />-    Ernsthafter oder wiederholender Regelverstoß:
<br />
<br />        = 3 - 7 Tage Bann.
<br />
<br />-    Administrativer Bann (Hack/Exploit/Beleidigung/Mobbing):
<br />
<br />        = permanenter Bann.
<br />
<br />
<br />Die oben genannten Bestrafung sind Ermessenssache des jeweiligen Admins.
"
]];

player createDiaryRecord ["rules",
[
"Allgemein",
"
<br />1. Hacken und Bugusing ist verboten und wird nicht toleriert.
<br />2. Bewusstes Töten von Kameraden ist strengstens untersagt.
<br />3. Mehrfaches Blue on Blue endet in einem Kick/Bann.
<br />4. Unnötiges zerstören von BLUFOR Fahrzeugen ist verboten.
<br />5. Beleidigungen und Mobbing ist verboten.
<br />6. Das Abfeuern der Waffe innerhalb der Base endet in einem Kick/Bann.
<br />7. Griefing und störendes Verhalten ist verboten.
<br />8. Spam über das Mikrofon ist verboten.
<br />9. Der Admin hat das finale Wort - es gibt keine Diskussionen.
<br />10. Landen innerhalb des HQ  kann zu einer Warnung oder einem Kick führen.
<br />
<br />Falls du einen Spieler entdeckst, der gegen die Regeln verstößt, melde Ihn bei einem Admin auf dem Teamspeak.
"
]];

//-------------------------------------------------- Teamspeak

player createDiaryRecord ["teamspeak",
[
"TS3",
"
<br /> Teamspeak:<br /><br />
<br /> http://www.teamspeak.com/?page=downloads
"
]];

player createDiaryRecord ["teamspeak",
[
"Armaworld",
"
<br /> Addresse: 146.0.35.28:11111
<br />
<br /> Jegliche Besucher und Gäste sind herzlichst Willkommen!
"
]];

player createDiaryRecord ["Diary", ["Special Thanks", "<br/>
        Bohemia Interactive<br/><br/>
        Tier1Ops<br/><br/>
        CAVE Gaming Community<br/><br/>
        Casual Arma Players<br/><br/>
        ACE3"]
];

player createDiaryRecord ["Diary", ["External Content", "<br/>
        ACE3 by ACE3 Dev Team.<br/><br/>
        VVS by Tonic.<br/><br/>
        ZLT field repair by Zealot.<br/><br/>
        ZBE Caching by Zorrobyte.<br/><br/>
        X-Cam by Siloa.<br/><br/>
        Defuse the bomb by cobra4v320.<br/><br/>
        Loadout and Crate Script By Joko"
        ]
];

player createDiaryRecord ["Diary", ["Dynamic Combat Generator", "Mission by SENSEI<br/><br/><img image='media\SEN_imgLogo.paa' width='128' height='64'/>"]];

// setup ACE3
[] call compile preprocessFileLineNumbers "scripts\SEN_ACE3Actions.sqf";
player setVariable ["ACE_canMoveRallypoint", false];

// setup radios
if (SEN_acreEnabled) exitWith {[] call compile preprocessFileLineNumbers "scripts\SEN_acre2.sqf";};
