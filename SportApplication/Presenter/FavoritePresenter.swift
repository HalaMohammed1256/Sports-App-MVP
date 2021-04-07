//
//  FavoritePresenter.swift
//  SportApplication
//
//  Created by Hala on 31/03/2021.
//

import Foundation
import CoreData
import UIKit



protocol FavoriteView : class, SuperClass{}


protocol FavoriteViewPresenter{
    init(view: FavoriteView)
    
    func fetchFavoriteLeaguesFromCoreData()
    func deleteLeaguefromCoreData(index: Int)
}

class FavoritePresenter: FavoriteViewPresenter{
    
    weak var view : FavoriteView?
    
    required init(view: FavoriteView) {
        self.view = view
    }
    
    var favoriteLeaguesArray = [NSManagedObject](){
        didSet{
            self.view?.reloadData()
        }
    }
    
    func fetchFavoriteLeaguesFromCoreData(){
        CoreDataBuilder.fetchFromCoreData(view: view!, fetchedDataArray: &(favoriteLeaguesArray), entityName: "FavoriteLeague")
    }



    func deleteLeaguefromCoreData(index: Int){
        CoreDataBuilder.deletefromCoreData(index: index, view: view!, dataDeletedArray: &(favoriteLeaguesArray))
    }
    


}
