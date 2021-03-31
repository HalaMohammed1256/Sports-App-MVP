//
//  FavoriteLeague+CoreDataProperties.swift
//  
//
//  Created by Hala on 31/03/2021.
//
//

import Foundation
import CoreData


extension FavoriteLeague {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteLeague> {
        return NSFetchRequest<FavoriteLeague>(entityName: "FavoriteLeague")
    }

    @NSManaged public var leagueYoutubeLink: String?
    @NSManaged public var leagueName: String?
    @NSManaged public var leagueID: String?

}
