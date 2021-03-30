//
//  LeaguesDetailsViewController.swift
//  SportApplication
//
//  Created by Hala on 20/03/2021.
//

import UIKit

class LeaguesDetailsViewController: UIViewController, LeagueDetailsView{
    
    
    
    var leaguesDetailsPresenter : LeagueDetailsPresenter?
    var leagueID : String?
    var indicator : ActivityIndicator?
    @IBOutlet weak var leagueDetailsTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        leaguesDetailsPresenter = LeagueDetailsPresenter(view: self)
        
        leaguesDetailsPresenter?.getEventsData(apiURL: ApiURLs.leagueEvents.rawValue, id: leagueID ?? "")
        
        leaguesDetailsPresenter?.getTeamsData(apiURL: ApiURLs.leagueTeams.rawValue, id: leagueID ?? "")
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
            self?.leaguesDetailsPresenter?.getTeamDetails(apiURL: ApiURLs.teamDetails.rawValue, id: (self?.leaguesDetailsPresenter?.leagueEventsDetails![0].idHomeTeam!)!)
        }
        

  
      
    
        indicator = ActivityIndicator(view: leagueDetailsTableView)
    }
    
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.leagueDetailsTableView.reloadData()
        }
        
       // leaguesDetailsPresenter?.getTeamDetails(apiURL: ApiURLs.teamDetails.rawValue, id: (leaguesDetailsPresenter?.leagueEventsDetails![0].idAwayTeam)!)
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


}
