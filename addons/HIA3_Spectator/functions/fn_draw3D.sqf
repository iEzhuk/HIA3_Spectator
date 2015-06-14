/*
 	Name: HIA3_spectator_fnc_draw3D
 	
 	Author(s):
		Ezhuk

 	Description:
		Drawing 3D tags

	Parameters:
		Nothing
		
 	Returns:
		Nothing
*/
#include "defines.sqf"

PR(_vehs) = [];
PR(_unit) = HIA3_Spectator_ViewUnit;

PR(_last_time) = HIA3_Spectator_LastFrameTime;
HIA3_Spectator_LastFrameTime = diag_tickTime;


if !(isNil {_unit}) then {
	//=======================================//
	//            Camera control             //
	//=======================================//
	if(HIA3_Spectator_State == SPECT_VIEWSTATE_INTERNAL) then 
	{
		_unit switchCamera "INTERNAL";
		vehicle _unit switchCamera HIA3_Spectator_CameraMode;
	};

	//=======================================//
	//        Conrole attached camera        //
	//=======================================//
	if(HIA3_Spectator_State == SPECT_VIEWSTATE_ATTACH) then 
	{
		// Time between two frame 
		PR(_d) = HIA3_Spectator_LastFrameTime - _last_time;

		if(_d < 0.3) then {
			PR(_curDir) = HIA3_Spectator_AttachCam_Angle;
			PR(_newPos) = HIA3_Spectator_AttachCam_Pos;


			PR(_mult) = switch (true) do {
							case (KEY_LCONTROL in HIA3_Spectator_Keys) : {2};
							case (KEY_LSHIFT in HIA3_Spectator_Keys) : {10};
							default {5};
						};

			PR(_dist) = _mult*_d;



			if(KEY_W in HIA3_Spectator_Keys) then { _newPos=[0  , _dist, 0, _newPos, _curDir] call HIA3_spectator_fnc_changePosition;};
			if(KEY_S in HIA3_Spectator_Keys) then { _newPos=[180, _dist, 0, _newPos, _curDir] call HIA3_spectator_fnc_changePosition;};
			if(KEY_A in HIA3_Spectator_Keys) then { _newPos=[-90, _dist, 0, _newPos, _curDir] call HIA3_spectator_fnc_changePosition;};
			if(KEY_D in HIA3_Spectator_Keys) then { _newPos=[90 , _dist, 0, _newPos, _curDir] call HIA3_spectator_fnc_changePosition;};

			if(KEY_Q in HIA3_Spectator_Keys) then { _newPos=[0, 0,  _dist, _newPos, _curDir] call HIA3_spectator_fnc_changePosition;};
			if(KEY_Z in HIA3_Spectator_Keys) then { _newPos=[0, 0, -_dist, _newPos, _curDir] call HIA3_spectator_fnc_changePosition;};

			HIA3_Spectator_AttachCam_Pos = _newPos;

			HIA3_Spectator_Camera attachTo [vehicle HIA3_Spectator_ViewUnit, HIA3_Spectator_AttachCam_Pos];

		};

	};
};



if(HIA3_Spectator_Hide3D) exitWith {};

if !(isNil {_unit}) then {
	PR(_pos) = visiblePosition vehicle _unit;
	PR(_color) = if(alive _unit)then{[side _unit] call BIS_fnc_sideColor}else{[0,0,0,1]};

	if(HIA3_Spectator_State == SPECT_VIEWSTATE_FREE && count _pos == 3 && HIA3_Spectator_TagType != SPECT_TAG_NAME) then {
		if(_unit == vehicle _unit) then{
			PR(_posEye) = if(!(surfaceIsWater _pos))then{ASLtoATL eyePos _unit}else{eyePos _unit};
			_pos set [2,(_posEye select 2) + 0.5];
		}else{
			_pos set [2,(_pos select 2) + 4];
		};
		// target icon 
		drawIcon3D ["\A3\ui_f\data\map\groupicons\selector_selectedFriendly_ca.paa", _color, _pos, 1, 1, 2, "", 2, 0.05, "PuristaMedium"];
	};
};

