//
//  TeamDetailsViewController.swift
//  SportApplication
//
//  Created by Hala on 20/03/2021.
//

import UIKit

class TeamDetailsViewController: UIViewController {
    
    @IBOutlet weak var teamDetailsTableView: UITableView!{
        didSet{
            teamDetailsTableView.dataSource = self
            teamDetailsTableView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.teamDetailsTableView.tableFooterView = UIView.init(frame: CGRect.zero)
        
        // Do any additional setup after loading the view.
    }
    



}
