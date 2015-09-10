/*
Variables %1 - %10 are hardcoded:
 %1 - small empty line
 %2 - bullet (for item in list)
 %3 - highlight start
 %4 - highlight end
 %5 - warning color formated for using in structured text tag
 %6 - BLUFOR color attribute
 %7 - OPFOR color attribute
 %8 - Independent color attribute
 %9 - Civilian color attribute
 %10 - Unknown side color attribute

 <t %7>text</t>
 */
class SEN_hint
{
    displayName = "Dynamic Combat Generator"; // display name for main class doesn't work. appears as <Mission> in Field Manual
    class SEN_overview
    {
        arguments[] = {};
        displayName = "Mission Overview";
        description = "Dynamic Combat Generator uses locations (towns, cities and capitals) as the basis for its systems.%1At the start of the mission enemy forces occupy a number of locations; they properly fortify and patrol the area based on the type of settlement.%1%1One of the occupied locations contains an enemy officer with valuable intel. The first objective is to gather said intel.%1%1From this point, DCG will generate a number of tasks based on the officer's information. Alongside the main tasks are civilian tasks that can influence the player's reputation with the locals.";
        tip = "";
        image = "media\SEN_imgLogoSquare.paa";
        noImage = false;
    };
    class SEN_addon
    {
        arguments[] = {};
        displayName = "Addon Integration";
        description = "%1%2ACE3 (depencency)%1%2ACRE2%1%2Task Force Arrowhead Radio%1%2RHS:USAF%1%2RHS:AFRF";
        tip = "";
        image = "media\SEN_imgLogoSquare.paa";
        noImage = false;
    };
    class SEN_headlessClient
    {
        arguments[] = {};
        displayName = "Headless Client";
        description = "DCG features headless client support to alleviate server strain.%1%2The headless client must be connected at mission start.%1%2Only occupied location units and patrol units will spawn on the headless client.";
        tip = "";
        image = "media\SEN_imgLogoSquare.paa";
        noImage = false;
    };
    class SEN_parameters
    {
        arguments[] = {};
        displayName = "Mission Parameters";
        description = "Debug Mode%1%2Toggles debug/test mode. All debug messages are logged to a rpt file.%1Disable Third Person Camera%1%2Disables third person view for players. This parameter does not affect players in vehicles.%1Time of Day%1%2Sets the mission time.%1Enemy Side%1%2Sets the enemy side.%1Enemy Patrols%1%2Toggles enemy patrols. Patrols consists of infantry and technical units that spawn around an occupied location. The number of patrols is dependent on map size.%1Armored Patrol Count%1%2Sets the amount of patrols that will be technicals.%1Occupied Location Count%1%2Sets the number of occupied locations.%1Occupied Location Enemy Count%1%2Sets the number of enemies to spawn in an occupied location.%1Task Count%1%2Sets the number of tasks that will spawn before mission complete. This number does not include civilian tasks.%1Occupied Location Visual Effects%1%2Toggles visual effects such as destroyed buildings and burning vehicles.%1Use Modified Content if Available%1%2Toggles the use of supported addon content that is used to spawn units and vehicles.";
        tip = "";
        image = "media\SEN_imgLogoSquare.paa";
        noImage = false;
    };
    class SEN_occupation
    {
        arguments[] = {};
        displayName = "Occupation";
        description = "At the start of the mission enemy forces will occupy a number of local settlements.%1%1While in conflict in an occupied location, enemies may surrender once players start to seize control of the settlement.%1%1Once an occupied location is liberated, players will be informed and the corresponding map markers will update.%1%1If the enemy officer is in the occupied location, his general area will be marked once players have seized the location.%1%1The following may appear at an occupied location.%1%2Garrisoned enemies%1%2Enemy snipers in the surrounding hills%1%2Motorized patrols%1%2Air patrols%1%2Static emplacements%1%2Manned towers";
        tip = "An occupied location's defenses depend on the size of the settlement. So, it may not be in a player's best interest to attack an occupied capital without a sizable force.%1%1The opposition may send reinforcements once players have liberated a location.";
        image = "media\SEN_imgLogoSquare.paa";
        noImage = false;
    };
    class SEN_armory
    {
        arguments[] = {};
        displayName = "Arsenal";
        description = "DCG uses Bohemia's Virtual Arsenal as the basis for its gear system. Players can access Arsenal at the headquarters. %1%1There is a %3Take Radio%4 action at the Arsenal box that will quickly equip the player with ACRE2 or TFAR equipment (see Communications Network tab for more info).%1%1In addition, there is an Ammo Station (noticeboard) at the headquarters that can spawn ammo/supply crates.";
        tip = "";
        image = "media\SEN_imgLogoSquare.paa";
        noImage = false;
    };
    class SEN_civInteraction
    {
        arguments[] = {};
        displayName = "Civilian Interaction";
        description = "Your civilian approval determines what kind of interaction you will have with the local population.%1%1Completing civilian tasks (C) and liberating occupied locations will improve your standing with civilians and encourage them to provide players with valuable intel, while killing civilians will negatively affect your approval.%1%1Civilian approval can be influenced by the FOB system (see Logistics tab).";
        tip = "Players can check their civilian approval through the ACE interaction menu.";
        image = "media\SEN_imgLogoSquare.paa";
        noImage = false;
    };
    class SEN_logistics
    {
        arguments[] = {};
        displayName = "Logistics";
        description = "Players have the option to construct an FOB away from MOB Dodge. FOB Pirelli has transportation and medical capabilities that can be accessed by the player constructing the FOB.%1%1Only one player may have control over FOB construction, however, players can request control through the ACE interaction menu.%1%1FOB Pirelli allows quick transportation to and from MOB Dodge.%1%1FOB Pirelli can be dismantled from the laptop in the headquarters at MOB Dodge.%1%1Once a HQ structure is placed at FOB Pirelli...%1%2Aerial recon will periodically mark enemies within a certain distance.%1%2The local population will be more inclined to cooperate with players if FOB Pirelli is properly built. Civilian approval is influenced by the FOB's readiness.";
        tip = "If a player disconnects while in control of FOB Pirelli, the next player to request control will take over.%1The Enemy Patrol mission parameter must be on to allow aerial recon.%1Civilian approval periodically gains a bonus based on FOB Pirelli's readiness.";
        image = "media\SEN_imgLogoSquare.paa";
        noImage = false;
    };
    class SEN_transportation
    {
        arguments[] = {};
        displayName = "Transportation";
        description = "Players can request an air transport at any time during the mission through the ACE interaction menu.%1%1Upon request, the requestor (player that initiated transport request) must select a suitable position via the map. Once the position is selected, a transport will move to said position and wait for the requestor to board.%1%1Next, the requestor must select another suitable position and the transport will move to the selected destination.";
        tip = "If a transport is destroyed, another will be available after a short time.%1If the requestor is in a team, the requestor should be the last person to mount and dismount the transport.";
        image = "media\SEN_imgLogoSquare.paa";
        noImage = false;
    };
    class SEN_comm
    {
        arguments[] = {};
        displayName = "Communications Network";
        description = "%3COMMAND%4 Net%1%2platoon commander%1%2alpha squad leader%1%2bravo squad leader%1%1%3SUPPORT%4 Net%1%2platoon sargent%1%2rhino team%1%2reaper team%1%1%3SQUAD%4 Net (squad specific)%1%2includes all units%1%1DCG features a default communications network that works alongside ACRE2 and TFAR to provide players with a logical communications structure.%1%1The comm net uses a Platoon level structure that features three basic nets, %3COMMAND%4, %3SUPPORT%4 and %3SQUAD%4.%1%1By default the %3COMMAND%4 net is limited to the platoon commander and squad leaders. This channel is for high level comms and connects the various elements.%1%1The %3SUPPORT%4 net connects the auxiliary elements to the platoon element. The platoon sargent (also the Forward Air Controller) oversees this network.%1%1The %3SQUAD%4 net contains all squad/team level communications. It is a different channel for each squad. Most players will operate on this network.%1%1To clarify, any individual that has access to the %3COMMAND%4 and %3SUPPORT%4 networks will also have access to the appropriate %3SQUAD%4 net.";
        tip = "You can customize the communications network to fit your needs. The files listed below contain comm net settings.%1%2initPlayerLocal.sqf%1%2scripts\SEN_tfr.sqf%1%2fnc\fn_setTfrRadio.sqf%1%2scripts\SEN_acre2.sqf%1%2fnc\fn_setAcreRadio.sqf";
        image = "media\SEN_imgLogoSquare.paa";
        noImage = false;
    };
    class SEN_task
    {
        arguments[] = {};
        displayName = "Task Tips";
        description = "%1%2In order to move an AI unit, the unit must be detained using cable ties.%1%2The gather intel action is integral to several tasks.%1%2Tasks prefaced with (C) represent civilian tasks.%1%2Some task related scenarios only occur if FOB Pirelli is deployed.";
        tip = "";
        image = "media\SEN_imgLogoSquare.paa";
        noImage = false;
    };
};