//
//  FavoriteViewController.swift
//  SportApplication
//
//  Created by Hala on 20/03/2021.
//

import UIKit
import Reachability

class FavoriteViewController: UIViewController, FavoriteView{
    
    var idLeague : String?
    var leagueName : String?
    var leagueYoutubeLink : String?
    var urlLink : String?
    
    
    var favoritePresenter : FavoritePresenter?
    let delegate = (UIApplication.shared.delegate as! AppDelegate)
    
    let reachability = try! Reachability()
    
    @IBOutlet weak var favoriteTableView: UITableView!{
        didSet{
            favoriteTableView.delegate = self
            favoriteTableView.dataSource = self
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        favoritePresenter = FavoritePresenter.init(view: self)
        favoritePresenter?.fetchFavoriteLeaguesFromCoreData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favoritePresenter?.fetchFavoriteLeaguesFromCoreData()
    }
    
    
    func reloadData() {
        DispatchQueue.main.async { [self] in
            favoriteTableView.reloadData()
        }
    }

}
