//
//  LeaguesViewController.swift
//  SportApplication
//
//  Created by Hala on 20/03/2021.
//

import UIKit

class LeaguesViewController: UIViewController {
    
    var leaguesPresenter : LeaguesPresenter?
    var sport : String?
    var urlLink : String?
    var idLeague : String?
    var indicator : ActivityIndicator?
    
    
    @IBOutlet weak var LeagueViewTableView: UITableView!{
        didSet{
            LeagueViewTableView.delegate = self
            LeagueViewTableView.dataSource = self
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MainColor.instance.backgroundColor

        leaguesPresenter = LeaguesPresenter(view: self)
        leaguesPresenter?.getAllFilteredLeagues(sport: sport ?? "")
        
        indicator = ActivityIndicator(view: LeagueViewTableView)
    }

}

extension LeaguesViewController : LeaguesView{
    
    
    func startAnimating() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.indicator?.startAnimating()
        }
    }
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.LeagueViewTableView.reloadData()
        }
       
    }
    
    func stopAnimating() {
        DispatchQueue.main.async {
            self.indicator?.stopAnimating()
        }
    }
    
    
    
}
