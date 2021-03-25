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
        
        cell.sportImageView.layer.cornerRadius = 15
        
        
        if reachability.connection == .unavailable{
            
            designView.isHidden = true
            
            cell.sportImageView.image = UIImage(named: "no_internet4")
            cell.sportImageView.contentMode = .scaleToFill
            cell.sportNameLabel.text = "No Internet Connection!"
            cell.sportNameLabel.font = UIFont(name: "Merriweather-Black", size: collectionView.frame.width*0.07)//24
        cell.sportNameLabel.textColor = mainColor.noInternetColor
            
        }else{

            cell.sportImageView.sd_setImage(with: URL(string:  sportsArray[indexPath.row].strSportThumb!), placeholderImage: UIImage(named: "no_internet"))

            
            cell.sportNameLabel.text = sportsArray[indexPath.row].strSport
//            cell.sportNameLabel.font = UIFont(name: "Merriweather-Black", size: 15)
            cell.sportNameLabel.font = UIFont(name: "Merriweather-Black", size: collectionView.frame.width*0.04)//24
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let leaguesView = self.storyboard?.instantiateViewController(identifier: String(describing: LeaguesViewController.self)) as! LeaguesViewController
        
        
        // sequa
        
    }
    
    
    
    
}
