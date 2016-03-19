/*
    Name: HIA3_spectator_fnc_handlerSpectGUI

    Author(s):
        Ezhuk

    Description:
        Handler function for advanced dialog

    Parameters:
        0 - STR: type of event
        1 - ARRAY: argument from event

    Returns:
        BOOL: for standart handlers
*/

#include "defines.sqf"
params ["_event", "_arg"];
private _return = false;

switch (_event) do
{
    //=====================================================================
    //                              DISAPLAY
    //=====================================================================
    case "init":{
        _arg params ["_display"];
        uiNamespace setVariable ['HIA3_DisaplaySpectatorGUIext', _display];
        HIA3_Spectator_PlayerListGUIExt = [];
        HIA3_Spectator_GUIExt_curSide = playerSide;
        ["update_playerlist", [playerSide]] call HIA3_spectator_fnc_handlerSpectGUI;
    };
    case "close":{
        uiNamespace setVariable ['HIA3_DisaplaySpectatorGUIext', nil];
        HIA3_Spectator_PlayerListGUIExt = nil;
        HIA3_Spectator_GUIExt_curSide = nil;
    };
    case "disp_keyDown":{
        _arg params ["_disp", "_key", "_shift", "_ctrl", "_alt"];

        if(_key == KEY_TAB) then {
            if(dialog) then {
                closeDialog 0;
            };
        };
    };
    case "update_playerlist" :
    {
        _arg params ["_selectedSide"];
        HIA3_Spectator_GUIExt_curSide = _selectedSide;

        private _display = uiNamespace getVariable "HIA3_DisaplaySpectatorGUIext";
        if(isNil "_display") exitWith {
            diag_log "HIA3_spectator_fnc_handlerSpectGUI: <update_playerlist> _display is NULL";
        };

        // Update buttons
        private _ctrlInd = IDC_SPECT_BUTTON_1;
        {
            private _side = _x;
            private _count = {alive _x && side _x == _side} count allUnits;

            private _ctrl = _display displayCtrl _ctrlInd;

            _ctrl ctrlSetText str(_count);
            _ctrl ctrlCommit 0;

            _ctrlInd = _ctrlInd + 1;
        } foreach [west,east,resistance,civilian];


        // Update list
        private _playerlist = _display displayCtrl IDC_SPECT_PLAYERLIST;

        HIA3_Spectator_PlayerListGUIExt = [];

        private _ind = 0;
        lbClear _playerlist;
        {
            if(side _x == _selectedSide && alive _x) then {
                _txt = NAME(_x);
                if (vehicle _x != _x) then {
                    _txt = _txt + " - " + getText(configFile >> "CfgVehicles" >> typeOf (vehicle _x) >> "displayName");
                };
                _playerlist lbAdd _txt;
                _playerlist lbSetData [_ind, str(_ind)];
                HIA3_Spectator_PlayerListGUIExt set [_ind, _x];
                _ind = _ind + 1;
            };
        } foreach HIA3_Spectator_UnitList;

        lbSort _playerlist;
    };
    case "playerList_lb_changed" :
    {
        _arg params ["_ctrl", "_lbInd"];

        private _ind = parseNumber(_ctrl lbData _lbInd);

        if(_ind < 0) exitWith {
            diag_log "HIA3_spectator_fnc_handlerSpectGUI: <playerList_lb_changed> _ind < 0";
        };

        private _unit = HIA3_Spectator_PlayerListGUIExt select _ind;

        if(_unit in HIA3_Spectator_UnitList && alive _unit) then {
            [_unit] call HIA3_spectator_fnc_changeTargetUnit;

            if (HIA3_Spectator_State==SPECT_VIEWSTATE_FREE) then {
                call HIA3_spectator_fnc_switchCameraState;
            };
        } else {
            ["update_playerlist", [HIA3_Spectator_GUIExt_curSide]] call HIA3_spectator_fnc_handlerSpectGUI;
            diag_log "HIA3_spectator_fnc_handlerSpectGUI: <playerList_lb_changed> unit is no found";
        };
    };
};
_return
