//
//  LeaguesViewController.swift
//  SportApplication
//
//  Created by Hala on 20/03/2021.
//

import UIKit
import SkeletonView

class LeaguesViewController: UIViewController {
    var leaguesPresenter : LeaguesPresenter?
    var sport : String?
    var urlLink : String?
    var idLeague : String?
    var leagueName : String?
    var leagueYoutubeLink : String?
    var leagueImage : String?
    var counter  = 0
    @IBOutlet weak var leagueViewTableView: UITableView!{
        didSet{
            leagueViewTableView.delegate = self
            leagueViewTableView.dataSource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        leagueViewTableView.rowHeight = 120
        leagueViewTableView.estimatedRowHeight = 120
        view.backgroundColor = MainColor.instance.backgroundColor
        
        leaguesPresenter = LeaguesPresenter(view: self)
        leaguesPresenter?.getAllFilteredLeagues(sport: sport ?? "")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if counter < 1 {
        leagueViewTableView.isSkeletonable = true
        let gradient = SkeletonGradient(baseColor: .clouds)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
        leagueViewTableView.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
        }
        counter += 1
    }
}

extension LeaguesViewController : LeaguesView{
    
    func startAnimating() {
    }
    
    func reloadData() {
            self.leagueViewTableView.reloadData()
    }

    func stopAnimating() {
        self.leagueViewTableView.stopSkeletonAnimation()
        self.view.hideSkeleton()
    }
}
