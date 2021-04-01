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
    init(view: FavoriteView, delegate: AppDelegate)
    
    func fetchFavoriteLeaguesFromCoreData()
    func deleteLeaguefromCoreData(index: Int)
}

class FavoritePresenter: FavoriteViewPresenter{
    
    let delegate : AppDelegate?
    weak var view : FavoriteView?
    
    required init(view: FavoriteView, delegate: AppDelegate) {
        self.view = view
        self.delegate = delegate
    }
    
    var favoriteLeaguesArray = [NSManagedObject](){
        didSet{
            self.view?.reloadData()
        }
    }
    
    func fetchFavoriteLeaguesFromCoreData(){
        CoreDataBuilder.fetchFromCoreData(delegate: delegate!, view: view!, fetchedDataArray: &(favoriteLeaguesArray), entityName: "FavoriteLeague")
    }



    func deleteLeaguefromCoreData(index: Int){
        CoreDataBuilder.deletefromCoreData(delegate: delegate!, index: index, view: view!, dataDeletedArray: &(favoriteLeaguesArray))
    }
    


}
