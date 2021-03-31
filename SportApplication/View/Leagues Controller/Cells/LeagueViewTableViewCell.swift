//
//  LeagueViewTableViewCell.swift
//  SportApplication
//
//  Created by Hala on 25/03/2021.
//

import UIKit

class LeagueViewTableViewCell: UITableViewCell {

    
    @IBOutlet weak var leaugueImageView: UIImageView!
    @IBOutlet weak var LeagueNameLabel: UILabel!
    @IBOutlet weak var youtubeChannelIcon: UIButton!
    
    
    var youtubeChannelAction: (() -> Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
    }
    
    
    
    
    @IBAction func youtubeChannelTapped(_ sender: Any) {
        youtubeChannelAction?()
    }
    

}
