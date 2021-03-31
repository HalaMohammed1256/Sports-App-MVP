//
//  ContactsTableViewCell.swift
//  SportApplication
//
//  Created by Hala on 31/03/2021.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var facebookOutlet: UIButton!
    @IBOutlet weak var twitterOutlet: UIButton!
    @IBOutlet weak var instagramOutlet: UIButton!
    
    


    var facebookAction: (() -> Void)?
    var twitterAction: (() -> Void)?
    var instagramAction: (() -> Void)?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func facebookTapped(_ sender: Any) {
        facebookAction?()
    }
    
    @IBAction func twitterTapped(_ sender: Any) {
        twitterAction?()
    }
    
    @IBAction func instagramTapped(_ sender: Any) {
        instagramAction?()
    }
    
    


}

