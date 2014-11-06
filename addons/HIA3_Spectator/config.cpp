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
		requiredAddons[] = {};
		author[] = {"Ezhuk"};
		authorUrl = "http://www.hia3.com";
		version = 0.9.1;
		versionStr = "0.9.1";
		versionAr[] = {0,9,1};	
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
