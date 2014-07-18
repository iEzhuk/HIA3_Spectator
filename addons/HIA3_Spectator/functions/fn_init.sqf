/*
 	Name: HIA3_spectator_fnc_init
 	
 	Author(s):
		Ezhuk

 	Description:
		Initialize HIA3 specator
	
	Parameters:
		Nothing 
 	
 	Returns:
		Nothing
*/

if(isNil "HIA3_Spectator_ShowEnemy") then {
	HIA3_Spectator_ShowEnemy = true;
};
if(isNil "HIA3_Spectator_Tag") then {
	HIA3_Spectator_Tag = 3;
};
if(isNil "HIA3_Spectator_FreeView") then {
	HIA3_Spectator_FreeView = true;
};
if(isNil "HIA3_Spectator_FreeViewTI") then {
	HIA3_Spectator_FreeViewTI = true;
};
if(isNil "HIA3_Spectator_SpecialAdmin") then {
	HIA3_Spectator_SpecialAdmin = true;
};
if(isNil "HIA3_Spectator_Side") then {
	HIA3_Spectator_Side = side player;
};

HIA3_Spectator_Enable = false;