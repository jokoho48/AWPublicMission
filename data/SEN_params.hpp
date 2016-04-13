class param0 {
    title = "---------------------- Dynamic Combat Generator Parameters ----------------------";
    values[] = {1};
    texts[] = {""};
    default = 1;
};
class param1 {
    title = "Debug Mode";
    values[] = {0,1};
    texts[] = {"Off", "On"};
    default = 0;
};
class param2 {
    title = "Disable Third Person Camera";
    values[] = {0,1};
    texts[] = {"Off", "On"};
    default = 1;
};
class param3 {
    title = "Time of Day";
    values[] = {-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23};
    texts[] = {"Random","00:00","01:00","02:00","03:00","04:00","05:00","06:00","07:00","08:00","09:00","10:00","11:00",
    "12:00","13:00","14:00","15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00"};
    default = -1;
};
class param4 {
    title = "Enemy Side";
    values[] = {0,1};
    texts[] = {"East", "Independent"};
    default = 0;
};
class param5 {
    title = "Enemy Patrols";
    values[] = {0,1};
    texts[] = {"Off", "On"};
    default = 1;
};
class param6 {
    title = "Armored Patrol Count";
    values[] = {0,20,50,80, 120};
    texts[] = {"None", "Low", "Medium", "High", "Very High"};
    default = 50;
};
class param7 {
    title = "Occupied Location Count";
    values[] = {1,2,3,4};
    texts[] = {"1", "2", "3", "4"};
    default = 1;
};
class param8 {
    title = "Occupied Location Enemy Count";
    values[] = {20, 30, 40, 80, 120};
    texts[] = {"Low", "Medium", "High", "Very High", "To High to Play"};
    default = 80;
};
class param9 {
    title = "Tasks Count";
    values[] = {1, 2, 3, 4, 5, 6, 7};
    texts[] = {"1", "2", "3", "4", "5", "6", "7"};
    default = 7;
};
class param10 {
    title = "Occupied Location Visual Effects";
    values[] = {0,1};
    texts[] = {"Off","On"};
    default = 1;
};
class param11 {
    title = "Use Modified Content if Available";
    values[] = {0,1};
    texts[] = {"Off","On"};
    default = 1;
};
class param13 {
    title = "Town Group Size";
    values[] = {2,4,6,8};
    texts[] = {"Small", "Medium", "Default", "High"};
    default = 6;
};
