/*
 	Name: HIA3_spectator_fnc_mainLoop
 	
 	Author(s):
		Ezhuk

 	Description:
		Loop updater 

	Parameters:
		Nothing
		
 	Returns:
		Nothing
*/
#include "defines.sqf"

disableSerialization;

PR(_dialog)   = uiNamespace getVariable ['HIA3_DisaplaySpectator', 0];
PR(_ctrlName) = _dialog displayCtrl IDD_SPECTATOR_PLAYER_NAME;
PR(_ctrlTime) = _dialog displayCtrl IDD_SPECTATOR_TIME;
PR(_ctrlCrew)  = _dialog displayCtrl IDD_SPECTATOR_CREW;

while{HIA3_Spectator_Enable} do
{
	call HIA3_spectator_fnc_updateTagList; 

	PR(_text) =	if(isNil "Global_HIA3_Specator_Time") then {
					[daytime,"HH:MM"] call bis_fnc_TimeToString
				}else{
					if(typeName Global_HIA3_Specator_Time != "STRING") then {
						format ["%1 %2",Global_HIA3_Specator_Time,localize "STR_HIA3_Minutes_short"];
					} else {
						Global_HIA3_Specator_Time
					};
					
				};

	_ctrlTime ctrlSetText _text;
	_ctrlTime ctrlCommit 0;
	if(isNil "HIA3_Spectator_State") exitWith {};

	//=====================================================================
	//					Show counters of units by sides	
	//=====================================================================
	PR(_ctrlInd) = IDD_SPECTATOR_COUNT0;
	{
		PR(_side) = _x;
		PR(_ctrl) = _dialog displayCtrl _ctrlInd;
		PR(_count) = {alive _x && side _x == _side && isPlayer _x} count allUnits;

		if(_count > 0) then
		{
			PR(_color) = [_side] call BIS_fnc_sideColor;
			_ctrl ctrlSetBackgroundColor _color;
			_ctrl ctrlSetText str(_count);
			_ctrl ctrlCommit 0;

			_ctrlInd = _ctrlInd + 1;
		};
	} foreach [west,east,resistance,civilian];

	for "_i"  from _ctrlInd to IDD_SPECTATOR_COUNT3 do {
		PR(_ctrl) = _dialog displayCtrl _i;
		_ctrl ctrlSetBackgroundColor [0,0,0,0];
		_ctrl ctrlSetText "";
		_ctrl ctrlCommit 0;
	};

	if(isNil "HIA3_Spectator_ViewUnit") exitWith {};
	if(isNil "HIA3_Spectator_ShowCrewVeh") exitWith {};

	//=====================================================================
	//							Show crew list	
	//=====================================================================
	if(vehicle HIA3_Spectator_ViewUnit != HIA3_Spectator_ViewUnit && HIA3_Spectator_ShowCrewVeh) then {
		PR(_veh) = vehicle HIA3_Spectator_ViewUnit;
		PR(_text) = "";

		_text = format ["<t size='1.8'> %1 %2</t><br/>",count crew _veh,getText(configFile>>"CfgVehicles">>typeOf _veh>>"displayName")];

		{
			PR(_icon) = "getincargo_ca.paa";

			if(_x == driver _veh) then {
				_icon = "getindriver_ca.paa";
			};
			if(_x == gunner _veh) then {
				_icon = "getingunner_ca.paa";
			};
			if(_x == commander _veh) then {
				_icon = "getincommander_ca.paa";
			};
			_text = _text + format ["<t size='1.1'> <img image='\A3\ui_f\data\igui\cfg\actions\%1'></t><t size='1.5'> %2</t><br/>",_icon,name _x];

		} forEach (crew _veh);

		_ctrlCrew ctrlSetStructuredText (parseText _text);
		_ctrlCrew ctrlCommit 0;
	}else{
		_ctrlCrew ctrlSetText "";
		_ctrlCrew ctrlCommit 0;
	};

	//=====================================================================
	//							Check target unit	
	//=====================================================================
	if(!(alive HIA3_Spectator_ViewUnit)) then 
	{
		_ctrlName ctrlSetBackgroundColor [0,0,0,1];
		_ctrlName ctrlCommit 0;
	};

	sleep 0.3;
};	