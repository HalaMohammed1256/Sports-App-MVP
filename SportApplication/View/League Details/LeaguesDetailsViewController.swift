//
//  LeaguesDetailsViewController.swift
//  SportApplication
//
//  Created by Hala on 20/03/2021.
//

import UIKit

class LeaguesDetailsViewController: UIViewController, LeagueDetailsView{
    
    
    var indexPath : Int?
    var leaguesDetailsPresenter : LeagueDetailsPresenter?
    var leagueID : String?
    var leagueName : String?
    
    var indicator : ActivityIndicator?
    @IBOutlet weak var leagueDetailsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leaguesDetailsPresenter = LeagueDetailsPresenter(view: self)
        
        leaguesDetailsPresenter?.getTeamsData(apiURL: ApiURLs.leagueTeams.rawValue, id: leagueID ?? "")
        
        leaguesDetailsPresenter?.getEventsData(apiURL: ApiURLs.leagueEvents.rawValue, id: leagueID ?? "")
  
        self.title = leagueName!
        
        indicator = ActivityIndicator(view: leagueDetailsTableView)
    }
    
    
    func reloadTable() {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: { [weak self] in
            self?.leagueDetailsTableView.reloadData()
        })
    }
    
    func startAnimating() {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: { [weak self] in
            self?.indicator?.startAnimating()
        })
    }
    
    func stopAnimating() {
        DispatchQueue.main.async{ [weak self] in
            self?.indicator?.stopAnimating()
        }
    }


}
