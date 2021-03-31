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

    
    func getEventsData(apiURL: String, id: String)
    func getTeamsData(apiURL: String, id: String)
}


class LeagueDetailsPresenter : LeagueDetailsViewPresenter{
    
    let dispatchGroup = DispatchGroup()
    
    var homeTeamDetails = [[Team]](){
        didSet{
            view?.reloadTable()
            view?.stopAnimating()
        }
    }
    
    var awayTeamDetails = [[Team]](){
        didSet{
            view?.reloadTable()
            view?.stopAnimating()
        }
    }
    
    var leagueEventsDetails: [Event]?{
        
        didSet{
            if !leagueEventsDetails!.isEmpty{
            for i in 0..<leagueEventsDetails!.count{
                ApiServices.instance.getResponses(url: ApiURLs.teamDetails.rawValue, id: leagueEventsDetails?[i].idHomeTeam ?? "") { (data: Teams?, error) in

                    guard let teamData = data, error == nil else{
                        return
                    }

                    self.homeTeamDetails.append(teamData.teams!)
                    

                }
                
                
                ApiServices.instance.getResponses(url: ApiURLs.teamDetails.rawValue, id: leagueEventsDetails?[i].idAwayTeam ?? "") { (data: Teams?, error) in

                    guard let teamData = data, error == nil else{
                        return
                    }

                    self.awayTeamDetails.append(teamData.teams!)

                }

            }

        }
        
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
        
        
    }
    
    
    
    func getTeamsData(apiURL: String, id: String) {
        
        view?.startAnimating()
        
        ApiServices.instance.getResponses(url: apiURL, id: id) { (data: Teams?, error) in
            
            guard let teamData = data, error == nil else{
                return
            }
            
            self.leagueTeamsDetails = teamData.teams
        }
    
    }
    

    
    
}


