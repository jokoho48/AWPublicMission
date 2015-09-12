// by Astavinu edit by joko // Jonas
private "_text";
params["_object", "_msg"];
_text = format["<img image='%1' size='2' align='left'/>", getText(configFile >> "cfgVehicles" >> typeOf _object >> "picture")];
_text = _text + format ["<t color='#ff0000' size='1.2' shadow='1' shadowColor='#000000' align='center'>%1</t><br/>", getText(configFile >> "cfgVehicles" >> typeOf _object >> "displayName")];
_text = _text + "<t height='0.2'> </t><br/>";
_text = _text + format["<t color='#ffffff' size='1' shadow='1' shadowColor='#000000' align='left'>%1 </t>", localize "STR_JK_REPAIR_DAMAGE"];
_text = _text + format ["<t color='#ffff00' size='1' shadow='1' shadowColor='#000000' align='left'>%1%2</t><br/>", floor ((damage _object)*100), "%"];

_text = _text + format["<t color='#ffffff' size='1' shadow='1' shadowColor='#000000' align='left'>%1 </t>", localize "STR_JK_REPAIR_FUEL"];
_text = _text + format ["<t color='#ffff00' size='1' shadow='1' shadowColor='#000000' align='left'>%1%2</t><br/>", ceil ((fuel _object)*100), "%"];
_text = _text + format ["<t color='#ffffff' size='1' shadow='1' shadowColor='#000000' align='left'>%1 </t>", localize "STR_JK_REPAIR_MAG"];
_text = _text + format ["<t color='#ffff00' size='1' shadow='1' shadowColor='#000000' align='left'>%1</t><br/>", _object getVariable ["JK_MagazineReloading", localize "STR_JK_REPAIR_NOMAG"]];
if(!isNil "_msg")  then {
    _text = _text + "<t height='0.2'> </t><br/>";
    _text = _text + format ["<t color='#ffffff' size='0.8' shadow='1' shadowColor='#000000' align='left'>%1</t>", _msg] ;
};
hintSilent parseText (_text);
