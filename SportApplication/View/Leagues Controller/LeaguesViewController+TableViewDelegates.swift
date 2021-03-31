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
        
        if (leaguesPresenter?.leaguesDetails.count)! > indexPath.row {
            
            leagueCell.LeagueNameLabel.text = leaguesPresenter?.leaguesDetails[indexPath.row][0].strLeague
            
            leagueCell.leaugueImageView.layer.cornerRadius = 12
            
            leagueCell.leaugueImageView.setImage(url: (leaguesPresenter?.leaguesDetails[indexPath.row][0].strBadge) ?? "")
            
            if leaguesPresenter?.leaguesDetails[indexPath.row][0].strYoutube != ""{
                
                leagueCell.youtubeChannelIcon.isHidden = false
                
                leagueCell.youtubeChannelAction = {
                    
                    if let youtubeLink = self.leaguesPresenter?.leaguesDetails[indexPath.row][0].strYoutube{
                        self.urlLink = youtubeLink
                    }
                    
                    self.performSegue(withIdentifier: "webView", sender: self)
                    
                }
                
            }else{
                leagueCell.youtubeChannelIcon.isHidden = true
            }
            
        }
       
        
        return leagueCell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.idLeague = leaguesPresenter?.leaguesDetails[indexPath.row][0].idLeague
        self.leagueName = leaguesPresenter?.leaguesDetails[indexPath.row][0].strLeague
        
        performSegue(withIdentifier: "leagueDetails", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let webViewDestination = segue.destination as? WebViewController
        
        let leagueDetailsDestination = segue.destination as?
            LeaguesDetailsViewController
        
        let identifier = segue.identifier
        
        if identifier == "webView" {
            webViewDestination!.urlLink = "https://" + urlLink!
        }else if identifier == "leagueDetails"{
            leagueDetailsDestination!.leagueID = idLeague
            leagueDetailsDestination!.leagueName = leagueName
        }
              
    }
    
}
