//
//  SportsPresenter.swift
//  SportApplication
//
//  Created by AhmedFareed on 25/03/2021.
//

import Foundation

protocol SportsView : class {
//    func startAnimating()
//    func stopAnimating()
    func reloadCollectionView()
}


protocol SportsViewPresenter {
    init(view : SportsView)
    func getSports()
}

class SportsPresenter: SportsViewPresenter {
    
    weak var view : SportsView?
    let group = DispatchGroup()

    
    required init(view: SportsView) {
        self.view? = view
    }

    var sports : [Sport]!{
        didSet{
            view?.reloadCollectionView()
        }
    }
    
    func getSports() {
        
        //view?.startAnimating()
        ApiServices.instance.getAllSportJsonData(url: ApiURls.allSports.rawValue) { (data: SportsModel?, error) in

            self.group.enter()
            
            if error != nil || data == nil{

                print("Error \(error!.localizedDescription)")

            }else if let sportsData = data{
                
             self.sports = (sportsData.sports)!
//              self.view?.reloadCollectionView()
            }
           // self.view?.stopAnimating()
    }
}
}
