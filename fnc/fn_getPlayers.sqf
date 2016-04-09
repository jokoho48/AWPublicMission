/*
Author: SENSEI

Last modified: 7/22/2014

Description: gets list of players

        returns array
__________________________________________________________________*/
private _players = allPlayers;

if (SEN_HCPresent) then {_players = _players - [SEN_HC]};

_players
