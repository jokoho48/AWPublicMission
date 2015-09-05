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
for "_i" from 1 to 5 do {player addItemToVest "rhsusf_20Rnd_762x51_m118_special_Mag";};
player addBackpack "rhsusf_assault_eagleaiii_ocp";
for "_i" from 1 to 7 do {player addItemToBackpack "ACE_fieldDressing";};
for "_i" from 1 to 3 do {player addItemToBackpack "ACE_packingBandage";};
player addItemToBackpack "ACE_tourniquet";
player addItemToBackpack "ACE_EarPlugs";
player addItemToBackpack "ACE_microDAGR";
player addItemToBackpack "ACE_MapTools";
player addHeadgear "rhsusf_ach_helmet_ocp";

comment "Add weapons";
player addWeapon "rhs_weap_m14ebrri";
player addPrimaryWeaponItem "rhsusf_acc_anpeq15side";
player addPrimaryWeaponItem "rhsusf_acc_LEUPOLDMK4";
player addWeapon "hgun_ACPC2_F";
player addWeapon "Rangefinder";

comment "Add items";
player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "tf_anprc152";
player linkItem "ItemGPS";

player addItemToBackpack "rhsusf_acc_ACOG3";
player addItemToBackpack "rhsusf_ANPVS_15";
player addItemToBackpack "muzzle_snds_B";

player setVariable ["ace_medical_medicClass", 0];