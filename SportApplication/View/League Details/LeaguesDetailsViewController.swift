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
    var leagueYoutubeLink : String?
    var leagueImage : String?
//    var leagueData : LeagueDetails?
    
    
//    var delegate : AppDelegate?
//    var context : NSManagedObjectContext?
//    var favoriteEntity : NSEntityDescription?
//    var favoriteLeagueRow : NSManagedObject?
    
    let delegate = (UIApplication.shared.delegate as! AppDelegate)
    
    var indicator : ActivityIndicator?
    
    
    @IBOutlet weak var leagueDetailsTableView: UITableView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // core data
//        delegate = (UIApplication.shared.delegate as! AppDelegate)
//        context = delegate!.persistentContainer.viewContext
//        favoriteEntity = NSEntityDescription.entity(forEntityName: "FavoriteLeague", in: context!)
//        favoriteLeagueRow = NSManagedObject(entity: favoriteEntity!, insertInto: context!)
//
       
        favoriteButton.tintColor = UIColor.gray
        
        leaguesDetailsPresenter = LeagueDetailsPresenter(view: self, delegate: delegate)
        
        leaguesDetailsPresenter?.getEventsData(apiURL: ApiURLs.leagueEvents.rawValue, id: leagueID ?? "")
        leaguesDetailsPresenter?.getTeamsData(apiURL: ApiURLs.leagueTeams.rawValue, id: leagueID ?? "")

  
        self.title = leagueName
        
        indicator = ActivityIndicator(view: leagueDetailsTableView)
    }
    
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.leagueDetailsTableView.reloadData()
        }
        
    }
    
    func startAnimating() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.indicator?.startAnimating()
        }
    }
    
    func stopAnimating() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.indicator?.stopAnimating()
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
