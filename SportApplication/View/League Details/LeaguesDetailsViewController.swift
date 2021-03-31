//
//  LeaguesDetailsViewController.swift
//  SportApplication
//
//  Created by Hala on 20/03/2021.
//

import UIKit
import CoreData

class LeaguesDetailsViewController: UIViewController, LeagueDetailsView{
    
    
    var indexPath : Int?
    var leaguesDetailsPresenter : LeagueDetailsPresenter?
    var leagueID : String?
    var leagueName : String?
        super.viewDidLoad()
        leaguesDetailsPresenter = LeagueDetailsPresenter(view: self)
        
        leaguesDetailsPresenter?.getTeamsData(apiURL: ApiURLs.leagueTeams.rawValue, id: leagueID ?? "")

  
        self.title = leagueName
        
        leaguesDetailsPresenter = LeagueDetailsPresenter(view: self)
        
        // core data
//        delegate = (UIApplication.shared.delegate as! AppDelegate)
//        context = delegate!.persistentContainer.viewContext
//        favoriteEntity = NSEntityDescription.entity(forEntityName: "FavoriteLeague", in: context!)
//        favoriteLeagueRow = NSManagedObject(entity: favoriteEntity!, insertInto: context!)
//
       
        favoriteButton.tintColor = UIColor.gray
        
        leaguesDetailsPresenter = LeagueDetailsPresenter(view: self, delegate: delegate)
    }
        leaguesDetailsPresenter?.getEventsData(apiURL: ApiURLs.leagueEvents.rawValue, id: leagueID ?? "")
    

    func reloadTable() {
        DispatchQueue.main.async {
            self.leagueDetailsTableView.reloadData()
        }
        
    }

//    func saveLeagueToCoreData(){
//
//        favoriteLeagueRow!.setValue(leagueID, forKey: "leagueID")
//        favoriteLeagueRow!.setValue(leagueName, forKey: "leagueName")
//        favoriteLeagueRow!.setValue(leagueYoutubeLink, forKey: "leagueYoutubeLink")
//
//
////        deleteObject?.setValue(leagueID, forKey: "leagueID")
////        deleteObject?.setValue(leagueName, forKey: "leagueName")
////        deleteObject?.setValue(leagueYoutubeLink, forKey: "leagueYoutubeLink")
//
//        do{
//            try context!.save()
//            print("Data added successfully")
//        }catch let error as NSError{
//            print(error)
//        }
//
//        (UIApplication.shared.delegate as! AppDelegate).saveContext()
//    }
//
//
//    func deleteLeaguefromCoreData(){
//
//        context!.delete(favoriteLeagueRow!)
//
//        do{
//            try context!.save()
//            print("Data deleted successfully")
//        }catch let error as NSError{
//            print(error)
//        }
//
//        (UIApplication.shared.delegate as! AppDelegate).saveContext()
//    }
//
//
    
    
    
    @IBAction func saveToFavoriteTapped(_ sender: Any) {
        
        if favoriteButton.tintColor == UIColor.gray{

            favoriteButton.tintColor = UIColor.red
            leaguesDetailsPresenter?.saveLeagueToCoreData(leagueID: leagueID ?? "", leagueName: leagueName ?? "", leagueYoutubeLink: leagueYoutubeLink ?? "", leagueImage: leagueImage ?? "")

        }else{
            
            favoriteButton.tintColor = UIColor.gray
            leaguesDetailsPresenter?.deleteLeaguefromCoreData()
            
        }
        
        
    }
    


}
