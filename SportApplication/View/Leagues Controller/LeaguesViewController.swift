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
    
    
    @IBOutlet weak var LeagueViewTableView: UITableView!{
        didSet{
            LeagueViewTableView.delegate = self
            LeagueViewTableView.dataSource = self
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        leaguesPresenter = LeaguesPresenter(view: self)
        view.backgroundColor = MainColor.instance.backgroundColor
       // leaguesPresenter?.getLeagues(id:"4329")
        leaguesPresenter?.getAllFilteredLeagues(sport: sport ?? "")
    }

}

extension LeaguesViewController : LeaguesView{
    func reloadTable() {
        DispatchQueue.main.async {
            self.LeagueViewTableView.reloadData()
        }
       
    }
    
    
}
