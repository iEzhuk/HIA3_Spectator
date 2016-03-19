/*
    Name: HIA3_spectator_fnc_mapHandler

    Author(s):
        Ezhuk

    Description:
        Handler for full map

    Parameters:
        0 - type of event
        1 - argument from event

    Returns:
        Nothing
*/

#include "defines.sqf"

params ["_event", "_arg"];
private _return = false;

switch (_event) do
{
    case "init":{
        _arg params ["_dialog"];
        private _ctrlMap = _dialog displayCtrl IDD_SPECTATOR_MAP_MAP;

        uiNamespace setVariable ['HIA3_DisaplaySpectator_Map', _dialog];

        private _eventDraw = _ctrlMap ctrlAddEventHandler ["draw", "_this call HIA3_spectator_fnc_mapDraw"];

        uiNamespace setVariable ['HIA3_SpectatorMapEventDraw', [_eventDraw]];

        onMapSingleClick "['map_singleClick',[_pos]] call HIA3_spectator_fnc_mapHandler";
    };
    case "close":{
        private _dialog = uiNamespace getVariable ['HIA3_DisaplaySpectator_Map', 0];
        private _events = uiNamespace getVariable ["HIA3_SpectatorMapEventDraw",[]];
        private _ctrlMap = _dialog displayCtrl IDD_SPECTATOR_MAP_MAP;

        {_ctrlMap ctrlRemoveEventHandler ["draw",_x];} foreach _events;
        uiNamespace setVariable ['HIA3_DisaplaySpectator_Map', nil];

        onMapSingleClick "";
    };
    case "mapDraw":{

    };
    case "map_singleClick": {
        _arg params ["_pos"];
        if(KEY_LCONTROL in HIA3_Spectator_Keys) then {
            //===========================
            // Change target unit
            //===========================
            private _newVehs = nearestObjects [_pos, ["Man", "Air", "LandVehicle","Ship"], 200];
            private _ind = -1;
            // Find vehicle with crew
            params ["_veh", "_unit"];
            for "_i" from 0 to ((count _newVehs) - 1) do {
                if(_ind == -1) then {
                    _veh = _newVehs select _i;
                    if(alive _veh) then {
                        if(count crew _veh > 0) then {
                            _ind = _i;
                            _i = count _newVehs;

                            _unit = (crew _veh) select 0;
                            HIA3_Spectator_ViewUnit = _unit;

                            [0] call HIA3_spectator_fnc_changeTargetUnit;
                            HIA3_Spectator_State call HIA3_spectator_fnc_initNewCam;
                        };
                    };
                };
            };
        }else{
            //===========================
            // Change position ofcamera
            //===========================
            if(HIA3_Spectator_State == SPECT_VIEWSTATE_FREE) then {
                private _posCam = getPos HIA3_Spectator_Camera;
                private _newPos = [
                    _pos select 0,
                    _pos select 1,
                    _posCam select 2
                ];
                HIA3_Spectator_Camera camSetPos _newPos;

                HIA3_Spectator_Camera camCommitPrepared 0;
            };
        };
    };
    case "keyUp":{
        _arg params ["_disp", "_key", "_shift", "_ctrl", "_alt"];

        switch (_key) do
        {
            case (KEY_T):
            {
                if(!HIA3_Spectator_MapShowName_NeedUpdate) then {
                    HIA3_Spectator_MapShowName = !HIA3_Spectator_MapShowName;
                    HIA3_Spectator_MapShowName_NeedUpdate = true;
                };
            };
            case (KEY_K):
            {
                if(!HIA3_Spectator_MapShowName_NeedUpdate) then {
                    HIA3_Spectator_MapShowDead = !HIA3_Spectator_MapShowDead;
                    HIA3_Spectator_MapShowName_NeedUpdate = true;
                };
            };
            case (KEY_M):
            {
                closeDialog 0;
            };
        };
    };
};
_return
