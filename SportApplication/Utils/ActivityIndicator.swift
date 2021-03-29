//
//  ActivityIndicator.swift
//  SportApplication
//
//  Created by AhmedFareed on 28/03/2021.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class ActivityIndicator {
    
    var view : UIView?
    var activityIndicator : NVActivityIndicatorView?
    
    init(view:UIView) {
        self.view = view
        activityIndicator = NVActivityIndicatorView(frame: .zero, type: .ballClipRotatePulse, color: .green, padding: 0)
    }
    fileprivate func buildIndicator() {
        activityIndicator?.translatesAutoresizingMaskIntoConstraints = false
        view?.addSubview(activityIndicator!)
        NSLayoutConstraint.activate([
            activityIndicator!.widthAnchor.constraint(equalToConstant: 40),
            activityIndicator!.heightAnchor.constraint(equalToConstant: 40),
            activityIndicator!.centerXAnchor.constraint(equalTo: view!.centerXAnchor),
            activityIndicator!.centerYAnchor.constraint(equalTo: view!.centerYAnchor)
        ])
    }
    
    func startAnimating() {
        buildIndicator()
        activityIndicator?.startAnimating()
    }
    func stopAnimating() {
        activityIndicator?.stopAnimating()
    }
}
