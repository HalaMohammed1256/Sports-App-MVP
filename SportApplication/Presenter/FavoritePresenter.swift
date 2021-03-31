//
//  FavoritePresenter.swift
//  SportApplication
//
//  Created by Hala on 31/03/2021.
//

import Foundation
import CoreData
import UIKit

protocol FavoriteView : class{
    func reloadTable()
}


protocol FavoriteViewPresenter{
    init(view: FavoriteView, delegate: AppDelegate)
    var favoriteLeaguesArray : [NSManagedObject]?{get set}
    
    func fetchFavoriteLeaguesFromCoreData()
    func deleteLeaguefromCoreData(index: Int)
    func showAlert()
}

class FavoritePresenter: FavoriteViewPresenter{
    
    let delegate : AppDelegate?
    weak var view : FavoriteView?
    
    required init(view: FavoriteView, delegate: AppDelegate) {
        self.view = view
        self.delegate = delegate
    }
    
    var favoriteLeaguesArray: [NSManagedObject]?{
        didSet{
            self.view?.reloadTable()
        }
    }
    
    
    
    
    func fetchFavoriteLeaguesFromCoreData() {
        
        let context = delegate!.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteLeague")
        
        do{
            
            favoriteLeaguesArray = try context.fetch(fetchRequest)
            view?.reloadTable()
            
        }catch let error as NSError{
            print(error)
        }
        
        
    }
    
    
    func deleteLeaguefromCoreData(index: Int){
        
        let context = delegate!.persistentContainer.viewContext
        context.delete(favoriteLeaguesArray![index])
        
        do{
            try context.save()
            view?.reloadTable()
            
            print("Data deleted successfully")
        }catch let error as NSError{
            print(error)
        }
        delegate!.saveContext()
    }
    
    
    func showAlert(){
        let alert = UIAlertController(title: "Connection Failed", message: "NO INTERNET CONNECTION!", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            self.view?.reloadTable()
        }))

        (self.view as! FavoriteViewController).present(alert, animated: true) 
    }
    
    
    
}
