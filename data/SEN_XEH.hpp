class Extended_Hit_Eventhandlers {
    class Civilian {
        class SEN_civ_hit {
            // runs where unit is local
            hit = "_this call SEN_fnc_civHit";
        };
    };
};
class Extended_PostInit_EventHandlers
{
    class st_map_gestures
    {
        clientInit = "st_map_gestures_init_ext_post_eh = [] spawn compile preprocessFileLineNumbers 'lib\mapGestures\clientInit.sqf'";
        serverInit = "st_map_gestures_svr_init_ext_post_eh = [] spawn compile preprocessFileLineNumbers 'lib\mapGestures\clientInit.sqf'";
    };
};
