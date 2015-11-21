/*
    Name: HIA3_spectator_fnc_draw3D

    Author(s):
        Ezhuk

    Description:
        Drawing 3D tags

    Parameters:
        Nothing

    Returns:
        Nothing
*/
#include "defines.sqf"
private ["_vehs", "_unit", "_last_time"];
_vehs = [];
_unit = HIA3_Spectator_ViewUnit;
_last_time = HIA3_Spectator_LastFrameTime;
HIA3_Spectator_LastFrameTime = diag_tickTime;


if !(isNil {_unit}) then {
    //=======================================//
    //            Camera control             //
    //=======================================//
    if(HIA3_Spectator_State == SPECT_VIEWSTATE_INTERNAL) then
    {
        _unit switchCamera "INTERNAL";
        vehicle _unit switchCamera HIA3_Spectator_CameraMode;
    };

    //=======================================//
    //        Conrole attached camera        //
    //=======================================//
    if(HIA3_Spectator_State == SPECT_VIEWSTATE_ATTACH) then
    {
        call HIA3_spectator_fnc_attachedCamera;
    };
};


if(HIA3_Spectator_Hide3D) exitWith {};
if !(isNil {_unit}) then {
    private ["_pos", "_color", "_posEye"];
    _pos = visiblePosition vehicle _unit;
    _color = if(alive _unit)then{[side _unit] call BIS_fnc_sideColor}else{[0,0,0,1]};

    if(HIA3_Spectator_State == SPECT_VIEWSTATE_FREE && count _pos == 3 && HIA3_Spectator_TagType != SPECT_TAG_NAME) then {
        if(_unit == vehicle _unit) then{
            _posEye = if(!(surfaceIsWater _pos))then{ASLtoATL eyePos _unit}else{eyePos _unit};
            _pos set [2,(_posEye select 2) + 0.5];
        }else{
            _pos set [2,(_pos select 2) + 4];
        };

        // target icon
        drawIcon3D ["\A3\ui_f\data\map\groupicons\selector_selectedFriendly_ca.paa", _color, _pos, 1, 1, 2, "", 2, 0.05, "PuristaMedium"];
    };
};

