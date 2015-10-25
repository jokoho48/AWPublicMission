if(hasInterface) then {
	private ["_swFreq","_swRadio","_lrFreq","_lrRadio"];
	_swFreq = ["110","120","130","140","150","160","100","30"];
	if(call TFAR_fnc_haveSWRadio) then {
		_swFreq resize (count _swFreq min 8);
		_swRadio = call TFAR_fnc_activeSwRadio;
		{
			[_swRadio, (_forEachIndex + 1), _x] call TFAR_fnc_SetChannelFrequency;
		} foreach _swFreq;
	};

	_lrFreq = ["30","31","32","33","34","35","36","37","38"];
	if(call TFAR_fnc_haveLRRadio) then {
		_lrFreq resize (count _lrFreq min 9);
		_lrRadio = call TFAR_fnc_activeLrRadio;
		{
			[_lrRadio, (_forEachIndex + 1), _x] call TFAR_fnc_SetChannelFrequency;
		} foreach _lrFreq;
	};
};
