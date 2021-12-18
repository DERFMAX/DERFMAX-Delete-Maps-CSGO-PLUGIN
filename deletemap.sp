#include <sourcemod>

#pragma newdecls required
#define CSGO_MAP_COUNT 85

char csgoMapName[CSGO_MAP_COUNT][] = {
	"cs_italy_story",
	"ar_baggage",
	"deˍcalavera",
	"deˍgrind",
	"deˍmocha",
	"de_calavera",
	"de_mocha",
	"de_grind",
	"deˍpitstop",
	"cs_italy_cameras",	
	"de_pitstop",	
	"de_cbble_cameras",	
	"de_cache_cameras",
	"de_anubis",
	"de_ancient",	
	"de_ancient_retake",	
	"ar_dizzy",
	"cs_assault_cameras",
	"cs_apollo",
	"cs_agency_cameras",
	"ar_shoots_story",
	"de_engage",
	"de_elysion",
	"ar_baggage_story",
	"de_guard",
	"dz_frostbite",
	"lobby_mapveto",
	"ar_lunacy",
	"ar_monastery",
	"ar_shoots",
	"coop_kasbah",
	"cs_agency",
	"cs_assault",
	"cs_downtown",
	"cs_insertion",
	"cs_italy",
	"cs_militia",
	"cs_motel",
	"cs_office",
	"cs_rush",
	"cs_siege",
	"cs_thunder",
	"de_ali",
	"de_aztec",
	"de_bank",
	"de_blackgold",
	"de_breach",
	"de_cache",
	"de_canals",
	"de_cbble",
	"de_chinatown",
	"de_dust",
	"de_dust2",
	"de_favela",
	"de_gwalior",
	"de_inferno",
	"de_lake",
	"de_mirage",
	"de_mist",
	"de_nuke",
	"de_overgrown",
	"de_overpass",
	"de_ruins",
	"de_safehouse",
	"de_seaside",
	"de_shortdust",
	"de_shortnuke",
	"de_shorttrain",
	"coop_autumn",
	"de_stmarc",
	"coop_fall",
	"de_studio",
	"de_sugarcane",
	"de_train",
	"de_vertigo",
	"dz_blacksite",
	"dz_junglety",
	"dz_sirocco",
	"gd_cbble",
	"gd_rialto",
	"training1",
	"cs_insertion2",
	"de_ravine",
	"dz_county",
	"de_basalt"
};

ConVar g_DeleteMap[CSGO_MAP_COUNT];

public Plugin myinfo = 
{
	name = "deletemap",
	author = "DERFMAX",
	description = "Automatically deletes all official CSGO steam maps and their add-ons",
	version = "1.0",
	url = "https://github.com/derfmax"
};

public void OnPluginStart()
{	
	for (int i = 0; i < CSGO_MAP_COUNT; i++)
	{
		// Create cvar name
		char cvarName[32];
		Format(cvarName, sizeof(cvarName), "spirt_mapdel_%s", csgoMapName[i]);
		
		// Create cvar description
		char cvarDesc[64];
		Format(cvarDesc, sizeof(cvarDesc), "Deletes all %s files", csgoMapName[i]);
		
		// Create cvar from name and description. Set bool min and max values
		g_DeleteMap[i] = CreateConVar(cvarName, "1", cvarDesc, _, true, 0.0, true, 1.0);
	}
	
	AutoExecConfig(true, "spirt.mapdelete", "SpirT");
}

public void OnMapStart()
{
	DeleteAllMaps();
	return;
}

void DeleteAllMaps()
{
	char fileExt[4][] = {
		"bsp",
		"nav",
		"txt",
		"jpg"
	};
		
	for (int i = 0; i < CSGO_MAP_COUNT; i++)
	{		
		if (g_DeleteMap[i].BoolValue)
		{		
			for (int f = 0; f < 3; f++)
			{
				// Create the file name string
				char fileName[32];
				Format(fileName, sizeof(fileName), "maps/%s.%s", csgoMapName[i], fileExt[f]);
				
				// Delete the file if it exists
				if (FileExists(fileName))
					DeleteFile(fileName);
			}
		}
	}
}