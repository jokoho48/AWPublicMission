/*
| Author:
|
|    Quiksilver.
|_____
|
| Description:
|
|    Created: 26/11/2013.
|    Last modified:29/10/2014.
|    Coded for I&A and hosted on allfps.com.au servers.
|    You may use and edit the code.
|    You may not remove any entries from Credits without first removing the relevant author's contributions,
|    or asking permission from the mission authors/contributors.
|    You may not remove the Credits tab, without consent of Ahoy World or allFPS.
|     Feel free to re-format or make it look better.
|_____
|
| Usage:
|
|    Search below for the diary entries you would like to edit.
|    DiarySubjects appear in descending order when player map is open.
|    DiaryRecords appear in ascending order when selected.
|_____
|
| Credit:
|
|    Invade & Annex 2.00 was developed by Rarek [ahoyworld.co.uk] with hundreds of hours of work
|    The current version was developed by Quiksilver with hundreds more hours of work.
|
|    Contributors: Razgriz33 [AW], Jester [AW], Kamaradski [AW], David [AW], chucky [allFPS].
|
|    Please be respectful and do not remove credit.
|______________________________________________________________*/

if (!hasInterface) exitWith {};

waitUntil {!isNull player};

player createDiarySubject ["rules", "Regeln"];
player createDiarySubject ["teamspeak", "Teamspeak"];
player createDiarySubject ["faq", "FAQ"];
player createDiarySubject ["credits", "Credits"];

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
"Tactical Training Team",
"
<br /> Addresse: unff.de:1337
<br />
<br /> Jegliche Besucher und Gäste sind herzlichst Willkommen!
"
]];

//-------------------------------------------------- FAQ

player createDiaryRecord ["faq",
[
"UAVs",
"
<br /> In the Control Tower at base, a UAV Operator can now recycle the UAV crew on one of the computer terminals.
<br /><br />
<br /><font size='16'>Q:</font> Can I use the UAVs?<br />
<br /><font size='16'>A:</font> Yes, however you must be in the UAV Operator role and you must have a UAV Terminal.
<br />
<br />
<br /><font size='16'>Q:</font> Why do the UAVs keep exploding?<br />
<br /><font size='16'>A:</font> When the bomb-equipped UAVs are first connected to, the Gunner AI fires its weapons. Until it's fixed, here is a guide for you.<br />
<br /> To safely connect to the MQ4A Greyhawk UAV:<br />
<br />    1. Enter action menu (mouse scroll), click 'Open UAV Terminal'.
<br />    2. Right-click on the UAV you wish to control, on the terminal map.
<br />    3. Click 'Connect Terminal to UAV'.
<br /><br /> [IMPORTANT] Do NOT click 'Take Control' button in UAV Terminal.<br />
<br />    4. Esc out of the UAV terminal.
<br />    5. Enter action menu (mouse scroll) again.
<br />    6. [IMPORTANT] Select 'Take UAV TURRET controls'.<br />
<br />
<br />    It is now safe to 'Take Control' of the UAV.
<br />
<br />
<br /><font size='16'>Q:</font> Why can't I connect to the UAV?<br />
<br /><font size='16'>A:</font> Sometimes the UAVs are still connected to the prior Operators Terminal. If he disconnects or dies, sometimes the Terminal does not delete properly. The only solution at this time is to destroy the UAV, and you yourself must respawn.
"
]];

player createDiaryRecord ["faq",
[
"Squads",
"
<br /><font size='16'>Q:</font> How do I join a squad?<br />
<br /><font size='16'>A:</font>
<br /> 1. Hold 'T'.
<br /> 2. While holding T, use your scroll wheel to interact.
<br /> 3. You can interact with the person you are looking at, or those within a 5m radius.
<br />
<br /> * Xeno's Squad Management tool had to be removed at request of the script author.
"
]];

player createDiaryRecord ["faq",
[
"FOBs",
"
<br />Coming soon ...
"
]];

player createDiaryRecord ["faq",
[
"Bipod",
"
<br /><font size='16'>Q:</font> How do I deploy bipod?<br />
<br /><font size='16'>A:</font> Open the Mods tab and look for VTS weaponresting.
<br /> 1. Download and follow the instructions.
<br /> 2. Use when you are in a stable firing position.
<br /> 3. Default keys: Ctrl + Spacebar
<br />
<br /> ArmA 3 does not have integrated bipod function, so we have to use community-created mods to simulate.
"
]];

player createDiaryRecord ["faq",
[
"Medics",
"
<br /><font size='16'>Q:</font> Why can't I heal him?<br />
<br /><font size='16'>A:</font> There are three conditions you must pass in order to revive a fallen comrade.
<br /> 1. You must be in a Medic / Paramedic role.
<br /> 2. You must have a Medkit.
<br /> 3. You must have at least one First Aid Kit.
"
]];

player createDiaryRecord ["faq",
[
"Mortars",
"
<br /><font size='16'>Q:</font> Can I use the Mortars?
<br /><font size='16'>A:</font> Yes, However if you are not in the mortar gunner role you will not have acess to the Artillery Computer.<br />
<br /><font size='16'>Q:</font> How do I use the Mortar without the computer?
<br /><font size='16'>A:</font> You have to manually find the target with the sight. Here are some steps to use the mortar.
<br /> 1. Press the F key to select the firing distance.
<br /> 2. If you are in line-of-sight just put the cursor on the target and use the page up and page down keys to change the elevation.
<br /> 3. Fire!<br />
<br /><font size='16'>Here is a youtube video that can explain in more detail.<br />
<br /> https://www.youtube.com/watch?v=SCCvXfwzeAU
"
]];

//-------------------------------------------------- Credits

player createDiaryRecord ["credits",
[
"I & A",
"
<br />Mission authors:<br /><br />

        - <font size='16'>Rarek</font> - Ahoy World (ahoyworld.co.uk)<br /><br />
        - <font size='16'>Quiksilver</font><br />

<br />Contributors:<br /><br />
        - Jester - Ahoy World (ahoyworld.co.uk)<br />
        - Razgriz33 - Ahoy World (ahoyworld.co.uk)<br />
        - Kamaradski - Ahoy World (ahoyworld.co.uk)<br />
        - BACONMOP - Ahoy World (ahoyworld.co.uk)<br />
        - chucky - All FPS (allfps.com.au)<br /><br />

<br />Other:<br /><br />
        VAS<br />
        - Kronzky<br />
        - Sa-Matra<br />
        - Dslyecxi<br /><br />
        =BTC= Revive<br />
        - Giallustio<br />
        - Edited by Quiksilver<br/><br />
        EOS<br />
        - BangaBob<br /><br />
        Squad Manager<br />
        - aeroson<br /> <br />
        TAW View Distance<br />
        - Tonic<br /> <br />
        aw_fnc<br />
        - Alex Wise<br /><br />
        SHK Taskmaster<br />
        - Shuko<br /><br />
        Fast rope<br />
        - Zealot<br /><br />
        Map and GPS Icons (Soldier Tracker)<br />
        - Quiksilver<br /><br />
        Jump<br />
        - ProGamer<br /><br />
        Safe zone<br />
        - Bake<br />
        DAC<br />
        - Silola<br />
"
]];
