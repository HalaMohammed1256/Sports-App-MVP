//
//  FavoriteViewController+FavoriteLeagueTableViewDelegets.swift
//  SportApplication
//
//  Created by Hala on 31/03/2021.
//

import Foundation
import UIKit



extension FavoriteViewController : UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (favoritePresenter?.favoriteLeaguesArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let leagueCell = tableView.dequeueReusableCell(withIdentifier: "LeagueViewTableViewCell") as? LeagueViewTableViewCell else {
            return UITableViewCell()
        }
        
        
        leagueCell.LeagueNameLabel.text = favoritePresenter?.favoriteLeaguesArray![indexPath.row].value(forKey: "leagueName") as? String
            
        leagueCell.leaugueImageView.layer.cornerRadius = 12
            
        leagueCell.leaugueImageView.setImage(url: (favoritePresenter?.favoriteLeaguesArray![indexPath.row].value(forKey: "leagueImage") as! String))
        

        
        if (favoritePresenter?.favoriteLeaguesArray![indexPath.row].value(forKey: "leagueYoutubeLink") as! String) != ""{
                
            leagueCell.youtubeChannelIcon.isHidden = false
            
            if reachability.connection == .unavailable{
                
                leagueCell.youtubeChannelAction = {
                    self.favoritePresenter?.showAlert()
                }
                
            }else{
                
                leagueCell.youtubeChannelAction = {
                    
                    if let youtubeLink = self.favoritePresenter?.favoriteLeaguesArray![indexPath.row].value(forKey: "leagueYoutubeLink"){
                        self.urlLink = youtubeLink as? String
                    }
                    
                    self.performSegue(withIdentifier: "favoriteWebView", sender: self)
                    
                }
                
            }
        }else{
            leagueCell.youtubeChannelIcon.isHidden = true
        }
        
        
        
        return leagueCell
        
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if reachability.connection == .unavailable{
                        
            favoritePresenter?.showAlert()
            
            
        }else{
            self.idLeague = favoritePresenter?.favoriteLeaguesArray![indexPath.row].value(forKey: "leagueID") as? String
            self.leagueName = favoritePresenter?.favoriteLeaguesArray![indexPath.row].value(forKey: "leagueName") as? String
            self.leagueYoutubeLink = favoritePresenter?.favoriteLeaguesArray![indexPath.row].value(forKey: "leagueYoutubeLink") as? String
            
            performSegue(withIdentifier: "favoriteLeagueDetails", sender: self)
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
                
            
            if reachability.connection == .unavailable{
                
                //remove from core data
                favoritePresenter?.deleteLeaguefromCoreData(index: indexPath.row)
                
                
                // remove from table
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        
            
        
            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        
    }
    

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let webViewDestination = segue.destination as? WebViewController
        
        let leagueDetailsDestination = segue.destination as?
            LeaguesDetailsViewController
        
        let identifier = segue.identifier
        
        if identifier == "favoriteWebView" {
            webViewDestination!.urlLink = "https://" + urlLink!
        }else if identifier == "favoriteLeagueDetails"{
            leagueDetailsDestination!.leagueID = idLeague
            leagueDetailsDestination!.leagueName = leagueName
            leagueDetailsDestination?.leagueYoutubeLink = leagueYoutubeLink
        }
              
    }
    
}

