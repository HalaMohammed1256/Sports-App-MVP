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
            heightForRow = teamDetailsTableView.frame.height*0.594
        case 1:
            heightForRow = teamDetailsTableView.frame.height*0.35
        case 2:
            heightForRow = teamDetailsTableView.frame.height*0.052
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            
            guard let cell = teamDetailsTableView.dequeueReusableCell(withIdentifier: String(describing: ImagesTableViewCell.self), for: indexPath)  as? ImagesTableViewCell else {
                return UITableViewCell()
            }
            
            cell.teamLogo.setImage(url: team?.strTeamBadge ?? "")
            cell.teamStadiumImage.setImage(url: team?.strStadiumThumb ?? "")
            cell.teamNameAndDateLabel.text = "\(team?.strTeam ?? "" ) \(team?.intFormedYear ?? "")"
            cell.leagueNameLabel.text = team?.strLeague
            cell.StadiumNameLabel.text = team?.strStadium
            cell.countryNameLabel.text = team?.strCountry
            return cell
            
        case 1:
            
            guard let cell = teamDetailsTableView.dequeueReusableCell(withIdentifier: String(describing: DescriptionTableViewCell.self), for: indexPath)  as? DescriptionTableViewCell else {
                return UITableViewCell()
            }
            
            cell.descriptionTextView.text = team?.strDescriptionEN
            cell.descriptionTextView.isEditable = false
            
            return cell
            
            
            
        case 2:
            
            guard let cell = teamDetailsTableView.dequeueReusableCell(withIdentifier: String(describing: ContactsTableViewCell.self), for: indexPath)  as? ContactsTableViewCell else {
                return UITableViewCell()
            }
            
            cell.facebookAction = { [weak self] in
                self?.urlLink = self?.team?.strFacebook
                
                self?.performSegue(withIdentifier: "teamContact", sender: self)
            }
            
            
            cell.twitterAction = { [weak self] in
                self?.urlLink = self?.team?.strTwitter
                
                self?.performSegue(withIdentifier: "teamContact", sender: self)
            }
            
            cell.instagramAction = { [weak self] in
                self?.urlLink = self?.team?.strInstagram
                
                self?.performSegue(withIdentifier: "teamContact", sender: self)
            }
            
            
            
            
            return cell
            
            
        default:
            return UITableViewCell()
        }
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let webViewDestination = segue.destination as? WebViewController
        
        guard let url = urlLink else {
            return
        }
        
        if segue.identifier == "teamContact"{
            webViewDestination?.urlLink = "https://" + url
        }
    }
}

