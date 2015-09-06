private ["_failedText"];

_failedText = "<t align='center'><t size='2.2'>Nebenmission</t><br/><t size='1.5' color='#b60000'>VERLOREN</t><br/>____________________<br/>
    Das nächste mal muss das besser funktionieren!<br/><br/><br/>Konzentriert euch jetzt auf unser Hauptziel; wir geben die schlechten Nachrichten jetzt ersteinmal an das Hauptquartier weiter. Mit etwas Glück haben wir bald ein neues Ziel ausgemacht.
    Wir melden uns in 15 - 30 Minuten wieder.</t>";

GlobalHint = _failedText; publicVariable "GlobalHint"; hint parseText _failedText;
