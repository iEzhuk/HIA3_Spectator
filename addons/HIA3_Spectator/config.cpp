#include "functions\defines.sqf"
#include "resource\RscHIA3Spectator.h"
#include "resource\RscHIA3SpectatorGUIext.h"
#include "resource\CfgFunctions.h"
#include "resource\CfgModuls.h"

class CfgPatches 
{
	class HIA3_Spectator 
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.0;
		requiredAddons[] = {"A3_Functions_F"};
		author[] = {"Ezhuk"};
		authorUrl = "http://www.hia3.com";
		version = 1.1.1;
		versionStr = "1.1.1";
		versionAr[] = {1,1,1};	
	};
};

class CfgRespawnTemplates
{
	class Seagull
	{
		onPlayerRespawn = "HIA3_spectator_fnc_respawnSeagull";
	};
	class Spectator
	{
		onPlayerKilled = "";
		onPlayerRespawn = "HIA3_spectator_fnc_respawnSpecator";
	};
};

class CfgFactionClasses
{
	class HIA3
	{
		displayName = "HIA3";
		priority = 13;
		side = 7;
	};
};
