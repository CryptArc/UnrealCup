// Fill out your copyright notice in the Description page of Project Settings.

#include "UnrealCup.h"
#include "TeamXMLParser.h"
#include "Runtime/XmlParser/Public/XmlFile.h"
#include "Runtime/XmlParser/Public/XmlParser.h"


FXmlFile* TeamsXml;
FXmlFile* Team1Xml;
FXmlFile* Team2Xml;

//--------------------------
// TODO Fehlerbehandlungen!  
//--------------------------

TeamXMLParser::TeamXMLParser()
{
	FString Team1Path;
	FString Team2Path;
	FString filesLocation = FPaths::GameDir();
	FString TeamPath = filesLocation + "Teams.xml";
	FXmlNode* node;

	TeamsXml = new FXmlFile(TeamPath);

	node = (FXmlNode*)TeamsXml->GetRootNode();

	FXmlNode* team1node = node->FindChildNode("Team1");
	FString team1str = team1node->GetAttribute("XMLLocation");

	Team1Path = filesLocation + node->FindChildNode("Team1")->GetAttribute("XMLLocation");
	Team2Path = filesLocation + node->FindChildNode("Team2")->GetAttribute("XMLLocation");

	Team1Xml = new FXmlFile(Team1Path);
	Team2Xml = new FXmlFile(Team2Path);
}

int32 TeamXMLParser::getTimeToPlay()
{
	FXmlNode* node;

	if (TeamsXml->IsValid())
	{
		node = TeamsXml->GetRootNode();

		return FCString::Atoi(*(node->FindChildNode("TimeToPlay")->GetAttribute("Minutes")));
	}
	else
	{
		//TODO Errorausgabe
		return 25;
	}

	return 0;
}


FString TeamXMLParser::GetNameTeam1XML()
{
	FXmlNode* node;
	
	if (TeamsXml->IsValid())
	{
		node = TeamsXml->GetRootNode();

		return node->FindChildNode("Team1")->GetAttribute("Name");
	}
	else
	{
		//TODO Errorausgabe
		return "Team_1";
	}
	
	return "Error";
}


FString TeamXMLParser::GetNameTeam2XML()
{
	FXmlNode* node;

	if (TeamsXml->IsValid())
	{
		node = TeamsXml->GetRootNode();

		return node->FindChildNode("Team2")->GetAttribute("Name");
	}
	else
	{
		//TODO Errorausgabe
		return "Team_2";
	}

	return "Error";
}

FString TeamXMLParser::getPlayerName(int team, int player)
{
	FXmlNode* node;
	if (team == 1) node = Team1Xml->GetRootNode();
	else if (team == 2) node = Team2Xml->GetRootNode();
	else return "Name"; // TODO Fehlerbehandlung

	return node->GetChildrenNodes()[player-1]->GetAttribute("Name");
}

FVector TeamXMLParser::getPlayerStartLocation(int team, int player)
{
	FXmlNode* node;
	if (team == 1) node = Team1Xml->GetRootNode();
	else if (team == 2) node = Team2Xml->GetRootNode();
	else return FVector(100, 100, 0); // TODO Fehlerbehandlung

	FString strX = node->GetChildrenNodes()[player-1]->GetAttribute("X");
	FString strY = node->GetChildrenNodes()[player-1]->GetAttribute("Y");

	int x = FCString::Atoi(*strX);
	int y = FCString::Atoi(*strY);

	return FVector(x, y, 0);
}

FString TeamXMLParser::getScriptLocation(int team, int player)
{
	FXmlNode* node;
	if (team == 1) node = Team1Xml->GetRootNode();
	else if (team == 2) node = Team2Xml->GetRootNode();
	else return "script.lua"; // TODO Fehlerbehandlung

	return node->GetChildrenNodes()[player-1]->GetAttribute("ScriptLocation");
}

