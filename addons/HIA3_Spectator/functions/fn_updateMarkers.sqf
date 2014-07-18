/*
 	Name: HIA3_spectator_fnc_updateMarkers
 	
 	Author(s):
		Ezhuk

 	Description:
		Update markers on map

	Parameters:
		Nothing
		
 	Returns:
		Nothing
*/
#include "defines.sqf"
	
#define MARKER_SIZE_UNIT 0.4
#define MARKER_SIZE_VEHICLE 0.5

if(isNil "HIA3_Spectator_UnitList") exitWith {};

PR(_unitList) = HIA3_Spectator_UnitList;
PR(_oldObjMarkers) = HIA3_Spectator_ObjMarkers;
PR(_toDel) = HIA3_Spectator_ObjMarkers;
PR(_newObjMarkers) = [];
PR(_indNOM) = 0;
PR(_vehs) = [];
PR(_needUpdate) = HIA3_Spectator_MapShowName_NeedUpdate;
PR(_showName) = HIA3_Spectator_MapShowName;

for "_i" from 0 to (count _unitList - 1) do {
	PR(_obj) = _unitList select _i;
	PR(_veh) = vehicle _obj;
	PR(_pos) = getPos _veh;
	PR(_marker) = format["Spect_%1",_veh];
	if(alive _obj) then {
		if(!(_veh in _newObjMarkers)) then {
			if(_veh in _oldObjMarkers) then {
				PR(_type) = if(_obj==_veh)then{"mil_arrow2"}else{"mil_arrow"};

				if(_needUpdate) then {
					PR(_text) = if(_veh==_obj)then{""}else{format ["(%1) ",count (crew _veh)]};
					if(_showName)then{
						_text = _text + name ((crew _veh) select 0);
					}else{
						if(_obj!=_veh)then{
							_text = _text + getText (configFile >> "CfgVehicles" >> (typeOf (_veh)) >> "displayName")
						};
					};
					_marker setMarkerTextLocal _text;
				};

				_marker setMarkerDirLocal getDir _veh;
				_marker setMarkerPosLocal _pos;
				_marker setMarkerTypeLocal _type;
				_toDel = _toDel - [_veh];
			}else{
				PR(_text) = if(_veh==_obj)then{""}else{format ["(%1) ",count (crew _veh)]};				
				PR(_type) = if(_obj==_veh)then{"mil_arrow2"}else{"mil_arrow"};
				PR(_size) = if(_obj==_veh)then{[MARKER_SIZE_UNIT,MARKER_SIZE_UNIT]}else{[MARKER_SIZE_VEHICLE,MARKER_SIZE_VEHICLE]};
				PR(_color) = [side _obj] call HIA3_spectator_fnc_sideToColor;
				PR(_Cmarker) = createMarkerLocal[_marker, _pos];

				if(_showName)then{
					_text = _text + name ((crew _veh) select 0);
				}else{
					if(_obj!=_veh)then{
						_text = _text + getText (configFile >> "CfgVehicles" >> (typeOf (_veh)) >> "displayName")
					};
				};

				_Cmarker setMarkerTextLocal _text;
				_Cmarker setMarkerShapeLocal "ICON";
				_Cmarker setMarkerTypeLocal  _type;
				_Cmarker setMarkerColorLocal _color;
				_Cmarker setMarkerDirLocal getDir _veh;
				_Cmarker setMarkerSizeLocal _size; 	
			};

			_newObjMarkers set [_indNOM,_veh];
			_indNOM = _indNOM + 1;
		};
	};
};

for "_i" from 0 to (count _toDel - 1) do {
	PR(_obj) = _toDel select _i;
	deleteMarkerLocal format["Spect_%1",_obj];
};

if(isNil "HIA3_Spectator_UnitList") exitWith {};
HIA3_Spectator_ObjMarkers = _newObjMarkers;

if(isNil "HIA3_Spectator_MapShowName_NeedUpdate") exitWith {};
if(_needUpdate && HIA3_Spectator_MapShowName_NeedUpdate)then{
	HIA3_Spectator_MapShowName_NeedUpdate = false;
};