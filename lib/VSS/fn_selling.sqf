JK_fnc_isSellable = {
    vehicle player != player &&
    {(((vehicle player) getVariable ["JK_Price", 0]) =! 0)} &&
    {(player distance JK_sellingPoint) < 10}
};

JK_fnc_Sell = {

};

[player, "Sell Vehicle", JK_fnc_Sell, JK_fnc_isSellable] call JK_Core_fnc_addAction;

player addEventHandler["Respawn", {
    [player, "Sell Vehicle", JK_fnc_Sell, JK_fnc_isSellable] call JK_Core_fnc_addAction;
}];
