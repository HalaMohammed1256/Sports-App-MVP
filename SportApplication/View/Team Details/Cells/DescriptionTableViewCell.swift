//
//  DescriptionTableViewCell.swift
//  SportApplication
//
//  Created by Hala on 31/03/2021.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var descriptionTextView: UITextView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
