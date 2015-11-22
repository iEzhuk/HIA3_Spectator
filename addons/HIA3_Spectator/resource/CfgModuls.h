class ArgumentsBaseUnits;
class CfgVehicles
{
    class Logic;
    class Module_F: Logic
    {
        class ModuleDescription
        {
            class AnyBrain;
        };
    };
    class HIA3_Spectator: Module_F
    {
        scope = 2;
        author = "HI,A3 Project";
        displayName = "Spectator";
        category = "HIA3";
        function = "HIA3_spectator_fnc_initModule";
        functionPriority = 1;
        isGlobal = 1;
        isTriggerActivated = 0;

        class Arguments: ArgumentsBaseUnits
        {
            class ShowEnemy
            {
                displayName = "$STR_HIA3_Spectator_ShowEnemy";
                description = "$STR_HIA3_Spectator_ShowEnemy_Desc";
                typeName = "BOOL";
            };
            class Tag
            {
                displayName = "$STR_HIA3_Spectator_Tags";
                description = "$STR_HIA3_Spectator_Tags_Desc";
                typeName = "NUMBER";
                class values
                {
                    class Empty {name = "$STR_HIA3_Spectator_Tags_Empty"; value = 1;};
                    class Icon  {name = "$STR_HIA3_Spectator_Tags_Icon"; value = 2;};
                    class Name  {name = "$STR_HIA3_Spectator_Tags_Name"; value = 3; default = 1;};
                };
            };
            class FreeView
            {
                displayName = "$STR_HIA3_Spectator_FreeView";
                typeName = "BOOL";
            };
            class FreeViewTI
            {
                displayName = "$STR_HIA3_Spectator_FreeViewTI";
                typeName = "BOOL";
            };
            class SpecialAdmin
            {
                displayName = "$STR_HIA3_Spectator_SpecialAdmin";
                description = "$STR_HIA3_Spectator_SpecialAdmin_Desc";
                typeName = "BOOL";
            };
        };
    };
};
