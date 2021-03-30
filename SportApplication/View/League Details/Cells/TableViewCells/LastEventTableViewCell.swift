//
//  LastEventTableViewCell.swift
//  SportApplication
//
//  Created by Hala on 28/03/2021.
//

import UIKit


class LastEventTableViewCell: UITableViewCell {
    
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
//        
//        cell.firstImageView.sd_setImage(with: URL(string:  (leagueEventsDetails?[indexPath.row].strThumb!)!), placeholderImage: UIImage(named: ""))
//        cell.secondImageView.sd_setImage(with: URL(string:  (leagueEventsDetails?[indexPath.row].strThumb!)!), placeholderImage: UIImage(named: ""))
        
        cell.firstNameLabel.text = leagueEventsDetails?[indexPath.row].strHomeTeam!
        cell.secondNameLabel.text = leagueEventsDetails?[indexPath.row].strAwayTeam!
        
        cell.dateLabel.text = "\((leagueEventsDetails?[indexPath.row].strTime)!)\n\((leagueEventsDetails?[indexPath.row].dateEvent)!)"
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return lastTableView.frame.height*0.43
    }
    
    
}

