/*
	Name: HIA3_spectator_fnc_precompile
	
	Author(s):
		Ezhuk
*/

HIA3_spectator_fnc_changePosition	= compileFinal preprocessFile ("HIA3_Spectator\functions\fn_changePosition.sqf");
HIA3_spectator_fnc_changeTargetUnit	= compileFinal preprocessFile ("HIA3_Spectator\functions\fn_changeTargetUnit.sqf");
HIA3_spectator_fnc_changeVisionType	= compileFinal preprocessFile ("HIA3_Spectator\functions\fn_changeVisionType.sqf");
HIA3_spectator_fnc_clearMapMarkers	= compileFinal preprocessFile ("HIA3_Spectator\functions\fn_clearMapMarkers.sqf");
HIA3_spectator_fnc_currentDir		= compileFinal preprocessFile ("HIA3_Spectator\functions\fn_currentDir.sqf");
HIA3_spectator_fnc_currentPosition	= compileFinal preprocessFile ("HIA3_Spectator\functions\fn_currentPosition.sqf");
HIA3_spectator_fnc_draw3D			= compileFinal preprocessFile ("HIA3_Spectator\functions\fn_draw3D.sqf");
HIA3_spectator_fnc_handler			= compileFinal preprocessFile ("HIA3_Spectator\functions\fn_handler.sqf");
HIA3_spectator_fnc_handlerSpectGUI	= compileFinal preprocessFile ("HIA3_Spectator\functions\fn_handlerSpectGUI.sqf");
HIA3_spectator_fnc_initModule		= compileFinal preprocessFile ("HIA3_Spectator\functions\fn_initModule.sqf");
HIA3_spectator_fnc_initNewCam		= compileFinal preprocessFile ("HIA3_Spectator\functions\fn_initNewCam.sqf");
HIA3_spectator_fnc_keyDown_Free		= compileFinal preprocessFile ("HIA3_Spectator\functions\fn_keyDown_Free.sqf");
HIA3_spectator_fnc_keyDown_Internal	= compileFinal preprocessFile ("HIA3_Spectator\functions\fn_keyDown_Internal.sqf");
HIA3_spectator_fnc_mainLoop			= compileFinal preprocessFile ("HIA3_Spectator\functions\fn_mainLoop.sqf");
HIA3_spectator_fnc_mapDraw			= compileFinal preprocessFile ("HIA3_Spectator\functions\fn_mapDraw.sqf");
HIA3_spectator_fnc_mapHandler		= compileFinal preprocessFile ("HIA3_Spectator\functions\fn_mapHandler.sqf");
HIA3_spectator_fnc_mapLoop			= compileFinal preprocessFile ("HIA3_Spectator\functions\fn_mapLoop.sqf");
HIA3_spectator_fnc_moveCamera		= compileFinal preprocessFile ("HIA3_Spectator\functions\fn_moveCamera.sqf");
HIA3_spectator_fnc_respawnSeagull	= compileFinal preprocessFile ("HIA3_Spectator\functions\fn_respawnSeagull.sqf");
HIA3_spectator_fnc_respawnSpecator	= compileFinal preprocessFile ("HIA3_Spectator\functions\fn_respawnSpecator.sqf");
HIA3_spectator_fnc_rotateCamera		= compileFinal preprocessFile ("HIA3_Spectator\functions\fn_rotateCamera.sqf");
HIA3_spectator_fnc_sideToColor		= compileFinal preprocessFile ("HIA3_Spectator\functions\fn_sideToColor.sqf");
HIA3_spectator_fnc_stopCam			= compileFinal preprocessFile ("HIA3_Spectator\functions\fn_stopCam.sqf");
HIA3_spectator_fnc_switchCameraState= compileFinal preprocessFile ("HIA3_Spectator\functions\fn_switchCameraState.sqf");
HIA3_spectator_fnc_updateMarkers	= compileFinal preprocessFile ("HIA3_Spectator\functions\fn_updateMarkers.sqf");
HIA3_spectator_fnc_updateTagList	= compileFinal preprocessFile ("HIA3_Spectator\functions\fn_updateTagList.sqf");


//================================================
//					CLIENT
//================================================

if(!isDedicated) then {
	[] spawn {
		waitUntil{!isNil {player}};

		if(isNil "HIA3_Spectator_PlayerListGUIExt") then {
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
	};
};