switch (HIA3_Spectator_TagType) do
{
	case SPECT_TAG_ICON :
	{

		for "_i" from 0 to (count HIA3_Spectator_EachFrame_Vehs - 1) do {
			PR(_vehInfo) = HIA3_Spectator_EachFrame_Vehs select _i;
			PR(_pos) = visiblePosition (_vehInfo select 0);

			_pos set [2,(_pos select 2) + 4];
			drawIcon3D ["a3\ui_f\data\map\markers\military\box_CA.paa", (_vehInfo select 2),_pos, 0.9, 0.9, 2, "", 2, 0.0, "PuristaMedium"];
		};
		for "_i" from 0 to (count HIA3_Spectator_EachFrame_Units - 1) do {
			PR(_unitInfo) = HIA3_Spectator_EachFrame_Units select _i;
			PR(_pos) = visiblePosition (_unitInfo select 0);
			PR(_posEye) = if(!(surfaceIsWater _pos))then{ASLtoATL eyePos (_unitInfo select 0)}else{eyePos (_unitInfo select 0)};

			_pos set [2,(_posEye select 2) + 0.5];
			drawIcon3D ["a3\ui_f\data\map\VehicleIcons\iconexplosiveat_ca.paa", (_unitInfo select 2),_pos, 0.65, 0.65, 2, "", 2, 0.0, "PuristaMedium"];
		};

		if (HIA3_Spectator_ShowDead) then {
			for "_i" from 0 to (count HIA3_Spectator_EachFrame_DeadList - 1) do {
				PR(_unitInfo) = HIA3_Spectator_EachFrame_DeadList select _i;
				PR(_pos) = visiblePosition (_unitInfo select 0);
				PR(_posEye) = if(!(surfaceIsWater _pos))then{ASLtoATL eyePos (_unitInfo select 0)}else{eyePos (_unitInfo select 0)};

				_pos set [2,(_posEye select 2) + 0.5];
				drawIcon3D ["a3\ui_f\data\map\VehicleIcons\iconexplosiveat_ca.paa", (_unitInfo select 2),_pos, 0.65, 0.65, 2, "", 2, 0.0, "PuristaMedium"];
			};
		} else {
			HIA3_Spectator_DeadList = [];
		};
	};
	case SPECT_TAG_NAME :
	{
		for "_i" from 0 to (count HIA3_Spectator_EachFrame_Vehs - 1) do {
			PR(_vehInfo) = HIA3_Spectator_EachFrame_Vehs select _i;
			PR(_pos) = visiblePosition (_vehInfo select 0);

			_pos set [2,(_pos select 2) + 4];
			drawIcon3D ["", (_vehInfo select 2),_pos, 0.0, 0.0, 2, (_vehInfo select 1), 2, 0.036, "PuristaMedium"];
		};
		for "_i" from 0 to (count HIA3_Spectator_EachFrame_Units - 1) do {
			PR(_unitInfo) = HIA3_Spectator_EachFrame_Units select _i;
			PR(_pos) = visiblePosition (_unitInfo select 0);
			PR(_posEye) = if(!(surfaceIsWater _pos))then{ASLtoATL eyePos (_unitInfo select 0)}else{eyePos (_unitInfo select 0)};

			_pos set [2,(_posEye select 2) + 0.5];
			drawIcon3D ["", (_unitInfo select 2),_pos, 0.0, 0.0, 2, (_unitInfo select 1), 2, 0.036, "PuristaMedium"];
		};

		if (HIA3_Spectator_ShowDead) then {
			for "_i" from 0 to (count HIA3_Spectator_EachFrame_DeadList - 1) do {
				PR(_unitInfo) = HIA3_Spectator_EachFrame_DeadList select _i;
				PR(_pos) = visiblePosition (_unitInfo select 0);
				PR(_posEye) = if(!(surfaceIsWater _pos))then{ASLtoATL eyePos (_unitInfo select 0)}else{eyePos (_unitInfo select 0)};

				_pos set [2,(_posEye select 2) + 0.5];
				drawIcon3D ["", (_unitInfo select 2),_pos, 0.0, 0.0, 2, (_unitInfo select 1), 2, 0.036, "PuristaMedium"];
			};
		} else {
			HIA3_Spectator_DeadList = [];
		};
	};
};

