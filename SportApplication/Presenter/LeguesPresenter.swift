//
//  LeguesPresenter.swift
//  SportApplication
//
//  Created by AhmedFareed on 26/03/2021.
//

import Foundation

protocol LeaguesView : class{
    func reloadTable()
    func startAnimating()
    func stopAnimating()
}


protocol LeaguesViewPresenter{
    init(view:LeaguesView)
    var filteredLeagues : [League]?{get set}
    func getAllFilteredLeagues(sport : String)
}

class LeaguesPresenter: LeaguesViewPresenter{
    
    
    var leaguesDetails = [[LeagueDetails]]()
    let dispatchGroup = DispatchGroup()
    weak var view : LeaguesView?
    required init(view: LeaguesView) {
        self.view = view
    }
    
    var filteredLeagues: [League]?{
       
        didSet{
         
            for i in 0..<filteredLeagues!.count{
                dispatchGroup.enter()
                ApiServices.instance.getResponses(url: ApiURLs.leaguesLookup.rawValue, id: filteredLeagues?[i].idLeague ?? "") { (detailsData: LeaguesDetails?, error) in
                    guard let detailsData = detailsData, error == nil else{
                        return
                    }
                    self.leaguesDetails.append(detailsData.leagues!)
                }
            }
            dispatchGroup.leave()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.view?.stopAnimating()
                self.view?.reloadTable()
             
            }
        }
    }
    
    
    func getAllFilteredLeagues(sport : String){
        
        view?.startAnimating()
            ApiServices.instance.getResponses(url: ApiURLs.allLeagues.rawValue) { [self] (data: Leagues?, error) in
               
                guard let data = data , error == nil else{
                    return
                }
                self.filteredLeagues = data.leagues?.filter({$0.strSport == sport})
            }
        
       
}
}
}
