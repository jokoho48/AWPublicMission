/*
 * Author: joko // Jonas
 * Check Max count for Tanks/SPZ
 *
 * Arguments:
 *
 * Return Value:
 * isAllow to spawn the Vehicle <Bool>
 */

_classes = ["B_MBT_01_TUSK_F","B_MBT_01_cannon_F","CUP_B_M1A1_Woodland_USMC","CUP_B_M1A2_TUSK_MG_USMC","B_APC_Wheeled_01_cannon_F","CUP_B_LAV25_HQ_USMC","CUP_B_LAV25M240_USMC","CUP_B_LAV25_USMC","CUP_B_M113_USA","B_APC_Tracked_01_rcws_F","CUP_B_M2Bradley_USA_W","CUP_B_M2A3Bradley_USA_W","CUP_B_M6LineBacker_USA_W"];
if !(_x in _classes) exitWith {true};
!(2 => ({ typename _x in _classes} count vehicles));
