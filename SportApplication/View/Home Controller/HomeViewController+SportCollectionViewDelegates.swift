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
            
            numberOfItems = sportsPresenter?.sports?.count ?? 0
            print("Items in section: \(sportsPresenter?.sports?.count ?? 0)")
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
            cell.sportNameLabel.font = UIFont(name: "Merriweather-Black", size: 24)
            cell.sportNameLabel.textColor = MainColor.instance.noInternetColor
            cell.sportNameLabel.font = UIFont(name: "Merriweather-Black", size: collectionView.frame.width*0.07)
            
        }else{

            cell.sportImageView.setImage(url: sportsPresenter?.sports?[indexPath.row].strSportThumb ?? "")

            cell.sportNameLabel.text = sportsPresenter?.sports?[indexPath.row].strSport
            cell.sportNameLabel.font = UIFont(name: "Merriweather-Black", size: 15)
            cell.sportNameLabel.textColor = .black
            cell.sportNameLabel.font = UIFont(name: "Merriweather-Black", size: collectionView.frame.width*0.04)
        }
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          
        
        if reachability.connection == .unavailable{
            
            return CGSize(width: (collectionView.frame.width), height: collectionView.frame.height)
            
        }else{

            return CGSize(width: (collectionView.frame.width/2.1), height: collectionView.frame.width/1.85)

        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        
        if reachability.connection == .cellular || reachability.connection == .wifi{
            performSegue(withIdentifier: "leagues", sender: self)
        }
        
       
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LeaguesViewController{
            
            destination.sport =  self.sportsPresenter?.sports?[selectedIndex!].strSport
            destination.hidesBottomBarWhenPushed = true
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
