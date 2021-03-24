//
//  HomeViewController+SportCollectionViewDelegates.swift
//  SportApplication
//
//  Created by Hala on 22/03/2021.
//

import UIKit
import SDWebImage


extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var numberOfItems = 0
        
        if reachability.connection == .unavailable{
            
            numberOfItems = 1
            
        }else{
            
            numberOfItems = sportsArray.count
            
        }
        
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        
        let cell = sportsCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SportCollectionViewCell.self), for: indexPath) as! SportCollectionViewCell
        
        
        if reachability.connection == .unavailable{
            
            cell.sportImageView.image = UIImage(named: "no_internet3")
            cell.sportImageView.contentMode = .scaleAspectFit
            cell.sportNameLabel.text = "No Internet Connection!"
            cell.sportNameLabel.font = UIFont(name: "Merriweather-Black", size: 30)
            
        }else{
            
            cell.sportImageView.sd_setImage(with: URL(string:  sportsArray[indexPath.row].strSportThumb!), placeholderImage: UIImage(named: "no_internet"))
            
            cell.sportNameLabel.text = sportsArray[indexPath.row].strSport
            cell.sportNameLabel.font = UIFont(name: "Merriweather-Black", size: 15)
            cell.sportNameLabel.textColor = .black
        }
        
        
        
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          
        
        if reachability.connection == .unavailable{
            
            return CGSize(width: (collectionView.frame.width), height: collectionView.frame.height)
            
        }else{
            
            return CGSize(width: (collectionView.frame.width/2.1), height: collectionView.frame.width/2)
            
        }

    }
    
    
    
    
}
