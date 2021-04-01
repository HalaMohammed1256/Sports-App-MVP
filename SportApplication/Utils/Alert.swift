//
//  Alert.swift
//  SportApplication
//
//  Created by AhmedFareed on 01/04/2021.
//

import Foundation
import UIKit

class AlertViewBuilder{
    
    class func showAlert(presentedView : UIViewController, message : String, view: UITableView){
        let alert = UIAlertController(title: "ERROR", message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            view.reloadData()
        }))

        (presentedView).present(alert, animated: true)
    }
}
