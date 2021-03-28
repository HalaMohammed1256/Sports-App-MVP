//
//  WebViewController.swift
//  SportApplication
//
//  Created by Hala on 28/03/2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var urlLink : String?
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard let urlString = urlLink else {
            return
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        
        webView.load(URLRequest(url: url))
       
    }
    

    

}
