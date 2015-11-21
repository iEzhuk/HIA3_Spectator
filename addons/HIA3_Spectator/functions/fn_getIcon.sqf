/*
    Name: HIA3_spectator_fnc_getIcon

    Author(s):
        Ezhuk

    Description:
        Return icon for unit or vehicle

    Parameters:
        0 - OBJ

    Returns:
        STRING: path to files
*/

private ["_obj"];

_obj = _this select 0;

if (_obj isKindOf "Man") then {
    //====================================
    // Units
    //====================================
    switch (true) do {
        // Leader
        case ([(backpack _obj), "tf_hasLRradio", 0] call TFAR_fnc_getConfigProperty == 1):
        {
            "\A3\ui_f\data\map\vehicleicons\iconManLeader_ca.paa"
        };

        // Medic
        case (getNumber(configFile >> "CfgVehicles" >> typeOf _obj >> "attendant") == 1):
        {
            "\A3\ui_f\data\map\vehicleicons\iconManMedic_ca.paa"
        };

        // MG
        case (getText(configFile >> "CfgWeapons" >> primaryWeapon(_obj) >> "UIPicture") == "\a3\weapons_f\data\ui\icon_mg_ca.paa"):
        {
            "\A3\ui_f\data\map\vehicleicons\iconManMG_ca.paa"
        };

        // AT
        case (getText(configFile >> "CfgWeapons" >> secondaryWeapon(_obj) >> "UIPicture") == "\a3\weapons_f\data\ui\icon_at_ca.paa"):
        {
            "\A3\ui_f\data\map\vehicleicons\iconManAT_ca.paa"
        };

        // AA
        case (getText(configFile >> "CfgWeapons" >> secondaryWeapon(_obj) >> "UIPicture") == "\a3\weapons_f\data\ui\icon_aa_ca.paa"):
        {
            "\A3\ui_f\data\map\vehicleicons\iconManAT_ca.paa"
        };

        default {
            getText (configfile >> "CfgVehicles" >> typeOf _obj >> "Icon")
        };
    }
} else {
    //====================================
    // Vehicle
    //====================================
    getText (configfile >> "CfgVehicles" >> typeOf _obj >> "Icon")
}
