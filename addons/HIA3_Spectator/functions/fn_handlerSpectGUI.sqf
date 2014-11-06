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

		["update_playerlist", [playerSide]] call HIA3_spectator_fnc_handlerSpectGUI;
	};
	case "close":{
		uiNamespace setVariable ['HIA3_DisaplaySpectatorGUIext', nil];
		HIA3_Spectator_PlayerListGUIExt = nil;
	};
	case "disp_keyDown":{
		PR(_key)	= _arg select 1;
		PR(_shift)	= _arg select 2;
		PR(_ctrl)	= _arg select 3;
		PR(_alt)	= _arg select 4;

	};
	case "disp_keyUp" :
	{
		PR(_key)	= _arg select 1;
		PR(_shift)	= _arg select 2;
		PR(_ctrl)	= _arg select 3;
		PR(_alt)	= _arg select 4;

	};
	case "disp_mouseMovie" :
	{
		PR(_nH) = _arg select 1;
		PR(_nV) = _arg select 2;

	};
	case "disp_mouseButtonUp" :
	{
		PR(_button) = _arg select 1;
		PR(_pX) = _arg select 2;
		PR(_pY) = _arg select 3;
		
	};
	case "disp_mouseButtonDown" :
	{
		PR(_button) = _arg select 1;
		PR(_pX) = _arg select 2;
		PR(_pY) = _arg select 3;

	};
	case "disp_mouseButtonDblClick" :
	{

	};
	case "update_playerlist" :
	{
		PR(_selectedSide) = _arg select 0;


		PR(_display) = uiNamespace getVariable "HIA3_DisaplaySpectatorGUIext";
		if(isNil "_display") exitWith {
			diag_log "HIA3_spectator_fnc_handlerSpectGUI: <update_playerlist> _display is NULL";
		};
		
		// Update buttons
		PR(_ctrlInd) = IDC_SPECT_BUTTON_1;
		{
			PR(_side) = _x;
			PR(_count) = {alive _x && side _x == _side} count allUnits;
			PR(_color) = [_side] call BIS_fnc_sideColor;
			_color set [3,if(_selectedSide==_side)then{1.0}else{0.5}];
			systemChat str(_color);
			PR(_ctrl) = _display displayCtrl _ctrlInd;	

			_ctrl ctrlSetForegroundColor _color;
			_ctrl ctrlSetActiveColor _color;
			_ctrl ctrlSetBackgroundColor _color;
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
				if(isPlayer _x) then {
					_playerlist lbAdd (name _x);
				} else {
					_playerlist lbAdd format ["%1 (AI)",name _x];
				};
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

		if(_unit in HIA3_Spectator_UnitList) then {
			[_unit] call HIA3_spectator_fnc_changeTargetUnit;
		} else {
			diag_log "HIA3_spectator_fnc_handlerSpectGUI: <playerList_lb_changed> unit is no found";
		};
	};
};
_return