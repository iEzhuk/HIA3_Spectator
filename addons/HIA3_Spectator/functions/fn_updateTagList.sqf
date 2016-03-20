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
private["_func_alpha"];
_func_alpha = {
    params ["_dist"];
    private ["_result", "_max", "_min"];
    _result = 1;
    _max = 1000 max viewDistance;
    _min = 500;
    if(_state == SPECT_VIEWSTATE_INTERNAL and HIA3_Spectator_ViewUnit == vehicle HIA3_Spectator_ViewUnit) then {
        _max = 100 max (viewDistance/2);
        _min = 10;
    };
    1.0 min (0.1 max (1.0-0.9*(_dist-_min)/(_max-_min)))
};

//=======================================//
//           Find alive units            //
//=======================================//
private _newList = [];
private _allUnits = allUnits;
private _state = HIA3_Spectator_State;

private["_unit"];
for "_i" from 0 to (count _allUnits - 1) do {
    _unit = _allUnits select _i;
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

private _uavs = allUnitsUav;
private _deadList = allDeadMen;

//=======================================//
//               Find alive units        //
//=======================================//
private _vehs = [];
private _posCam = [] call HIA3_spectator_fnc_currentPosition;
private _tmp = [];
private _text = "";
private _newUnits = [];
private _newVehs = [];
private _newDead = [];

private ["_unit", "_posVeh", "_dist", "_color", "_crew"];
for "_i" from 0 to (count _newList - 1) do {
    _unit = _newList select _i;
    _veh = vehicle _unit;
    _posVeh = getPos _veh;
    if(alive _unit) then {
        _dist = _posCam distance2D _posVeh;
        if(_dist < viewDistance+500) then {
            _color = [side _unit] call BIS_fnc_sideColor;
            _color set [3, [_dist] call _func_alpha];
            if(_unit == _veh) then
            {
                _newUnits pushBack [_unit, NAME(_unit), _color, [_unit] call HIA3_spectator_fnc_getIcon];
            }else{
                if(!(_veh in _vehs) and !(_veh in allUnitsUav)) then {
                    _crew = crew _veh;
                    _text = format ["(%2) %1", NAME(_crew select 0), {alive _x} count _crew];
                    _newVehs pushBack [_veh, _text, _color, [_veh] call HIA3_spectator_fnc_getIcon];
                    _vehs pushBack _veh;
                };
            };
        };
    };
};

//=======================================//
//                UAV tags               //
//=======================================//
private _vehs = [];
private ["_uav", "_control", "_posVeh"];
for "_i" from 0 to (count _uavs - 1) do {
    _uav = _uavs select _i;
    if(alive _uav) then {
        _posVeh = getPos _uav;
        _control = uavControl _uav;
        _color = [side _uav] call BIS_fnc_sideColor;
        _dist = [_posCam select 0, _posCam select 1, 0] distance [_posVeh select 0, _posVeh select 1, 0];
        _text = "Disconnected";
        _color set [3, [_dist] call _func_alpha];

        if(count _control > 0) then {
            _unit = _control select 0;
            if(alive _unit) then {
                _text = NAME(_unit);
            };
        };
        if(!(_uav in _vehs)) then {
            _newVehs pushBack [_uav, _text, _color];
            _vehs pushBack _uav;
        };
    };
};

//=======================================//
//                Dead tags              //
//=======================================//
for "_i" from 0 to (count _deadList - 1) do {
    _unit = _deadList select _i;
    if(_unit isKindOf "CAmanBase") then {
        _pos = getPos _unit;
        _dist = [_posCam select 0, _posCam select 1, 0] distance [_pos select 0, _pos select 1, 0];
        if(_dist < viewDistance+1500 and (getPosATL _unit select 2) > -10) then {
            _color = [0,0,0,0];
            _text = _unit getVariable ["PlayerName", "[AI]"];
            if (_text != "[AI]") then {
                _color = [_unit getVariable ["PlayerSide",side _unit]] call BIS_fnc_sideColor;
                _color set [0, (_color select 0)*0.2];
                _color set [1, (_color select 1)*0.2];
                _color set [2, (_color select 2)*0.2];
            };
            _color set [3, [_dist] call _func_alpha];
            _newDead pushBack [_unit, _text, _color];
        };
    };
};

if(isNil "HIA3_Spectator_EachFrame_Units") exitWith {};
if(isNil "HIA3_Spectator_EachFrame_Vehs") exitWith {};
if(isNil "HIA3_Spectator_EachFrame_DeadList") exitWith {};

HIA3_Spectator_EachFrame_Units = _newUnits;
HIA3_Spectator_EachFrame_Vehs = _newVehs;
HIA3_Spectator_EachFrame_DeadList = _newDead;
