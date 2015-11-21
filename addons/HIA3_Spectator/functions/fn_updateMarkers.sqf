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

private ["_unitList", "_oldObjMarkers", "_toDel", "_newObjMarkers", "_vehs", "_needUpdate", "_showName"];
_unitList = HIA3_Spectator_UnitList;
_oldObjMarkers = HIA3_Spectator_ObjMarkers;
_toDel = HIA3_Spectator_ObjMarkers;
_newObjMarkers = [];
_vehs = [];
_needUpdate = HIA3_Spectator_MapShowName_NeedUpdate;
_showName = HIA3_Spectator_MapShowName;

private ["_obj", "_veh", "_pos", "_marker", "_type", "_text", "_unit", "_type", "_size", "_color", "_Cmarker"];
for "_i" from 0 to (count _unitList - 1) do {
    _obj = _unitList select _i;
    _veh = vehicle _obj;
    _pos = getPos _veh;
    _marker = format["Spect_%1",_veh];
    if (alive _obj) then {
        if (!(_veh in _newObjMarkers)) then {
            if (_veh in _oldObjMarkers) then {
                _type = if(_obj==_veh)then{"mil_arrow2"}else{"mil_arrow"};
                if (_needUpdate) then {
                    _text = if(_veh==_obj)then{""}else{format ["(%1)",count (crew _veh)]};
                    if (_showName)then{
                        _unit = (crew _veh) select 0;
                        _text = format ["%1 %2",_text,NAME(_unit)];
                    } else {
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
            } else {
                _text = if(_veh==_obj)then{""}else{format ["(%1)",count (crew _veh)]};
                _type = if(_obj==_veh)then{"mil_arrow2"}else{"mil_arrow"};
                _size = if(_obj==_veh)then{[MARKER_SIZE_UNIT,MARKER_SIZE_UNIT]}else{[MARKER_SIZE_VEHICLE,MARKER_SIZE_VEHICLE]};
                _color = [side _obj] call HIA3_spectator_fnc_sideToColor;
                _Cmarker = createMarkerLocal[_marker, _pos];
                if (_showName) then{
                    _unit = (crew _veh) select 0;
                    _text = format ["%1 %2",_text,NAME(_unit)];
                } else {
                    if (_obj!=_veh) then{
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

            _newObjMarkers pushBack _veh;
        };
    };
};

if (HIA3_Spectator_MapShowDead) then {
    private ["_deadList", "_obj", "_pos", "_marker", "_text", "_Cmarker"];
    _deadList = allDead;
    for "_i" from 0 to (count _deadList - 1) do {
        _obj = _deadList select _i;
        if (_obj isKindOf "CAmanBase") then {
            _pos = getPos _obj;
            _marker = format["Spect_%1",_obj];
            if (!(_obj in _newObjMarkers)) then {
                if (_obj in _oldObjMarkers) then {
                    if (_needUpdate) then {
                        _text = "";
                        if (_showName) then{
                            _text = _obj getVariable ["PlayerName", "[AI]"];
                        };
                        _marker setMarkerTextLocal _text;
                    };
                    _marker setMarkerDirLocal getDir _obj;
                    _marker setMarkerPosLocal _pos;
                    _toDel = _toDel - [_obj];
                } else {
                    _text = "";
                    _Cmarker = createMarkerLocal[_marker, _pos];
                    if (_showName) then{
                        _text = _obj getVariable ["PlayerName", "[AI]"];
                    };
                    _Cmarker setMarkerTextLocal _text;
                    _Cmarker setMarkerShapeLocal "ICON";
                    _Cmarker setMarkerTypeLocal  "mil_arrow2";
                    _Cmarker setMarkerColorLocal "ColorBlack";
                    _Cmarker setMarkerDirLocal getDir _obj;
                    _Cmarker setMarkerSizeLocal [MARKER_SIZE_UNIT,MARKER_SIZE_UNIT];
                };
            };
            _newObjMarkers pushBack _obj;
        };
    };
};

for "_i" from 0 to (count _toDel - 1) do {
    _obj = _toDel select _i;
    deleteMarkerLocal format["Spect_%1",_obj];
};

if(isNil "HIA3_Spectator_UnitList") exitWith {};
HIA3_Spectator_ObjMarkers = _newObjMarkers;

if(isNil "HIA3_Spectator_MapShowName_NeedUpdate") exitWith {};
if(_needUpdate && HIA3_Spectator_MapShowName_NeedUpdate)then{
    HIA3_Spectator_MapShowName_NeedUpdate = false;
};
