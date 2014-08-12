/*
 	Name: HIA3_spectator_fnc_respawnSpecator
 	
 	Author(s):
		Ezhuk

 	Description:
		Start HIA3 specator 
	
	Parameters:
		0 - seagull
		1 - player
 	
 	Returns:
		Nothing
*/
private ["_seagull"];

_seagull = _this select 0;

[] spawn {
	titleCut ["", "BLACK OUT", 4];

	sleep 8;

	BIS_fnc_feedback_allowPP = false;

	"radialBlur" ppEffectEnable false; 
	"DynamicBlur" ppEffectEnable false; 
	"dynamicBlur" ppEffectEnable false; 
	"filmGrain" ppEffectEnable false; 
	"chromAberration" ppEffectEnable false; 

	// Lauch spectator 
	cutRsc ["RscHIA3Specator","PLAIN"];
};

if !(isNil "_seagull") then {
	_seagull setPos [-5000,-5000,5000];
};


