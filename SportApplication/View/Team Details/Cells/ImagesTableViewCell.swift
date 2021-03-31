//
//  ImagesTableViewCell.swift
//  SportApplication
//
//  Created by Hala on 31/03/2021.
//

import UIKit

class ImagesTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var teamStadiumImage: UIImageView!
    @IBOutlet weak var teamNameAndDateLabel: UILabel!
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var StadiumNameLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    
    @IBOutlet weak var teamLogo: UIImageView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
