class param0 {
    title = "---------------------- Dynamic Combat Generator Parameters ----------------------";
    values[] = {1};
    texts[] = {""};
    default = 1;
   SEN_paramCode = "";
};
class param1 {
   title = "Debug Mode";
   values[] = {0,1};
   texts[] = {"Off", "On"};
   default = 0;
   SEN_paramCode = "";
};
class param2 {
   title = "Disable Third Person Camera";
   values[] = {0,1};
   texts[] = {"Off", "On"};
   default = 1;
   SEN_paramCode = "";
};
class param3 {
   title = "Time of Day";
   values[] = {-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23};
   texts[] = {"Random","00:00","01:00","02:00","03:00","04:00","05:00","06:00","07:00","08:00","09:00","10:00","11:00",
   "12:00","13:00","14:00","15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00"};
   default = 13;
   SEN_paramCode = "";
};
class param4 {
   title = "Enemy Side";
   values[] = {0,1};
   texts[] = {"East", "Independent"};
   default = 0;
   SEN_paramCode = "";
};
class param5 {
   title = "Enemy Patrols";
   values[] = {0,1};
   texts[] = {"Off", "On"};
   default = 1;
   SEN_paramCode = "";
};
class param6 {
   title = "Armored Patrol Count";
   values[] = {0,20,50,80, 120};
   texts[] = {"None", "Low", "Medium", "High", "Very High"};
   default = 20;
   SEN_paramCode = "";
};
class param7 {
   title = "Occupied Location Count";
   values[] = {1,2,3,4};
   texts[] = {"1", "2", "3", "4"};
   default = 2;
   SEN_paramCode = "";
};
class param8 {
   title = "Occupied Location Enemy Count";
   values[] = {20, 30, 40, 80, 120};
   texts[] = {"Low", "Medium", "High", "Very High", "To High to Play"};
   default = 40;
   SEN_paramCode = "";
};
class param9 {
    title = "Tasks Count";
    values[] = {1, 2, 3, 4, 5, 6, 7};
    texts[] = {"1", "2", "3", "4", "5", "6", "7"};
    default = 7;
   SEN_paramCode = "";
};
class param10 {
    title = "Occupied Location Visual Effects";
    values[] = {0,1};
    texts[] = {"Off","On"};
    default = 1;
   SEN_paramCode = "";
};
class param11 {
   title = "Use Modified Content if Available";
   values[] = {0,1};
   texts[] = {"Off","On"};
   default = 1;
   SEN_paramCode = "";
};
/*
class param12 {
   title = "---------------------- ACE 3 Parameters ----------------------";
   values[] = {1};
   texts[] = {""};
   default = 1;
   SEN_paramCode = "";
};
class param13 {
   title = "* requires Advanced Medical Level";
   values[] = {1};
   texts[] = {""};
   default = 1;
   SEN_paramCode = "";
};
class param14 {
   title = "Medical Level";
   values[] = {1,2};
   texts[] = {"Basic","Advanced"};
   default = 2;
   SEN_paramCode = "ace_medical_level = %1;";
};
class param15 {
   title = "Advanced Wounds *";
   values[] = {0,1};
   texts[] = {"Off","On"};
   default = 0;
   SEN_paramCode = "ace_medical_enableAdvancedWounds = %1;";
};
class param16 {
   title = "Player Damage Threshold";
   values[] = {8,12,16};
   texts[] = {"Low","Medium","High"};
   default = 12;
   SEN_paramCode = "ace_medical_playerDamageThreshold = ((%1)*0.1);";
};
class param17 {
   title = "Max Revive Time (minutes)";
   values[] = {60,300,600,900};
   texts[] = {"1","5","10","15"};
   default = 900;
   SEN_paramCode = "ace_medical_maxReviveTime = %1;";
};
class param18 {
   title = "Personal Aid Kit Usage *";
   values[] = {0,1};
   texts[] = {"Anyone","Medic Only"};
   default = 1;
   SEN_paramCode = "ace_medical_medicSetting_PAK = %1;";
};
class param19 {
   title = "Consume Personal Aid Kit *";
   values[] = {0,1};
   texts[] = {"No","Yes"};
   default = 1;
   SEN_paramCode = "ace_medical_consumeItem_PAK = %1;";
};
class param20 {
   title = "Personal Aid Kit Usage Location *";
   values[] = {0,1,2,3,4};
   texts[] = {"Anywhere","Medical Vehicles","Medical Facilities","Medical Vehicles and Facilities","Disabled"};
   default = 0;
   SEN_paramCode = "ace_medical_useLocation_PAK = %1;";
};
class param21 {
   title = "Personal Aid Kit Usage Condition *";
   values[] = {0,1};
   texts[] = {"Usable Any Time","Usable on Stable Patient"};
   default = 1;
   SEN_paramCode = "ace_medical_useCondition_PAK = %1;";
};
class param22 {
   title = "Surgical Kit Usage *";
   values[] = {0,1};
   texts[] = {"Anyone","Medic Only"};
   default = 1;
   SEN_paramCode = "ace_medical_medicSetting_SurgicalKit = %1;";
};
class param23 {
   title = "Consume Surgical Kit *";
   values[] = {0,1};
   texts[] = {"No","Yes"};
   default = 1;
   SEN_paramCode = "ace_medical_consumeItem_SurgicalKit = %1;";
};
class param24 {
   title = "Surgical Kit Usage Location *";
   values[] = {0,1,2,3,4};
   texts[] = {"Anywhere","Medical Vehicles","Medical Facilities","Medical Vehicles and Facilities","Disabled"};
   default = 3;
   SEN_paramCode = "ace_medical_useLocation_SurgicalKit = %1;";
};
class param25 {
   title = "Surgical Kit Usage Condition *";
   values[] = {0,1};
   texts[] = {"Usable Any Time","Usable on Stable Patient"};
   default = 1;
   SEN_paramCode = "ace_medical_useCondition_SurgicalKit = %1;";
};
class param26 {
   title = "Max View Distance (meters)";
   values[] = {3000,6000,9000};
   texts[] = {"3000","6000","9000"};
   default = 6000;
   SEN_paramCode = "ace_viewdistance_limitViewDistance = %1;";
};
class param27 {
   title = "Advanced Ballistics";
   values[] = {0,1};
   texts[] = {"Off","On"};
   default = 1;
   SEN_paramCode = "ace_advanced_ballistics_enabled = %1;";
};*/
