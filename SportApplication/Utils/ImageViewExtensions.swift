//
//  ImageViewExtensions.swift
//  SportApplication
//
//  Created by AhmedFareed on 31/03/2021.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView{
    func setImage(url:String, placeholder : String = ""){
        self.sd_imageIndicator =  SDWebImageActivityIndicator.gray
        self.sd_setImage(with: URL(string:url), placeholderImage: UIImage(named: placeholder))
    }
}
