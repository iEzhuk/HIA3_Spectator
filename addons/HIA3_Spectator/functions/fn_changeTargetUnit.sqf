/*
 	Name: HIA3_spectator_fnc_changeTargetUnit
 	
 	Author(s):
		Ezhuk

 	Description:
		Change target unit

	Parameters:
		0 - Offset by current target
	or
		0 - unit
 	Returns:
		Nothing
*/
#include "defines.sqf"

if(isNil "HIA3_Spectator_UnitList") exitWith {};

switch (typeName (_this select 0)) do 
{
	case "SCALAR" : {
		if(count HIA3_Spectator_UnitList > 0) then {
			PR(_d) = _this select 0;
			PR(_ind) = HIA3_Spectator_UnitList find HIA3_Spectator_ViewUnit;
			PR(_count) = count HIA3_Spectator_UnitList;
			PR(_newInd) = _ind + _d;

			if(_newInd>=_count)then{_newInd=0;};
			if(_newInd<0)then{_newInd=_count-1;};

			HIA3_Spectator_ViewUnit = HIA3_Spectator_UnitList select _newInd;

			PR(_dialog) = uiNamespace getVariable ['HIA3_DisaplaySpectator', 0];
			PR(_ctrlName) = _dialog displayCtrl IDD_SPECTATOR_PLAYER_NAME;
			PR(_textName) = name HIA3_Spectator_ViewUnit;
			PR(_color) = [side HIA3_Spectator_ViewUnit] call BIS_fnc_sideColor;

			_ctrlName ctrlSetText _textName;
			_ctrlName ctrlSetBackgroundColor _color;
			_ctrlName ctrlCommit 0;
		}else{
			PR(_dialog) = uiNamespace getVariable ['HIA3_DisaplaySpectator', 0];
			PR(_ctrlName) = _dialog displayCtrl IDD_SPECTATOR_PLAYER_NAME;

			_ctrlName ctrlSetText "";
			_ctrlName ctrlSetBackgroundColor [0,0,0,1];
			_ctrlName ctrlCommit 0;

			HIA3_Spectator_ViewUnit = nullObj;
		};
	};
	case "OBJECT" : {
		PR(_unit) = _this select 0;
		if(_unit in HIA3_Spectator_UnitList) then {
			HIA3_Spectator_ViewUnit = _unit;

			PR(_dialog) = uiNamespace getVariable ['HIA3_DisaplaySpectator', 0];
			PR(_ctrlName) = _dialog displayCtrl IDD_SPECTATOR_PLAYER_NAME;
			PR(_textName) = name HIA3_Spectator_ViewUnit;
			PR(_color) = [side HIA3_Spectator_ViewUnit] call BIS_fnc_sideColor;

			_ctrlName ctrlSetText _textName;
			_ctrlName ctrlSetBackgroundColor _color;
			_ctrlName ctrlCommit 0;
		};
	};
};


