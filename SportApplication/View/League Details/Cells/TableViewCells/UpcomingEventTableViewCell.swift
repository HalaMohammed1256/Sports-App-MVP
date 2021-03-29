//
//  UpcomingEventTableViewCell.swift
//  SportApplication
//
//  Created by Hala on 28/03/2021.
//

import UIKit

class UpcomingEventTableViewCell: UITableViewCell {


    let mainColor = MainColor()
    
    @IBOutlet weak var collectionView: UICollectionView!{
        
        didSet{
            collectionView.dataSource = self
            collectionView.delegate = self

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
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

        
        guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UpcomingCollectionViewCell.self), for: indexPath)  as? UpcomingCollectionViewCell else {
            
            return UICollectionViewCell()
        }
        
//        cell.backgroundColor = mainColor.backgroundColor
        cell.layer.cornerRadius = 10
        
        cell.firstImageView.image = UIImage(named: "instagram")
        cell.secondImageView.image = UIImage(named: "instagram")
        
        cell.firstNameLabel.text = "hhhhhhh"
        cell.secondNameLabel.text = "sdfghjkl"
        
        cell.dateLabel.text = "date"
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            return CGSize(width: (collectionView.frame.width/2.2), height: collectionView.frame.width/1.85)
    }
    
    
}
