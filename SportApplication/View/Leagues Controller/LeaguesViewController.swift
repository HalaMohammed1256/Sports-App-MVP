//
//  LeaguesViewController.swift
//  SportApplication
//
//  Created by Hala on 20/03/2021.
//

import UIKit

class LeaguesViewController: UIViewController {
    
    
    @IBOutlet weak var LeagueViewTableView: UITableView!{
        didSet{
            LeagueViewTableView.delegate = self
            LeagueViewTableView.dataSource = self
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = MainColor.instance.backgroundColor
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
