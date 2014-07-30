/*
 	Name: HIA3_spectator_fnc_changeVisionType
 	
 	Author(s):
		Ezhuk

 	Description:
		Change vision type (NORMAL, NV, TI)

	Parameters:
		Nothing
		
 	Returns:
		Nothing
*/

HIA3_Spectator_CamVision = _this select 0;
switch (HIA3_Spectator_CamVision) do {
	case 0: {
		camusenvg false;
		false SetCamUseTi 0;
	};
	case 1: {
		camusenvg true;
		false SetCamUseTi 0;
	};
	case 2: {
		camusenvg false;
		true SetCamUseTi 0;
	};
	case 3: {
		camusenvg false;
		true SetCamUseTi 4;
	};
};