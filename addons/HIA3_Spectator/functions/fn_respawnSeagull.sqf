/*
	Name: HIA3_spectator_fnc_respawnSeagull
	
	Author(s):
		Ezhuk

	Description:
		Move seagull out of map

	Parameters:
		0 - seagull
		1 - player

	Returns:
		Nothing
*/

private ["_seagull"];
_seagull = _this select 0;

_seagull setPos [-5000,-5000,5000];

waituntil {missionnamespace getvariable ["BIS_fnc_feedback_allowDeathScreen",true]};
BIS_fnc_feedback_allowPP = false;
