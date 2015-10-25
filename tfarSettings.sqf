if(hasInterface) then {
	private ["_swFreq","_swRadio","_lrFreq","_lrRadio","_i","_size"];
	 _swFreq = ["110","120","130","140","150","160","100","30"];
	if(call TFAR_fnc_haveSWRadio) then {
		_size = count _swFreq;
		_i = 0;
		_swRadio = call TFAR_fnc_activeSwRadio;
		while {_i < 9 && _i < _size} do {
			[_swRadio, (_i + 1), (_swFreq select _i)] call TFAR_fnc_SetChannelFrequency;
			_i = _i + 1;
		};
	};

	_lrFreq = ["30","31","32","33","34","35","36","37","38"];
	if(call TFAR_fnc_haveLRRadio) then {
		_size = count _lrFreq;
		_i = 0;
		_lrRadio = call TFAR_fnc_activeLrRadio;
		while {_i < 10 && _i < _size} do {
			[_lrRadio, (_i+1), (_lrFreq select _i)] call TFAR_fnc_SetChannelFrequency;
			_i = _i + 1;
		};
	};
};
