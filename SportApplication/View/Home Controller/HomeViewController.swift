//
//  HomeViewController.swift
//  SportApplication
//
//  Created by Hala on 20/03/2021.
//

import UIKit
import Reachability

class HomeViewController: UIViewController, SportsView{
   

    var sportsPresenter : SportsViewPresenter?
    var selectedIndex : Int?
    var indicator : ActivityIndicator?

    //declare this property where it won't go out of scope relative to your listener
    let reachability = try! Reachability()
    
    // outlets
    @IBOutlet weak var designView: UIView!
    @IBOutlet weak var sportsCollectionView: UICollectionView!{
        didSet{
            // collection view delegates
            sportsCollectionView.delegate = self
            sportsCollectionView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sportsPresenter = SportsPresenter(view: self)
        
        if reachability.connection == .unavailable{
            
        }else{
            self.view.backgroundColor = MainColor.instance.backgroundColor
            designView.backgroundColor = MainColor.instance.ViewColor
            sportsPresenter?.getSports()
        }
        
        
        sportsCollectionView.layer.cornerRadius = 15
        
        
        indicator = ActivityIndicator(view: sportsCollectionView)

        
        do{
            try reachability.startNotifier()

        }catch{
            print("error")
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
  

    }

    func startAnimating() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.indicator?.startAnimating()
        }
    }
    
    func reloadData() {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            self.sportsCollectionView.reloadData()
        })
    }
    
    func stopAnimating() {
        DispatchQueue.main.async {
            self.indicator?.stopAnimating()
            
        }
    }
    
}



