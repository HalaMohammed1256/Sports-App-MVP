//
//  UpcomingEventTableViewCell.swift
//  SportApplication
//
//  Created by Hala on 28/03/2021.
//

import UIKit

class UpcomingEventTableViewCell: UITableViewCell{
    let mainColor = MainColor()
    var homeTeamDetails = [[Team]]()
    var awayTeamDetails = [[Team]]()
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    
    var leagueEventsDetails = [Event](){
       didSet{
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
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

extension UpcomingEventTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return leagueEventsDetails.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
        guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UpcomingCollectionViewCell.self), for: indexPath)  as? UpcomingCollectionViewCell else {
            
            return UICollectionViewCell()
        }
        
    
        cell.layer.cornerRadius = 10
        
        
        if leagueEventsDetails[indexPath.row].strHomeTeam != nil{
        cell.firstNameLabel.text = leagueEventsDetails[indexPath.row].strHomeTeam ?? ""
        cell.secondNameLabel.text = leagueEventsDetails[indexPath.row].strAwayTeam ?? ""
        
        cell.dateLabel.text = "\((leagueEventsDetails[indexPath.row].strTime)!)\n\((leagueEventsDetails[indexPath.row].dateEvent)!)"

        
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
            
        }else{
            
           // AlertViewBuilder.showAlert(presentedView: self, message: "There is no data", view: nil)
            print("there is no data")
        }
        
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            return CGSize(width: (collectionView.frame.width/2.2), height: collectionView.frame.width/1.85)
    }
    
}

