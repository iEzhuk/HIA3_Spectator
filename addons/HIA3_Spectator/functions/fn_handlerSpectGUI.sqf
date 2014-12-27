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

PR(_event) = _this select 0;
PR(_arg) = _this select 1;
PR(_return) = false;

switch (_event) do 
{
	//=====================================================================
	//								DISAPLAY	
	//=====================================================================
	case "init":{		
		PR(_display) = _arg select 0;
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
		PR(_key)	= _arg select 1;
		PR(_shift)	= _arg select 2;
		PR(_ctrl)	= _arg select 3;
		PR(_alt)	= _arg select 4;

		if(_key == KEY_TAB) then {
			if(dialog) then {
				closeDialog 0;
			};
		};
	};
	case "update_playerlist" :
	{
		PR(_selectedSide) = _arg select 0;
		HIA3_Spectator_GUIExt_curSide = _selectedSide;

		PR(_display) = uiNamespace getVariable "HIA3_DisaplaySpectatorGUIext";
		if(isNil "_display") exitWith {
			diag_log "HIA3_spectator_fnc_handlerSpectGUI: <update_playerlist> _display is NULL";
		};
		
		// Update buttons
		PR(_ctrlInd) = IDC_SPECT_BUTTON_1;
		{
			PR(_side) = _x;
			PR(_count) = {alive _x && side _x == _side} count allUnits;

			PR(_ctrl) = _display displayCtrl _ctrlInd;	

			_ctrl ctrlSetText str(_count);
			_ctrl ctrlCommit 0;

			_ctrlInd = _ctrlInd + 1;
		} foreach [west,east,resistance,civilian];


		// Update list
		PR(_playerlist) = _display displayCtrl IDC_SPECT_PLAYERLIST;

		HIA3_Spectator_PlayerListGUIExt = [];

		PR(_ind) = 0; 
		lbClear _playerlist;
		{
			if(side _x == _selectedSide && alive _x) then {
				_playerlist lbAdd (NAME(_x));
				_playerlist lbSetData [_ind, str(_ind)];
				HIA3_Spectator_PlayerListGUIExt set [_ind, _x];
				_ind = _ind + 1;
			};
		} foreach HIA3_Spectator_UnitList;

		lbSort _playerlist;
	};
	case "playerList_lb_changed" : 
	{
		PR(_lbInd) = _arg select 1;

		PR(_display) = uiNamespace getVariable "HIA3_DisaplaySpectatorGUIext";
		if(isNil "_display") exitWith {
			diag_log "HIA3_spectator_fnc_handlerSpectGUI: <playerList_lb_changed> _display is NULL";
		};

		PR(_playerlist) = _display displayCtrl IDC_SPECT_PLAYERLIST;
		PR(_ind) = parseNumber(_playerlist lbData _lbInd);

		if(_ind < 0) exitWith {
			diag_log "HIA3_spectator_fnc_handlerSpectGUI: <playerList_lb_changed> _ind < 0";
		};

		PR(_unit) = HIA3_Spectator_PlayerListGUIExt select _ind;

		if(_unit in HIA3_Spectator_UnitList && alive _unit) then {
			[_unit] call HIA3_spectator_fnc_changeTargetUnit;
		} else {
			["update_playerlist", [HIA3_Spectator_GUIExt_curSide]] call HIA3_spectator_fnc_handlerSpectGUI;
			diag_log "HIA3_spectator_fnc_handlerSpectGUI: <playerList_lb_changed> unit is no found";
		};


	};
};
_return