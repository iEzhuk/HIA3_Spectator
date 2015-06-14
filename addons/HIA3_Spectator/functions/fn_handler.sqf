/*
 	Name: HIA3_spectator_fnc_handler
 	
 	Author(s):
		Ezhuk

 	Description:
		Handler function for spectator
	
	Parameters:
		0 - STR: type of event
		1 - ARRAY: argument from event
 	
 	Returns:
		BOOL: for standart handlers 
*/

#include "defines.sqf"

PR(_event) = _this select 0;
PR(_arg) = _this select 1;
PR(_return) = false;

switch (_event) do 
{
	//=====================================================================
	//								DISAPLAY	
	//=====================================================================
	case "init":{		
		HIA3_Spectator_Enable = true;
		HIA3_Spectator_Fov = 0.7;
		HIA3_Spectator_EachFrame_Units = [];
		HIA3_Spectator_EachFrame_Vehs = [];
		HIA3_Spectator_ObjMarkers = [];
		HIA3_Spectator_DrawEvent = -1;
		HIA3_Spectator_TagType	= HIA3_Spectator_Tag min 2 max 0;
		HIA3_Spectator_CamVision = 0;
		HIA3_Spectator_MapVision = 0;
		HIA3_Spectator_ShowCrewVeh = true;
		HIA3_Spectator_ShowUnitList = true;
		HIA3_Spectator_MapShowName = false;
		HIA3_Spectator_MapShowName_NeedUpdate = false;
		HIA3_Spectator_CameraMode = "INTERNAL";
		HIA3_Spectator_ViewUnit = player;
		HIA3_Spectator_UnitList = [];
		HIA3_Spectator_State = SPECT_VIEWSTATE_INTERNAL; 
		HIA3_Spectator_Camera_AngV = 0;
		HIA3_Spectator_Keys = [];
		HIA3_Spectator_Buttons = [];
		HIA3_Spectator_HideControls = false;
		HIA3_Spectator_Hide3D = false;
		HIA3_Spectator_ShowDead = false; 
		HIA3_Spectator_MapShowDead = false; 
		HIA3_Spectator_EachFrame_DeadList = [];
		HIA3_Spectator_AttachCam_Angle = 0;
		HIA3_Spectator_AttachCam_Pos = [0, -7, 3];
		HIA3_Spectator_LastFrameTime = diag_tickTime;
		HIA3_Spectator_TraceBulletList = [];
		HIA3_Spectator_TraceBullet_On = false;

		PR(_display) = _arg select 0;
		uiNamespace setVariable ['HIA3_DisaplaySpectator', _display];
		HIA3_Spectator_DrawEvent = addMissionEventHandler ["Draw3D", "call HIA3_spectator_fnc_draw3D"];

		PR(_ctrlHelp) = _display displayCtrl IDD_SPECTATOR_HELP;
		_ctrlHelp ctrlShow false;

		call HIA3_spectator_fnc_updateTagList;

		[0] call HIA3_spectator_fnc_changeTargetUnit;
		SPECT_VIEWSTATE_INTERNAL call HIA3_spectator_fnc_InitNewCam;

		[] spawn HIA3_spectator_fnc_mainLoop;

		HIA3_Spectator_handKeyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "['disp_keyDown',_this] call HIA3_spectator_fnc_handler"];
		HIA3_Spectator_handKeyUp = (findDisplay 46) displayAddEventHandler ["KeyUp", "['disp_keyUp',_this] call HIA3_spectator_fnc_handler"];
		HIA3_Spectator_handMouseMoving = (findDisplay 46) displayAddEventHandler ["MouseMoving", "['disp_mouseMovie',_this] call HIA3_spectator_fnc_handler"];
		HIA3_Spectator_handMouseButtonDown = (findDisplay 46) displayAddEventHandler ["MouseButtonDown", "['disp_mouseButtonDown',_this] call HIA3_spectator_fnc_handler"];
		HIA3_Spectator_handMouseButtonUp = (findDisplay 46) displayAddEventHandler ["MouseButtonUp", "['disp_mouseButtonUp',_this] call HIA3_spectator_fnc_handler"];

		uiNamespace setVariable ['HIA3_SpectatorEvents', [_handKeyDown,_handKeyUp,_handMouseMoving,_handMouseButtonDown,_handMouseButtonUp]];

		[] spawn HIA3_spectator_fnc_mapLoop;
	};
	case "close":{
		HIA3_Spectator_Keys = [];
		camDestroy Local_Editor_Camera;

		removeMissionEventHandler ["Draw3D",HIA3_Spectator_DrawEvent];
		(findDisplay 46) displayRemoveEventHandler ["KeyDown"		 , HIA3_Spectator_handKeyDown];
		(findDisplay 46) displayRemoveEventHandler ["KeyUp"			 , HIA3_Spectator_handKeyUp];
		(findDisplay 46) displayRemoveEventHandler ["MouseMoving"	 , HIA3_Spectator_handMouseMoving];
		(findDisplay 46) displayRemoveEventHandler ["MouseButtonDown", HIA3_Spectator_handMouseButtonDown];
		(findDisplay 46) displayRemoveEventHandler ["MouseButtonUp"	 , HIA3_Spectator_handMouseButtonUp];

		HIA3_Spectator_Fov = nil;
		HIA3_Spectator_EachFrame_Units = nil;
		HIA3_Spectator_EachFrame_Vehs = nil;
		HIA3_Spectator_ObjMarkers = nil;
		HIA3_Spectator_EachFrame_Units = nil;
		HIA3_Spectator_EachFrame_Vehs = nil;
		HIA3_Spectator_ObjMarkers = nil;
		HIA3_Spectator_DrawEvent = nil;
		HIA3_Spectator_TagType	= nil;
		HIA3_Spectator_CamVision = nil;
		HIA3_Spectator_MapVision = nil;
		HIA3_Spectator_ShowCrewVeh	= nil;
		HIA3_Spectator_ShowUnitList = nil;
		HIA3_Spectator_MapShowName = nil;
		HIA3_Spectator_MapShowName_NeedUpdate = nil;
		HIA3_Spectator_CameraMode = nil;
		HIA3_Spectator_ViewUnit = nil;
		HIA3_Spectator_UnitList = nil;
		HIA3_Spectator_State = nil;
		HIA3_Spectator_Camera_AngV = nil;
		HIA3_Spectator_Keys = nil;
		HIA3_Spectator_Buttons = nil;
		HIA3_Spectator_HideControls = nil;
		HIA3_Spectator_Hide3D = nil;
		HIA3_Spectator_ShowDead = nil; 
		HIA3_Spectator_MapShowDead = nil;
		HIA3_Spectator_EachFrame_DeadList = nil;
		HIA3_Spectator_AttachCam_Angle = nil;
		HIA3_Spectator_AttachCam_Pos = nil;
		HIA3_Spectator_LastFrameTime = nil;
		HIA3_Spectator_TraceBulletList = nil;
		HIA3_Spectator_TraceBullet_On = nil;

		HIA3_Spectator_Enable = false;
	};
	case "disp_keyDown":{
		PR(_key)	= _arg select 1;
		PR(_shift)	= _arg select 2;
		PR(_ctrl)	= _arg select 3;
		PR(_alt)	= _arg select 4;

		// check ALT+TAB 
		if (_key == KEY_TAB && _alt) exitWith {
			HIA3_Spectator_Keys = [];
		};

		if (_key != KEY_ESCAPE) then {
			if !(_key in HIA3_Spectator_Keys) then {
				HIA3_Spectator_Keys = HIA3_Spectator_Keys + [_key];
			};
		};

		switch (_key) do {
			case KEY_TAB : {
				if (!dialog) then {
					createDialog "RscHIA3SpectatorGUIext";
				};
			};
			default {
				if (isNull findDisplay IDD_SPECTATOR_MAP_DISPLAY) then {
					switch (HIA3_Spectator_State) do
					{
						case SPECT_VIEWSTATE_INTERNAL :
						{
							_arg call HIA3_spectator_fnc_keyDown_Internal;
						};
						case SPECT_VIEWSTATE_FREE :
						{
							_arg call HIA3_spectator_fnc_keyDown_Free;
						};
						case SPECT_VIEWSTATE_ATTACH : 
						{
							_arg call HIA3_spectator_fnc_keyDown_Attach;
						};
					};
				};
			};
		};


		if (_key in actionKeys "ShowMap") then {
			_return = true;
		};
	};
	case "disp_keyUp" :
	{
		PR(_key)	= _arg select 1;
		PR(_shift)	= _arg select 2;
		PR(_ctrl)	= _arg select 3;
		PR(_alt)	= _arg select 4;

		HIA3_Spectator_Keys = HIA3_Spectator_Keys - [_key];

		if!(isNull findDisplay IDD_SPECTATOR_MAP_DISPLAY)exitWith{};

		// check ALT+TAB 
		if (_key == KEY_TAB && _alt) exitWith {
			HIA3_Spectator_Keys = [];
		};
		
		switch (_key) do
		{
			case (KEY_SPACE):
			{
				call HIA3_spectator_fnc_switchCameraState;
			};
			case (KEY_T):
			{
				PR(_mod) = (HIA3_Spectator_Tag min SPECT_TAG_NUM) max 1 min 3;
				if(HIA3_Spectator_SpecialAdmin && serverCommandAvailable('#kick')) then {
					_mod = 3
				};
				HIA3_Spectator_TagType = (HIA3_Spectator_TagType + 1)%_mod;
			};
			case (KEY_N):
			{
				PR(_mod) = if(HIA3_Spectator_FreeViewTI)then{4}else{2};
				if(HIA3_Spectator_SpecialAdmin && serverCommandAvailable('#kick')) then {
					_mod = 4
				};
				[(HIA3_Spectator_CamVision+1)%_mod] call HIA3_spectator_fnc_changeVisionType;
			};
			case (KEY_M):
			{

				if!(isNull findDisplay IDD_SPECTATOR_MAP_DISPLAY)exitWith{};
				createDialog "RscHIA3Specator_Map";
			};
			case (KEY_C):
			{
				PR(_display) = uiNamespace getVariable ['HIA3_DisaplaySpectator', 0];
				PR(_ctrlCrew) = _display displayCtrl 10013;
				if(HIA3_Spectator_ShowCrewVeh) then {
					HIA3_Spectator_ShowCrewVeh = false;
					_ctrlCrew ctrlSetPosition [-0.2*safezoneW+safezoneX,0.4*safezoneH+safezoneY];
					_ctrlCrew ctrlCommit 0;
				}else{
					HIA3_Spectator_ShowCrewVeh = true;
					_ctrlCrew ctrlSetPosition [0.0*safezoneW+safezoneX,0.4*safezoneH+safezoneY];
					_ctrlCrew ctrlCommit 0;
				};
			};
			case (KEY_H):
			{
				if(_ctrl) then {
					//Hide 3D 
					HIA3_Spectator_Hide3D = !HIA3_Spectator_Hide3D;
				}else{
					//Hide HUD
					PR(_display) = uiNamespace getVariable ['HIA3_DisaplaySpectator', 0];
					if(HIA3_Spectator_HideControls) then {
						{
							PR(_ctr) = _display displayCtrl _x;
							_ctr ctrlShow true;
						} foreach [	IDD_SPECTATOR_PLAYER_NAME,
									IDD_SPECTATOR_TIME,
									IDD_SPECTATOR_CREW,
									IDD_SPECTATOR_COUNT0,
									IDD_SPECTATOR_COUNT1,
									IDD_SPECTATOR_COUNT2,
									IDD_SPECTATOR_COUNT3];

						HIA3_Spectator_HideControls = false;
					}else{
						{
							PR(_ctr) = _display displayCtrl _x;
							_ctr ctrlShow false;
						} foreach [	IDD_SPECTATOR_PLAYER_NAME,
									IDD_SPECTATOR_TIME,
									IDD_SPECTATOR_CREW,
									IDD_SPECTATOR_COUNT0,
									IDD_SPECTATOR_COUNT1,
									IDD_SPECTATOR_COUNT2,
									IDD_SPECTATOR_COUNT3,
									IDD_SPECTATOR_HELP];
						
						HIA3_Spectator_HideControls = true;
					};
				};
			};
			case (KEY_F1):
			{
				PR(_display) = uiNamespace getVariable ['HIA3_DisaplaySpectator', 0];
				PR(_ctrlHelp) = _display displayCtrl IDD_SPECTATOR_HELP;
				if(ctrlShown _ctrlHelp) then {
					_ctrlHelp ctrlShow false;
				} else {
					_ctrlHelp ctrlShow true;
				};
			};
			case (KEY_K): 
			{
				if(HIA3_Spectator_ShowDead) then {
					HIA3_Spectator_ShowDead = false;
				} else {
					HIA3_Spectator_ShowDead = true;
				};
			};
			case (KEY_B):
			{
				// Only if freeveww mode is avalible
				if (HIA3_Spectator_FreeView && HIA3_Spectator_ShowEnemy) then {
					private ["_objects", "_unit"];
					if (HIA3_Spectator_TraceBullet_On) then {
						// Turn off bullet trace
						HIA3_Spectator_TraceBullet_On = false;

						_objects = HIA3_Spectator_TraceBulletList;
						for "_i" from 0 to ((count _objects) - 1) do {
							_unit = _objects select _i;
							[_unit,0] call HIA3_spectator_fnc_bulletTrace;
						};
					} else {
						// Turn on bullet trace
						if (_ctrl && _shift) then {
							HIA3_Spectator_TraceBullet_On = true;
							_objects = allUnits + vehicles;

							for "_i" from 0 to ((count _objects) - 1) do {
								_unit = _objects select _i;
								if (alive _unit) then {
									[_unit,2] call HIA3_spectator_fnc_bulletTrace;
								};
							};
						};
					};
				};	
			};
		};
		if(_key in [KEY_W,KEY_A,KEY_S,KEY_D,KEY_Q,KEY_Z]) then {
			[] call HIA3_spectator_fnc_stopCam;
		};
		if (_key in actionKeys "ShowMap") then {
			_return = true;
		};
	};
	case "disp_mouseMovie" :
	{
		PR(_nH) = _arg select 1;
		PR(_nV) = _arg select 2;

		if!(isNull findDisplay IDD_SPECTATOR_MAP_DISPLAY)exitWith{};

		if(dialog) exitWith {};

		switch (HIA3_Spectator_State) do
		{
			case SPECT_VIEWSTATE_INTERNAL :
			{

			};
			case SPECT_VIEWSTATE_FREE :
			{
				[_arg select 1, _arg select 2] call HIA3_spectator_fnc_rotateCamera;
			};
			case SPECT_VIEWSTATE_ATTACH :
			{
				[_arg select 1, _arg select 2] call HIA3_spectator_fnc_rotateCamera;
			};
		};

	};
	case "disp_mouseButtonUp" :
	{
		PR(_button) = _arg select 1;
		PR(_pX) = _arg select 2;
		PR(_pY) = _arg select 3;
		
		HIA3_Spectator_Buttons = HIA3_Spectator_Buttons - [_button];

		if!(isNull findDisplay IDD_SPECTATOR_MAP_DISPLAY)exitWith{};

		switch (HIA3_Spectator_State) do
		{
			case SPECT_VIEWSTATE_INTERNAL :
			{
				if(_button == MOUSE_RIGHT) then 
				{
					if(KEY_LCONTROL in HIA3_Spectator_Keys) then 
					{
						switch (HIA3_Spectator_CameraMode) do
						{
							case ("INTERNAL") :
							{
								HIA3_Spectator_CameraMode = "GUNNER";
							};
							case ("GUNNER") :
							{
								HIA3_Spectator_CameraMode = "EXTERNAL";
							};
							default{
								HIA3_Spectator_CameraMode = "INTERNAL";
							};
						};
					}else{
						switch (HIA3_Spectator_CameraMode) do
						{
							case ("INTERNAL") :
							{
								HIA3_Spectator_CameraMode = "GUNNER";
							};
							default{
								HIA3_Spectator_CameraMode = "INTERNAL";
							};
						};
					};
				};
			};
			case SPECT_VIEWSTATE_FREE :
			{

			};
		};
	};
	case "disp_mouseButtonDown" :
	{
		PR(_button) = _arg select 1;
		PR(_pX) = _arg select 2;
		PR(_pY) = _arg select 3;

		if !(_button in HIA3_Spectator_Buttons) then {
			HIA3_Spectator_Buttons = HIA3_Spectator_Buttons + [_button];
		};
	};
	case "disp_mouseButtonDblClick" :
	{

	};
};
_return