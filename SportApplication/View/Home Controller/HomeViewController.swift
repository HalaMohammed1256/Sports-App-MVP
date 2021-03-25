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
        sportsPresenter = SportsPresenter(view: self)
        designView.backgroundColor = MainColor.instance.ViewColor
        sportsCollectionView.layer.cornerRadius = 15
        
      //  getSports()
   
      sportsPresenter?.getSports()
        
        do{
            try reachability.startNotifier()

        }catch{
            print("error")
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
  

    }
    
    func reloadCollectionView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.sportsCollectionView.reloadData()
        })
    }
}


 /*   func getSports() {

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

    }*/
    
    
