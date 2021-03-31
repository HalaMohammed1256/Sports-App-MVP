//
//  TeamDetailsViewController+TeamTableViewDataDelegets.swift
//  SportApplication
//
//  Created by Hala on 31/03/2021.
//

import Foundation
import UIKit

extension TeamDetailsViewController : UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        var heightForRow : CGFloat = 0.0

        switch indexPath.section {
        case 0:
            heightForRow = teamDetailsTableView.frame.height*0.56    // upcoming collection view
        case 1:
            heightForRow = teamDetailsTableView.frame.height*0.35    // last table view

        case 2:
            heightForRow = teamDetailsTableView.frame.height*0.052    // team collection view
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
    
    
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//        var titleOfSections = ""
//
//        switch section {
//        case 0:
//            titleOfSections = "Upcoming Events"    // upcoming collection view
//        case 1:
//            titleOfSections = "Last Events"    // last table view
//
//        case 2:
//            titleOfSections = "Teams"    // team collection view
//        default:
//            titleOfSections = ""
//        }
//
//        return titleOfSections
//
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            
            guard let cell = teamDetailsTableView.dequeueReusableCell(withIdentifier: String(describing: ImagesTableViewCell.self), for: indexPath)  as? ImagesTableViewCell else {
                return UITableViewCell()
            }

            
            return cell
            
            
        case 1:
            
            guard let cell = teamDetailsTableView.dequeueReusableCell(withIdentifier: String(describing: DescriptionTableViewCell.self), for: indexPath)  as? DescriptionTableViewCell else {
                return UITableViewCell()
            }
            
            
            return cell
            
            
            
        case 2:
            
            guard let cell = teamDetailsTableView.dequeueReusableCell(withIdentifier: String(describing: ContactsTableViewCell.self), for: indexPath)  as? ContactsTableViewCell else {
                return UITableViewCell()
            }
            
            
            return cell
            
            
        default:
            return UITableViewCell()
        }
        
        
    }
    
    
    
}

