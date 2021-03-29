//
//  LastEventTableViewCell.swift
//  SportApplication
//
//  Created by Hala on 28/03/2021.
//

import UIKit

class LastEventTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lastTableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        lastTableView.dataSource = self
        lastTableView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension LastEventTableViewCell : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = lastTableView.dequeueReusableCell(withIdentifier: String(describing: LastTableViewCell.self), for: indexPath) as? LastTableViewCell else {
            return UITableViewCell()
        }
        
        cell.layer.cornerRadius = 20
        
        cell.firstImageView.image = UIImage(named: "instagram")
        cell.secondImageView.image = UIImage(named: "instagram")
        
        cell.firstNameLabel.text = "hhhhhhh"
        cell.secondNameLabel.text = "sdfghjkl"
        
        cell.dateLabel.text = "date"
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return lastTableView.frame.height*0.43
    }
    
    
}

