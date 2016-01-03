class Extended_Init_Eventhandlers {
    class AW_ins_base {
        class aw_comp {
            init = "_this call JK_fnc_randomGear;"
        };
    };
};

class Extended_PreInit_EventHandlers {
    aw_comp_init = "call compile preProcessFileLineNumbers 'fnc_init.sqf'; JK_fnc_randomGear = compile preProcessFileLineNumbers 'fnc_randomGear.sqf';";
};
