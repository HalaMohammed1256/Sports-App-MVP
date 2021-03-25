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
    var sports : [Sport]?{get set}
    func getSports()
}

class SportsPresenter: SportsViewPresenter {

    var sports: [Sport]?{
        didSet{
            self.view?.reloadCollectionView()
        }
    }
    
    weak var view : SportsView?
    
    required init(view: SportsView) {
        self.view = view
    }
    
    func getSports() {
        
        ApiServices.instance.getAllSportJsonData(url: ApiURls.allSports.rawValue) { (data: SportsModel?, error) in
                    
            guard let data = data, error == nil else{
                return
            }
            self.sports = (data.sports)!

        
//        //view?.startAnimating()
//        let apiService = ApiServices()
//
//        apiService.getAllSportJsonData(url: ApiURls.allSports.rawValue) { (data: SportsModel?, ,error) in
//
//            guard let data = data , error == nil else{
//                return
//            }
//            self.sports = (data.sports)!
//
//            }
//           // self.view?.stopAnimating()
//    }
}
}

}
