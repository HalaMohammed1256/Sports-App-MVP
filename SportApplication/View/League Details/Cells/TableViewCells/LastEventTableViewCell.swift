//
//  LastEventTableViewCell.swift
//  SportApplication
//
//  Created by Hala on 28/03/2021.
//

import UIKit


class LastEventTableViewCell: UITableViewCell {
    
    
    var homeTeamDetails : [[Team]]?{
        didSet{
            DispatchQueue.main.async {
                self.lastTableView.reloadData()
            }
        }
    }
    
    var awayTeamDetails : [[Team]]?{
        didSet{
            DispatchQueue.main.async {
                self.lastTableView.reloadData()
            }
        }
    }
    
    
    var leagueEventsDetails : [Event]?{
        
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
        return leagueEventsDetails?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = lastTableView.dequeueReusableCell(withIdentifier: String(describing: LastTableViewCell.self), for: indexPath) as? LastTableViewCell else {
            return UITableViewCell()
        }
        
        cell.layer.cornerRadius = 20

        
        if (homeTeamDetails?.count)! > indexPath.row {
            
            cell.firstImageView.sd_setImage(with: URL(string: homeTeamDetails![indexPath.row][0].strTeamBadge!), placeholderImage: UIImage(named: ""))
            
            cell.secondImageView.sd_setImage(with: URL(string: awayTeamDetails![indexPath.row][0].strTeamBadge!), placeholderImage: UIImage(named: ""))
            
        }
        
        
        cell.firstScoreLabel.text = leagueEventsDetails?[indexPath.row].intHomeScore
        cell.firstScoreLabel.backgroundColor = MainColor.instance.secondaryColor
        cell.firstScoreLabel.layer.cornerRadius = 12.5
        cell.firstScoreLabel.layer.masksToBounds = true
        
        cell.secondScoreLabel.text = leagueEventsDetails?[indexPath.row].intAwayScore
        cell.secondScoreLabel.backgroundColor = MainColor.instance.secondaryColor
        cell.secondScoreLabel.layer.masksToBounds = true
        cell.secondScoreLabel.layer.cornerRadius = 12.5
        
        
        
        cell.firstNameLabel.text = leagueEventsDetails?[indexPath.row].strHomeTeam!
        cell.secondNameLabel.text = leagueEventsDetails?[indexPath.row].strAwayTeam!
        
        cell.dateLabel.text = "\((leagueEventsDetails?[indexPath.row].strTime)!)\n\((leagueEventsDetails?[indexPath.row].dateEvent)!)"
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return lastTableView.frame.height*0.43
    }
    
    
}

