comment "Exported from Arsenal by TheConen";

comment "Remove existing items";
removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;

comment "Add containers";
player forceAddUniform "rhs_uniform_cu_ocp_patchless";
for "_i" from 1 to 2 do {player addItemToUniform "SmokeShellGreen";};
player addItemToUniform "SmokeShellPurple";
for "_i" from 1 to 2 do {player addItemToUniform "SmokeShell";};
for "_i" from 1 to 2 do {player addItemToUniform "Chemlight_blue";};
for "_i" from 1 to 2 do {player addItemToUniform "9Rnd_45ACP_Mag";};
player addVest "rhsusf_iotv_ocp_Rifleman";
player addItemToVest "B_IR_Grenade";
player addItemToVest "rhs_mag_mk84";
player addItemToVest "rhs_mag_m67";
for "_i" from 1 to 2 do {player addItemToVest "rhsusf_100Rnd_762x51";};
player addBackpack "rhsusf_assault_eagleaiii_ocp";
for "_i" from 1 to 7 do {player addItemToBackpack "ACE_fieldDressing";};
for "_i" from 1 to 3 do {player addItemToBackpack "ACE_packingBandage";};
player addItemToBackpack "ACE_tourniquet";
player addItemToBackpack "ACE_EarPlugs";
player addItemToBackpack "ACE_microDAGR";
player addItemToBackpack "ACE_MapTools";
player addItemToBackpack "rhsusf_100Rnd_762x51";
player addHeadgear "rhsusf_ach_helmet_ocp";

comment "Add weapons";
player addWeapon "rhs_weap_m240B";
player addPrimaryWeaponItem "rhsusf_acc_ELCAN";
player addWeapon "hgun_ACPC2_F";
player addWeapon "Rangefinder";

comment "Add items";
player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "tf_anprc152";
player linkItem "ItemGPS";

player addItemToBackpack "rhsusf_ANPVS_15";

player setVariable ["ace_medical_medicClass", 0];

