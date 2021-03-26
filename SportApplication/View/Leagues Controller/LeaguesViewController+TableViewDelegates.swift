//
//  LeaguesViewController+TableViewDelegates.swift
//  SportApplication
//
//  Created by Hala on 25/03/2021.
//

import Foundation
import UIKit
import SDWebImage

extension LeaguesViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguesPresenter?.filteredLeagues?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let leagueCell = tableView.dequeueReusableCell(withIdentifier: "LeagueViewTableViewCell") as? LeagueViewTableViewCell else {
            return UITableViewCell()
        }
        leagueCell.LeagueNameLabel.text = leaguesPresenter?.filteredLeagues![indexPath.row].strLeague
      
        //  leagueCell.leaugueImageView.sd_setImage(with: URL(string:  (leaguesPresenter?.leaguesDetails?[indexPath.row].strBadge) ?? ""), placeholderImage: UIImage(named: "no_internet"))
        return leagueCell
        
    }
    
}
