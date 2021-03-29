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
//        leagueCell.LeagueNameLabel.text = leaguesPresenter?.filteredLeagues![indexPath.row].strLeague
        
//        leagueCell.LeagueNameLabel.text = leaguesPresenter?.leaguesDetails[indexPath.row][0].strLeague
//        leagueCell.leaugueImageView.layer.cornerRadius = 12
        
        leagueCell.leaugueImageView.sd_imageIndicator =  SDWebImageActivityIndicator.gray
        if (leaguesPresenter?.leaguesDetails.count)! > indexPath.row {
            
            leagueCell.LeagueNameLabel.text = leaguesPresenter?.leaguesDetails[indexPath.row][0].strLeague
            leagueCell.leaugueImageView.layer.cornerRadius = 12
            
            leagueCell.leaugueImageView.sd_setImage(with: URL(string: (leaguesPresenter?.leaguesDetails[indexPath.row][0].strBadge) ?? ""), placeholderImage: UIImage(named: "no_internet"))
            
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let youtubeURL = urlLink else {
            return
        }
        
        if let destination = segue.destination as? WebViewController{
            destination.urlLink = "https://" + youtubeURL
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let details = self.storyboard?.instantiateViewController(withIdentifier: "LeaguesDetailsViewController") as! LeaguesDetailsViewController
        
        self.present(details, animated: true, completion: nil)
        
    }
    
}
