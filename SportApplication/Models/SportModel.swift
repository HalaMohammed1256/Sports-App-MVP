//
//  SportModel.swift
//  SportApplication
//
//  Created by Hala on 24/03/2021.
//

import Foundation

// for dictionary in sports array
struct Sport : Codable {
    let idSport : String?
    let strSport : String?
    let strFormat : String?
    let strSportThumb : String?
    let strSportThumbGreen : String?
    let strSportDescription : String?

    enum CodingKeys: String, CodingKey {

        case idSport = "idSport"
        case strSport = "strSport"
        case strFormat = "strFormat"
        case strSportThumb = "strSportThumb"
        case strSportThumbGreen = "strSportThumbGreen"
        case strSportDescription = "strSportDescription"
    }

}

// for array
struct SportsModel : Codable {
    let sports : [Sport]?

    enum CodingKeys: String, CodingKey {

        case sports = "sports"
    }
}
