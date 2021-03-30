//
//  ApiURLs.swift
//  SportApplication
//
//  Created by Hala on 24/03/2021.
//

import Foundation


enum ApiURLs : String{
    
    case allSports = "https://www.thesportsdb.com/api/v1/json/1/all_sports.php"
    case allLeagues = "https://www.thesportsdb.com/api/v1/json/1/all_leagues.php"
    case leaguesLookup  = "https://www.thesportsdb.com/api/v1/json/1/lookupleague.php?id="
    case leagueEvents = "https://www.thesportsdb.com/api/v1/json/1/eventspastleague.php?id="
    case leagueTeams = "https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id="
    case teamDetails = "https://www.thesportsdb.com/api/v1/json/1/lookupteam.php?id="
    
}
