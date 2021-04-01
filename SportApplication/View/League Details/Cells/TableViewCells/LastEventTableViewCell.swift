//
//  LastEventTableViewCell.swift
//  SportApplication
//
//  Created by Hala on 28/03/2021.
//

import UIKit


class LastEventTableViewCell: UITableViewCell {
    
    
    var homeTeamDetails = [[Team]]()
    
    var awayTeamDetails = [[Team]](){
        didSet{
            DispatchQueue.main.async {
                self.lastTableView.reloadData()
            }
        }
    }
    
    
    var leagueEventsDetails = [Event](){
        
        didSet{
            DispatchQueue.main.async {
                self.lastTableView.reloadData()
            }
        }
        
    }


    
    @IBOutlet weak var lastTableView: UITableView!{
        
        didSet{
            lastTableView.dataSource = self
            lastTableView.delegate = self
            
            lastTableView.allowsSelection = false
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension LastEventTableViewCell : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeTeamDetails.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = lastTableView.dequeueReusableCell(withIdentifier: String(describing: LastTableViewCell.self), for: indexPath) as? LastTableViewCell else {
            return UITableViewCell()
        }
        
        cell.layer.cornerRadius = 20

        if leagueEventsDetails[indexPath.row].strHomeTeam != nil{
        if (homeTeamDetails.count) > indexPath.row {
            for i in 0..<homeTeamDetails.count{
                if leagueEventsDetails[indexPath.row].idHomeTeam ?? "" == homeTeamDetails[i][0].idTeam{
                cell.firstImageView.setImage(url: homeTeamDetails[i][0].strTeamBadge ?? "")
                }
            }
        }
            if (awayTeamDetails.count) > indexPath.row{
            for i in 0..<awayTeamDetails.count{
                if leagueEventsDetails[indexPath.row].idAwayTeam ?? "" == awayTeamDetails[i][0].idTeam{
                cell.secondImageView.setImage(url: awayTeamDetails[i][0].strTeamBadge ?? "")
                }
            }
        }
        
        
        cell.firstScoreLabel.text = leagueEventsDetails[indexPath.row].intHomeScore
        cell.firstScoreLabel.backgroundColor = MainColor.instance.secondaryColor
        cell.firstScoreLabel.layer.cornerRadius = 12.5
        cell.firstScoreLabel.layer.masksToBounds = true
        
        cell.secondScoreLabel.text = leagueEventsDetails[indexPath.row].intAwayScore
        cell.secondScoreLabel.backgroundColor = MainColor.instance.secondaryColor
        cell.secondScoreLabel.layer.masksToBounds = true
        cell.secondScoreLabel.layer.cornerRadius = 12.5
        
        
        
        cell.firstNameLabel.text = leagueEventsDetails[indexPath.row].strHomeTeam ?? ""
        cell.secondNameLabel.text = leagueEventsDetails[indexPath.row].strAwayTeam ?? ""
        
        cell.dateLabel.text = "\((leagueEventsDetails[indexPath.row].strTime) ?? "")\n\(leagueEventsDetails[indexPath.row].dateEvent ?? "")"
            
        }else{
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return lastTableView.frame.height*0.43
    }
    
    
}

