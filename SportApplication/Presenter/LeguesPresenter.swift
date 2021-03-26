//
//  LeguesPresenter.swift
//  SportApplication
//
//  Created by AhmedFareed on 26/03/2021.
//

import Foundation

protocol LeaguesView : class{
    func reloadTable()
}

protocol LeaguesViewPresenter{
    init(view:LeaguesView)
    var filteredLeagues : [League]?{get set}
    var leaguesDetails :[LeagueDetails]?{get set}
    func getLeagues(id : String)
}

class LeaguesPresenter: LeaguesViewPresenter{
    var leaguesDetails: [LeagueDetails]?{
        didSet{
            view?.reloadTable()
        }
    }
    
  
    var filteredLeagues: [League]?{
        didSet{
            view?.reloadTable()
        }
    }
    weak var view : LeaguesView?
    
    required init(view: LeaguesView) {
        self.view = view
    }
    
    
    func getLeagues(id : String) {
        ApiServices.instance.getAllSportJsonData(url: ApiURLs.allLeagues.rawValue) { (data: Leagues?, error) in
           
            guard let data = data , error == nil else{
                return
            }
            
            self.filteredLeagues = data.leagues!
        }
        
        ApiServices.instance.getLeguesWithId(url: ApiURLs.leaguesLookup.rawValue, id: id) { (data: LeaguesDetails?, error) in
            
            guard let data = data, error == nil else{
                return
            }
            
            self.leaguesDetails = data.leagues
        }
    }
    
    
    func getAllLeagues(sport : String){
        ApiServices.instance.getAllSportJsonData(url: ApiURLs.allLeagues.rawValue) { [self] (data: Leagues?, error) in
           
            guard let data = data , error == nil else{
                return
            }
            self.filteredLeagues = data.leagues?.filter({$0.strSport == sport})
//
//
//                }
//            }
        }
}
}
