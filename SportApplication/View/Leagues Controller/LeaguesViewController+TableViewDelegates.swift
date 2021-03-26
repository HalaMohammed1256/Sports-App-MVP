//
//  LeaguesViewController+TableViewDelegates.swift
//  SportApplication
//
//  Created by Hala on 25/03/2021.
//

import Foundation
import UIKit


extension LeaguesViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = LeagueViewTableView.dequeueReusableCell(withIdentifier: String(describing: LeagueViewTableViewCell.self), for: indexPath) as? LeagueViewTableViewCell else {
            return UITableViewCell()
        }
        
        cell.leaugeImageView.image = UIImage(named: "instagram")
        cell.LeagueNameLabel.text = "English League Championship"
//        cell.accessoryView = 
        
        return cell
        
    }
    
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableView.frame.height/6.4
        
        
    }
    
    
    
}