switch (HIA3_Spectator_TagType) do
{
    case SPECT_TAG_ICON :
    {
        private ["_vehInfo", "_pos", "_dir", "_unitInfo", "_posEye"];
        if (HIA3_Spectator_Camera_AngV < -70 and HIA3_Spectator_State == SPECT_VIEWSTATE_FREE) then {
            //=========================================
            // Tactical view
            //=========================================
            for "_i" from 0 to (count HIA3_Spectator_EachFrame_Vehs - 1) do {
                _vehInfo = HIA3_Spectator_EachFrame_Vehs select _i;
                _pos = visiblePosition (_vehInfo select 0);
                _dir = getDir HIA3_Spectator_Camera - getDir (_vehInfo select 0);

                if(surfaceIsWater _pos)then{
                    _pos set [2,((getPosASL (_vehInfo select 0)) select 2)];
                }else{
                    _pos set [2,((getPosATL (_vehInfo select 0)) select 2)];
                };

                drawIcon3D [(_vehInfo select 3), (_vehInfo select 2),_pos, 0.9, 0.9, _dir, "", 2, 0.0, "PuristaMedium"];
            };
            for "_i" from 0 to (count HIA3_Spectator_EachFrame_Units - 1) do {
                _unitInfo = HIA3_Spectator_EachFrame_Units select _i;
                _pos = visiblePosition (_unitInfo select 0);
                _posEye = if(!(surfaceIsWater _pos))then{ASLtoATL eyePos (_unitInfo select 0)}else{eyePos (_unitInfo select 0)};
                _dir = getDir HIA3_Spectator_Camera - getDirVisual (_unitInfo select 0);

                _pos set [2,(_posEye select 2) + 0.5];
                drawIcon3D [(_unitInfo select 3), (_unitInfo select 2), _pos, 0.65, 0.65, _dir, "", 2, 0.0, "PuristaMedium"];
            };
        } else {
            //=========================================
            // Simple icons
            //=========================================
            for "_i" from 0 to (count HIA3_Spectator_EachFrame_Vehs - 1) do {
                _vehInfo = HIA3_Spectator_EachFrame_Vehs select _i;
                _pos = visiblePosition (_vehInfo select 0);

                if(surfaceIsWater _pos)then{
                    _pos set [2,((getPosASL (_vehInfo select 0)) select 2) + 4];
                }else{
                    _pos set [2,((getPosATL (_vehInfo select 0)) select 2) + 4];
                };

                drawIcon3D ["a3\ui_f\data\map\markers\military\box_CA.paa", (_vehInfo select 2),_pos, 0.9, 0.9, 2, "", 2, 0.0, "PuristaMedium"];
            };
            for "_i" from 0 to (count HIA3_Spectator_EachFrame_Units - 1) do {
                _unitInfo = HIA3_Spectator_EachFrame_Units select _i;
                _pos = visiblePosition (_unitInfo select 0);
                _posEye = if(!(surfaceIsWater _pos))then{ASLtoATL eyePos (_unitInfo select 0)}else{eyePos (_unitInfo select 0)};

                _pos set [2,(_posEye select 2) + 0.5];
                drawIcon3D ["a3\ui_f\data\map\VehicleIcons\iconexplosiveat_ca.paa", (_unitInfo select 2), _pos, 0.65, 0.65, 0, "", 2, 0.0, "PuristaMedium"];
            };
        };

        // Show dead
        if (HIA3_Spectator_ShowDead) then {
            for "_i" from 0 to (count HIA3_Spectator_EachFrame_DeadList - 1) do {
                _unitInfo = HIA3_Spectator_EachFrame_DeadList select _i;
                _pos = visiblePosition (_unitInfo select 0);
                _posEye = if(!(surfaceIsWater _pos))then{ASLtoATL eyePos (_unitInfo select 0)}else{eyePos (_unitInfo select 0)};

                _pos set [2,(_posEye select 2) + 0.5];
                drawIcon3D ["a3\ui_f\data\map\VehicleIcons\iconexplosiveat_ca.paa", (_unitInfo select 2),_pos, 0.65, 0.65, 0, "", 2, 0.0, "PuristaMedium"];
            };
        } else {
            HIA3_Spectator_DeadList = [];
        };
    };
    case SPECT_TAG_NAME :
    {
        private ["_vehInfo", "_pos", "_dir", "_unitInfo", "_posEye"];
        for "_i" from 0 to (count HIA3_Spectator_EachFrame_Vehs - 1) do {
            _vehInfo = HIA3_Spectator_EachFrame_Vehs select _i;
            _pos = visiblePosition (_vehInfo select 0);

            if(surfaceIsWater _pos)then{
                _pos set [2,((getPosASL (_vehInfo select 0)) select 2) + 4];
            }else{
                _pos set [2,((getPosATL (_vehInfo select 0)) select 2) + 4];
            };

            drawIcon3D ["", (_vehInfo select 2),_pos, 0.0, 0.0, 2, (_vehInfo select 1), 2, 0.036, "PuristaMedium"];
        };
        for "_i" from 0 to (count HIA3_Spectator_EachFrame_Units - 1) do {
            _unitInfo = HIA3_Spectator_EachFrame_Units select _i;
            _pos = visiblePosition (_unitInfo select 0);
            _posEye = if(!(surfaceIsWater _pos))then{ASLtoATL eyePos (_unitInfo select 0)}else{eyePos (_unitInfo select 0)};

            _pos set [2,(_posEye select 2) + 0.5];
            drawIcon3D ["", (_unitInfo select 2),_pos, 0.0, 0.0, 2, (_unitInfo select 1), 2, 0.036, "PuristaMedium"];
        };

        // Show dead
        if (HIA3_Spectator_ShowDead) then {
            for "_i" from 0 to (count HIA3_Spectator_EachFrame_DeadList - 1) do {
                _unitInfo = HIA3_Spectator_EachFrame_DeadList select _i;
                _pos = visiblePosition (_unitInfo select 0);
                _posEye = if(!(surfaceIsWater _pos))then{ASLtoATL eyePos (_unitInfo select 0)}else{eyePos (_unitInfo select 0)};

                _pos set [2,(_posEye select 2) + 0.5];
                drawIcon3D ["", (_unitInfo select 2),_pos, 0.0, 0.0, 2, (_unitInfo select 1), 2, 0.036, "PuristaMedium"];
            };
        } else {
            HIA3_Spectator_DeadList = [];
        };
    };
};

if (HIA3_Spectator_TraceBullet_On) then {
    for "_i" from 0 to ((count HIA3_Spectator_TraceBulletList) - 1) do {
        _unit = HIA3_Spectator_TraceBulletList select _i;
        _lines = _unit getVariable ["SPECT_BT_lines", []];
        _colors = _unit getVariable ["SPECT_BT_colors", []];
        for "_k" from 0 to ((count _lines) - 1) do {
            _line = _lines select _k;
            _color = _colors select _k;
            for "_z" from 1 to ((count _line) - 1) do {
                drawLine3D [_line select (_z - 1), _line select _z, _color select (_z - 1)];
            };
        };
    };
};
