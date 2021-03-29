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

        self.view.backgroundColor = MainColor.instance.backgroundColor
        designView.backgroundColor = MainColor.instance.ViewColor
        sportsCollectionView.layer.cornerRadius = 15
        
        sportsPresenter = SportsPresenter(view: self)
        sportsPresenter?.getSports()
        
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
    
    func reloadCollectionView() {
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



