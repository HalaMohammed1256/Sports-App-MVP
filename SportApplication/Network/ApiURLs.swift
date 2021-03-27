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
    case allCountriesLeagues = "https://www.thesportsdb.com/api/v1/json/1/search_all_leagues.php?s="
}
