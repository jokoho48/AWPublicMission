if (!hasInterface) exitWith {};
private  ["_handle", "_time", "_times"];
_handle = createdialog "AW_INTRO";
_time = 120;
_times = 10;

{
    [{hint parseText (_this select 0)}, [_x], _times] call ace_common_fnc_waitAndExecute;
    _times = _time + _times;
    nil
} count [
    "<t align='center'><t size='2'><t color='#00B2EE'>Besucht uns auf unserer Homepage</t><br/><br/>_____________<br/><br/><t size='1.5'><t color='#ff0000'>www.armaworld.de<br/></t>",
    "<t align='center'><t size='1.5'><t color='#00ffff'>Teamspeak Pflicht</t><br/>  <t size='1.5'><br/>also betretet unseren Server<br/>  <br/><t color='#ff0000'>176.57.133.107<br/></t>",
    "<t align='center'><t size='2'><t color='#00B2EE'>Besucht uns auf unserer Homepage</t><br/><br/>_____________<br/><br/><t size='1.5'><t color='#ff0000'>www.armaworld.de<br/></t>",
    "<t align='center'><t size='1.5'><t color='#00ffff'>Teamspeak Pflicht</t><br/>  <t size='1.5'><br/>also betretet unseren Server<br/>  <br/><t color='#ff0000'>176.57.133.107<br/></t>"
];
