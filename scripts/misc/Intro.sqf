if (playerSide == west) then {
_handle=createdialog "AW_INTRO";
};

if (playerSide == west) then {
    sleep 1800;
    _Ts_Hint = "<t align='center'><t size='2'><t color='#00B2EE'>Besucht uns auf unserer Homepage</t><br/><br/>_____________<br/><br/><t size='1.5'><t color='#ff0000'>www.armaworld.de<br/></t>";
    TsHint = _Ts_Hint; publicVariable "TsHint"; hint parseText TsHint;
    TsHintLoop = false; publicVariable "TsHintLoop";
    sleep 1800;
    _Ts_Hint = "<t align='center'><t size='1.5'><t color='#00ffff'>Teamspeak Pflicht</t><br/>  <t size='1.5'><br/>also betretet unseren Server<br/>  <br/><t color='#ff0000'>146.0.35.28:11111<br/></t>";
    TsHintLoop = _Ts_Hint; publicVariable "TsHintLoop"; hint parseText TsHintLoop;
    sleep 1800;
    _Ts_Hint = "<t align='center'><t size='2'><t color='#00B2EE'>Besucht uns auf unserer Homepage</t><br/><br/>_____________<br/><br/><t size='1.5'><t color='#ff0000'>www.armaworld.de<br/></t>";
    TsHint = _Ts_Hint; publicVariable "TsHint"; hint parseText TsHint;
    TsHintLoop = false; publicVariable "TsHintLoop";
    sleep 1800;
    _Ts_Hint = "<t align='center'><t size='1.5'><t color='#00ffff'>Teamspeak Pflicht</t><br/>  <t size='1.5'><br/>also betretet unseren Server<br/>  <br/><t color='#ff0000'>146.0.35.28:11111<br/></t>";
    TsHintLoop = _Ts_Hint; publicVariable "TsHintLoop"; hint parseText TsHintLoop;
};
