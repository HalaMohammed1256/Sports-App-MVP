//
//  LeagueDetailsPresenter.swift
//  SportApplication
//
//  Created by Hala on 29/03/2021.
//

import Foundation


protocol LeagueDetailsView: class {
    func reloadTable()
    func startAnimating()
    func stopAnimating()
}


protocol LeagueDetailsViewPresenter {
    
    init(view: LeagueDetailsView)
    
    var leagueEventsDetails : [Event]?{get set}
    var leagueTeamsDetails : [Team]?{get set}
    var teamsImage : String?{get set}
    
    func getEventsData(apiURL: String, id: String)
    func getTeamsData(apiURL: String, id: String)
}


class LeagueDetailsPresenter : LeagueDetailsViewPresenter{
    
    
    var teamsImage: String?{
        didSet{
            self.view?.reloadTable()
        }
    }
    
    
    var leagueEventsDetails: [Event]?{
        didSet{
            self.view?.reloadTable()
            view?.stopAnimating()
        }
    }
    
    
    var leagueTeamsDetails : [Team]?{
        didSet{
            self.view?.reloadTable()
            view?.stopAnimating()
        }
    }
    
    weak var view : LeagueDetailsView?
    
    required init(view: LeagueDetailsView) {
        self.view = view
    }
    
 
    

    func getEventsData(apiURL: String, id: String) {
        
        view?.startAnimating()
        
        ApiServices.instance.getResponses(url: apiURL, id: id) { (data: EventsModel?, error) in
            
            guard let eventData = data, error == nil else{
                return
            }
            
            self.leagueEventsDetails = eventData.events
        }
        //view?.reloadTable()
        
    }
    
    
    
    func getTeamsData(apiURL: String, id: String) {
        
        view?.startAnimating()
        
        ApiServices.instance.getResponses(url: apiURL, id: id) { (data: TeamsModel?, error) in
            
            guard let teamData = data, error == nil else{
                return
            }
            
            self.leagueTeamsDetails = teamData.teams
        }
        
        //view?.reloadTable()
    }
    
    
    func getTeamDetails(apiURL: String, id: String) {
        
        
        ApiServices.instance.getResponses(url: apiURL, id: id) { (data: TeamDataModel?, error) in
            
            guard let teamData = data, error == nil else{
                return
            }
            
            self.teamsImage = teamData.strTeamBadge
        }
        
    }
 
    
}



//func getResponse(apiURL: String, id: String) {
//
//        view?.startAnimating()
//
//        ApiServices.instance.getResponses(url: apiURL, id: id) { [weak self] (dataModel: model, error) in
//
//
//            guard let model = dataModel, error == nil else{
//                return
//            }
//
//            if model is Events{
//                self?.leagueDataDetails = (dataModel as! Events).events
//            }
//
//        }
//
//
//    }
