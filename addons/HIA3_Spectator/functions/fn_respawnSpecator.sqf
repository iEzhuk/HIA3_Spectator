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
	titleCut ["", "BLACK IN", 0];

	BIS_fnc_feedback_allowPP = false;

	// Disable all PP effect
	"radialBlur" ppEffectEnable false; 
	"DynamicBlur" ppEffectEnable false; 
	"dynamicBlur" ppEffectEnable false; 
	"filmGrain" ppEffectEnable false; 
	"chromAberration" ppEffectEnable false; 

	// Hide map 
	forceMap false;

	// Launch spectator 
	("HIA3_SPECTATOR" call BIS_fnc_rscLayer) cutRsc ["RscHIA3Specator","PLAIN"];
};

if !(isNil "_seagull") then {
	_seagull setPos [-5000,-5000,5000];
};


