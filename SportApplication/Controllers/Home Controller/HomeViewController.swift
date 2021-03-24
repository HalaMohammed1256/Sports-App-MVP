//
//  HomeViewController.swift
//  SportApplication
//
//  Created by Hala on 20/03/2021.
//

import UIKit
import Reachability

class HomeViewController: UIViewController {

    var mainColor = MainColor()
    lazy var sportsArray = [Sports]()
    
    
    //declare this property where it won't go out of scope relative to your listener
    let reachability = try! Reachability()
    
    // outlets
    @IBOutlet weak var sportsCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = mainColor.backgroundColor
        
        // collection view delegets
        sportsCollectionView.delegate = self
        sportsCollectionView.dataSource = self
        
        sportsCollectionView.layer.cornerRadius = 30
        
        getSports()
        
        do{
            try reachability.startNotifier()

        }catch{
            print("error")
        }
        
        
    }
    
    
    
    func getSports() {
        
        ApiServices.instance.getAllSportJsonData(url: ApiURls.allSports.rawValue) { (data: SportsModel?, error) in
            
            if error != nil || data == nil{
                
                print(error!)
                
            }else if let sportsData = data{
                
                self.sportsArray = (sportsData.sports)!
                
                DispatchQueue.main.async {
                    self.sportsCollectionView.reloadData()
                }
            
                
            }
            
        }
        
    }
    

    
}
