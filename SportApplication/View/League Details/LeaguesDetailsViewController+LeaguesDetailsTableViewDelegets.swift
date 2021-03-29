//
//  LeaguesDetailsViewController+LeaguesDetailsTableViewDelegets.swift
//  SportApplication
//
//  Created by Hala on 28/03/2021.
//

import Foundation
import UIKit


extension LeaguesDetailsViewController : UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        var heightForRow : CGFloat = 0.0

        switch indexPath.section {
        case 0:
            heightForRow = leagueDetailsTableView.frame.height*0.22    // upcoming collection view
        case 1:
            heightForRow = leagueDetailsTableView.frame.height*0.43    // last table view

        case 2:
            heightForRow = leagueDetailsTableView.frame.height*0.2    // team collection view
        default:
            heightForRow = 0.0
        }

        return heightForRow
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 1
        
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var titleOfSections = ""
        
        switch section {
        case 0:
            titleOfSections = "Upcoming Events"    // upcoming collection view
        case 1:
            titleOfSections = "Last Events"    // last table view
            
        case 2:
            titleOfSections = "Teams"    // team collection view
        default:
            titleOfSections = ""
        }
        
        return titleOfSections
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            
            guard let cell = leagueDetailsTableView.dequeueReusableCell(withIdentifier: String(describing: UpcomingEventTableViewCell.self), for: indexPath)  as? UpcomingEventTableViewCell else {
                return UITableViewCell()
            }
            
            return cell
            
            
        case 1:
            
            guard let cell = leagueDetailsTableView.dequeueReusableCell(withIdentifier: String(describing: LastEventTableViewCell.self), for: indexPath)  as? LastEventTableViewCell else {
                return UITableViewCell()
            }
            
            return cell
            
            
            
        case 2:
            
            guard let cell = leagueDetailsTableView.dequeueReusableCell(withIdentifier: String(describing: TeamsTableViewCell.self), for: indexPath)  as? TeamsTableViewCell else {
                return UITableViewCell()
            }
            
            return cell
            
            
            
        default:
            return UITableViewCell()
        }
        
        
    }
        
}
    
    
    
