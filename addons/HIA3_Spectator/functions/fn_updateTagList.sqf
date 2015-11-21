/*
 	Name: HIA3_spectator_fnc_updateTagList
 	
 	Author(s):
		Ezhuk

 	Description:
		Update information to draw 3D tags

	Parameters:
		Nothing

 	Returns:
		Nothing
*/
#include "defines.sqf"

if(isNil "HIA3_Spectator_State") exitWith {};

PR(_func_alpha) = {
	PR(_dist) = _this select 0;
	PR(_result) = 1;
	PR(_max) = 3000;
	PR(_min) = 500;
	if(_state == SPECT_VIEWSTATE_INTERNAL) then {
		_max = 100 max (viewDistance/2);
		_min = 10;
	}else{
		_max = 1000 max viewDistance;
		_min = 500;
	};

	0.1 max (1.0 min (1.0-0.9*(_dist-_min)/(_max-_min)))
};

//=======================================//
//           Find alive units            //
//=======================================//
PR(_newList) = [];
PR(_allUnits) = allUnits;
PR(_state) = HIA3_Spectator_State;

for "_i" from 0 to (count _allUnits - 1) do {
	PR(_unit) = _allUnits select _i;
	if(alive _unit) then {
		if(HIA3_Spectator_ShowEnemy || (HIA3_Spectator_SpecialAdmin && serverCommandAvailable('#kick'))) then {
			_newList pushBack _unit;
		}else{
			if(side _unit in ([HIA3_Spectator_Side] call BIS_fnc_friendlySides)) then {
				_newList pushBack _unit;
			};
		};
	};
};

if(isNil "HIA3_Spectator_UnitList") exitWith {};
HIA3_Spectator_UnitList = _newList;

PR(_uavs) = allUnitsUav;
PR(_deadList) = allDead;

//=======================================//
//               unit tags               //
//=======================================//
PR(_vehs) = [];
PR(_posCam) = call HIA3_spectator_fnc_currentPosition;
PR(_tmp) = [];
PR(_text) = "";
PR(_newUnits) = [];
PR(_newVehs) = [];
PR(_newDead) = [];


for "_i" from 0 to (count _newList - 1) do {
	PR(_unit) = _newList select _i;
	PR(_veh) = vehicle _unit;
	PR(_posVeh) = getPos _veh; 
	if(alive _unit) then {
		PR(_dist) = [_posCam select 0, _posCam select 1, 0] distance [_posVeh select 0, _posVeh select 1, 0];
		if(_dist < viewDistance+1500) then {
			PR(_color) = [side _unit] call BIS_fnc_sideColor;
			_color set [3, [_dist] call _func_alpha];

			if(_unit == _veh) then 
			{
				_newUnits pushBack [_unit, NAME(_unit), _color, [_unit] call HIA3_spectator_fnc_getIcon];
			}else{
				if(!(_veh in _vehs)) then {
					PR(_crew) = crew _veh;
					_text = format ["(%2) %1", NAME(_crew select 0), count _crew];
					_newVehs pushBack [_veh, _text, _color, [_veh] call HIA3_spectator_fnc_getIcon];
				};
			};
		};
	};
};

//=======================================//
//                UAV tags               //
//=======================================//

for "_i" from 0 to (count _uavs - 1) do {
	PR(_uav) = _uavs select _i;
	if(alive _uav) then {
		PR(_posVeh) = getPos _uav; 
		PR(_control) = uavControl _uav;
		PR(_color) = [side _uav] call BIS_fnc_sideColor;
		PR(_dist) = [_posCam select 0, _posCam select 1, 0] distance [_posVeh select 0, _posVeh select 1, 0];
		_text = "Disconnected";
		_color set [3, [_dist] call _func_alpha];

		if(count _control > 0) then {
			PR(_unit) = _control select 0;
			if(alive _unit) then {
				_text = NAME(_unit);
			};
		};
		_newVehs pushBack [_uav, _text, _color];
	};
};

//=======================================//
//                Dead tags              //
//=======================================//

for "_i" from 0 to (count _deadList - 1) do {
	PR(_obj) = _deadList select _i;
	if(_obj isKindOf "CAmanBase") then {
		PR(_pos) = getPos _obj;
		PR(_dist) = [_posCam select 0, _posCam select 1, 0] distance [_pos select 0, _pos select 1, 0];
		if(_dist < viewDistance+1500) then {
			PR(_color) = [0,0,0,0];
			PR(_text) = _obj getVariable ["PlayerName", "[AI]"];

			if (_text != "[AI]") then {
				_color = [_obj getVariable ["PlayerSide",side _obj]] call BIS_fnc_sideColor;
				_color set [0, (_color select 0)*0.15];
				_color set [1, (_color select 1)*0.15];
				_color set [2, (_color select 2)*0.15];
			};

			_color set [3, [_dist] call _func_alpha];

			_newDead pushBack [_obj, _text, _color];
		};
	};
};

if(isNil "HIA3_Spectator_EachFrame_Units") exitWith {};
if(isNil "HIA3_Spectator_EachFrame_Vehs") exitWith {};
if(isNil "HIA3_Spectator_EachFrame_DeadList") exitWith {};

HIA3_Spectator_EachFrame_Units = _newUnits;
HIA3_Spectator_EachFrame_Vehs = _newVehs;
HIA3_Spectator_EachFrame_DeadList = _newDead;