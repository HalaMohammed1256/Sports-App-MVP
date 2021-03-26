//
//  Legue.swift
//  SportApplication
//
//  Created by AhmedFareed on 26/03/2021.
//

import Foundation

struct League : Codable {
    let idLeague : String?
    let strLeague : String?
    let strSport : String?
    let strLeagueAlternate : String?

    enum CodingKeys: String, CodingKey {

        case idLeague = "idLeague"
        case strLeague = "strLeague"
        case strSport = "strSport"
        case strLeagueAlternate = "strLeagueAlternate"
    }

    
}

struct Leagues : Codable {
    let leagues : [League]?
    
    enum CodingKeys : String, CodingKey {
        case leagues = "leagues"
    }
}
