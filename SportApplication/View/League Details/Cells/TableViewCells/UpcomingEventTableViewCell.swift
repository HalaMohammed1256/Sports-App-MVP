//
//  UpcomingEventTableViewCell.swift
//  SportApplication
//
//  Created by Hala on 28/03/2021.
//

import UIKit

class UpcomingEventTableViewCell: UITableViewCell, LeagueDetailsView{


    let mainColor = MainColor()
    var presenter : LeagueDetailsPresenter?
    
    
    var leagueEventsDetails : [Event]?{
        
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
    }
    
    @IBOutlet weak var collectionView: UICollectionView!{
        
        didSet{
            collectionView.dataSource = self
            collectionView.delegate = self

        }
        
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        presenter = LeagueDetailsPresenter(view: self)

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func startAnimating() {
        
    }
    
    func stopAnimating() {
        
    }

}


extension UpcomingEventTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return leagueEventsDetails?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

        
        guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UpcomingCollectionViewCell.self), for: indexPath)  as? UpcomingCollectionViewCell else {
            
            return UICollectionViewCell()
        }
        
        
//        cell.backgroundColor = mainColor.backgroundColor
        cell.layer.cornerRadius = 10
        
        
        presenter?.getTeamDetails(apiURL: ApiURLs.teamDetails.rawValue, id: "133636")
        //(leagueEventsDetails?[indexPath.row].idHomeTeam)!
                                        
//        cell.firstImageView.sd_setImage(with: URL(string: (presenter?.teamsImage!)!), placeholderImage: UIImage(named: ""))
                                        
        cell.secondImageView.sd_setImage(with: URL(string:  (leagueEventsDetails?[indexPath.row].strThumb!)!), placeholderImage: UIImage(named: ""))
        
        cell.firstNameLabel.text = leagueEventsDetails?[indexPath.row].strHomeTeam!
        cell.secondNameLabel.text = leagueEventsDetails?[indexPath.row].strAwayTeam!
        
        cell.dateLabel.text = "\((leagueEventsDetails?[indexPath.row].strTime)!)\n\((leagueEventsDetails?[indexPath.row].dateEvent)!)"
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            return CGSize(width: (collectionView.frame.width/2.2), height: collectionView.frame.width/1.85)
    }
    
    
}
