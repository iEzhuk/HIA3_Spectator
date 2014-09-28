/*
 	Name: HIA3_spectator_fnc_clearMapMarkers
 	
 	Author(s):
		Ezhuk

 	Description:
		Remove all added markers 

	Parameters:
		Nothing

 	Returns:
		Nothing
*/

if(count HIA3_Spectator_ObjMarkers > 0) then {
	HIA3_Spectator_ObjMarkers = [];
	{
		if(["Spect_",_x] call BIS_fnc_inString) then 
		{
			deleteMarkerLocal _x;
		};
	} forEach allMapMarkers;
}