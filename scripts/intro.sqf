if (!isPlayer player) exitWith {};
_handle = createdialog "AW_INTRO";
_time = 1800;
_times = 0;
{
    _code = compile format ["hint parseText ""%1""", _x];
    _times = _time + _times;
    [_code, [], _time] call ace_common_fnc_waitAndExecute;
    nil
} count [
    "<t align='center'><t size='2'><t color='#00B2EE'>Besucht uns auf unserer Homepage</t><br/><br/>_____________<br/><br/><t size='1.5'><t color='#ff0000'>www.armaworld.de<br/></t>",
    "<t align='center'><t size='1.5'><t color='#00ffff'>Teamspeak Pflicht</t><br/>  <t size='1.5'><br/>also betretet unseren Server<br/>  <br/><t color='#ff0000'>146.0.35.28:11111<br/></t>",
    "<t align='center'><t size='2'><t color='#00B2EE'>Besucht uns auf unserer Homepage</t><br/><br/>_____________<br/><br/><t size='1.5'><t color='#ff0000'>www.armaworld.de<br/></t>",
    "<t align='center'><t size='1.5'><t color='#00ffff'>Teamspeak Pflicht</t><br/>  <t size='1.5'><br/>also betretet unseren Server<br/>  <br/><t color='#ff0000'>146.0.35.28:11111<br/></t>"
];
