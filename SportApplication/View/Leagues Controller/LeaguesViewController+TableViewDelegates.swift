//
//  LeaguesViewController+TableViewDelegates.swift
//  SportApplication
//
//  Created by Hala on 25/03/2021.
//

import Foundation
import UIKit
import SkeletonView


extension String {
    func trimWhiteSpace() -> String {
        let string = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return string
    }
}


extension LeaguesViewController : UISearchBarDelegate{
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let searchString = searchText.trimWhiteSpace()
        if searchString.count > 0 {
            isFilled = true
            filteredData = leaguesPresenter?.leaguesDetails.filter {
                return $0[0].strLeague?.range(of: searchString, options: .caseInsensitive) != nil
            }
        }else{
            isFilled = false
        }
        
        self.leagueViewTableView.reloadData()
        
    }
    
}


extension LeaguesViewController : UITableViewDelegate, SkeletonTableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numberOfRowes: Int = 0
        
        if isFilled{
            numberOfRowes = filteredData?.count ?? 0
        }else{
            numberOfRowes = leaguesPresenter?.filteredLeagues?.count ?? 0
        }
        
        return numberOfRowes
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return leaguesPresenter?.filteredLeagues?.count ?? 0
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        
        return LeagueViewTableViewCell.identifier
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let leagueCell = tableView.dequeueReusableCell(withIdentifier: LeagueViewTableViewCell.identifier) as? LeagueViewTableViewCell else {
            return UITableViewCell()
        }
        
        if (leaguesPresenter?.leaguesDetails.count)! > indexPath.row {
            
            
            if isFilled{
                
                leagueCell.LeagueNameLabel.text = filteredData![indexPath.row][0].strLeague
                leagueCell.LeagueNameLabel.font = .systemFont(ofSize: leagueViewTableView.frame.height * 0.025)
                
                leagueCell.leaugueImageView.layer.cornerRadius = 12
                
                leagueCell.leaugueImageView.setImage(url: (filteredData![indexPath.row][0].strBadge) ?? "")
                
                if filteredData![indexPath.row][0].strYoutube != ""{
                    
                    leagueCell.youtubeChannelIcon.isHidden = false
                    
                    leagueCell.youtubeChannelAction = {
                        
                        if let youtubeLink = self.filteredData![indexPath.row][0].strYoutube{
                            self.urlLink = youtubeLink
                        }
                        
                        self.performSegue(withIdentifier: "webView", sender: self)
                        
                    }
                    
                }else{
                    leagueCell.youtubeChannelIcon.isHidden = true
                }
                
            }else{
                
                leagueCell.LeagueNameLabel.text = leaguesPresenter?.leaguesDetails[indexPath.row][0].strLeague
                leagueCell.LeagueNameLabel.font = .systemFont(ofSize: leagueViewTableView.frame.height * 0.025)
                
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
        }
        
        
        return leagueCell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isFilled{
            self.idLeague = filteredData![indexPath.row][0].idLeague
            self.leagueName = filteredData![indexPath.row][0].strLeague
            self.leagueYoutubeLink = filteredData![indexPath.row][0].strYoutube
            self.leagueImage = filteredData![indexPath.row][0].strBadge
            
            
            
        }else{
            self.idLeague = leaguesPresenter?.leaguesDetails[indexPath.row][0].idLeague
            self.leagueName = leaguesPresenter?.leaguesDetails[indexPath.row][0].strLeague
            self.leagueYoutubeLink = leaguesPresenter?.leaguesDetails[indexPath.row][0].strYoutube
            self.leagueImage = leaguesPresenter?.leaguesDetails[indexPath.row][0].strBadge
            
                        
        }
        
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
            leagueDetailsDestination?.leagueYoutubeLink = leagueYoutubeLink
            leagueDetailsDestination?.leagueImage = leagueImage
            
        }
        
    }
}
