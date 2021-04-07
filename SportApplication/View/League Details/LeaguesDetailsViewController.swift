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
    
    
    
    let delegate = (UIApplication.shared.delegate as! AppDelegate)
    
    var indicator : ActivityIndicator?
    
    
    @IBOutlet weak var leagueDetailsTableView: UITableView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        leaguesDetailsPresenter = LeagueDetailsPresenter(view: self)
        
        leaguesDetailsPresenter?.getEventsData(apiURL: ApiURLs.leagueEvents.rawValue, id: leagueID ?? "")
        leaguesDetailsPresenter?.getTeamsData(apiURL: ApiURLs.leagueTeams.rawValue, id: leagueID ?? "")
        
        if leaguesDetailsPresenter?.isFavoriteLeague(leagueID: leagueID!) == true{
            favoriteButton.tintColor = UIColor.red
        }else{
            favoriteButton.tintColor = UIColor.gray
        }
        
        
        self.title = leagueName
        
        indicator = ActivityIndicator(view: leagueDetailsTableView)
    }
    
    
    func reloadData() {
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
    
    @IBAction func saveToFavoriteTapped(_ sender: Any) {
        
        if favoriteButton.tintColor == UIColor.gray{
            
            favoriteButton.tintColor = UIColor.red
            leaguesDetailsPresenter?.saveLeagueToCoreData(leagueID: leagueID ?? "", leagueName: leagueName ?? "", leagueYoutubeLink: leagueYoutubeLink ?? "", leagueImage: leagueImage ?? "")
            
        }else{
            
            favoriteButton.tintColor = UIColor.gray
            leaguesDetailsPresenter?.deleteLeaguefromCoreData(leagueID: leagueID!)
            
        }
        
    }
    
    
    
    
}
