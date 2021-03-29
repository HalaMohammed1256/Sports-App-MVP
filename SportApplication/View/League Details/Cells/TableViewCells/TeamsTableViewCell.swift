//
//  TeamsTableViewCell.swift
//  SportApplication
//
//  Created by Hala on 28/03/2021.
//

import UIKit

class TeamsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var teamCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        teamCollectionView.delegate = self
        teamCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension TeamsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

        
        guard  let cell = teamCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TeamCollectionViewCell.self), for: indexPath)  as? TeamCollectionViewCell else {
            
            return UICollectionViewCell()
        }
        
        cell.teamImageView.image = UIImage(named: "instagram")
        
        
        return cell
        
    }
    
    
}

