//
//  SportsPresenter.swift
//  SportApplication
//
//  Created by AhmedFareed on 25/03/2021.
//

import Foundation

protocol SportsView : class, SuperClass {
    func startAnimating()
    func stopAnimating()
}


protocol SportsViewPresenter {
    init(view : SportsView)
    var sports : [Sport]?{get set}
    func getSports()
}

class SportsPresenter: SportsViewPresenter {

    var sports: [Sport]?{
        didSet{
            self.view?.reloadData()
            view?.stopAnimating()
        }
    }
    
    weak var view : SportsView?
    
    required init(view: SportsView) {
        self.view = view
    }
    
    func getSports() {
        

            view?.startAnimating()
            
            ApiServices.instance.getResponses(url: ApiURLs.allSports.rawValue) { (data: SportsModel?, error) in
                        
                guard let data = data, error == nil else{
                    return
                }
                self.sports = (data.sports)!
            }
            
        
    }
    
    
}
