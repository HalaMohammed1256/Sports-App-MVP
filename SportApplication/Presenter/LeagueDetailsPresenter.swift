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
    
//    var leagueEventsDetails : [Event]?{get set}
//    var leagueTeamsDetails : [Team]?{get set}
    
    func getEventsData(apiURL: String, id: String)
    func getTeamsData(apiURL: String, id: String)
}


class LeagueDetailsPresenter : LeagueDetailsViewPresenter{
    
    let dispatchGroup = DispatchGroup()
    var leagueTeamsDetails = [Team]()
    weak var view : LeagueDetailsView?
    var homeTeamDetails = [[Team]]()
    
    required init(view: LeagueDetailsView) {
        self.view = view
    }
    
    var awayTeamDetails = [[Team]](){
        didSet{
            if awayTeamDetails.count >= leagueEventsDetails.count {
                awayTeamDetails.sort(by: {$0[0].idTeam! < $1[0].idTeam!})
                view?.reloadTable()
                view?.stopAnimating()
            }
        }
    }
    
    var leagueEventsDetails = [Event](){
        
        didSet{
//            leagueEventsDetails.sort(by: {$0.idHomeTeam! < $1.idHomeTeam!})
          
            dispatchGroup.enter()
            for i in 0..<leagueEventsDetails.count{
                ApiServices.instance.getResponses(url: ApiURLs.teamDetails.rawValue, id: leagueEventsDetails[i].idHomeTeam ?? "") { (data: Teams?, error) in
                    guard let teamData = data, error == nil else{
                        return
                    }
                    self.homeTeamDetails.append(teamData.teams!)
                }
            }
          //  homeTeamDetails.sort(by: {$0[0].idTeam! < $1[0].idTeam!})
            dispatchGroup.leave()
            
            
            dispatchGroup.enter()
            for i in 0..<leagueEventsDetails.count{
                
                ApiServices.instance.getResponses(url: ApiURLs.teamDetails.rawValue, id: leagueEventsDetails[i].idAwayTeam ?? "") { (data: Teams?, error) in

                    guard let teamData = data, error == nil else{
                        return
                    }
                    self.awayTeamDetails.append(teamData.teams!)
                }
            }
            dispatchGroup.leave()
    }
}

    func getEventsData(apiURL: String, id: String) {
                
        view?.startAnimating()
        
        ApiServices.instance.getResponses(url: apiURL, id: id) { (data: EventsModel?, error) in
            
            guard let eventData = data, error == nil else{
                return
            }
            
            self.leagueEventsDetails = eventData.events!
        }
    }
 
    func getTeamsData(apiURL: String, id: String) {
        
        view?.startAnimating()
        
        ApiServices.instance.getResponses(url: apiURL, id: id) { (data: Teams?, error) in
            
            guard let teamData = data, error == nil else{
                return
            }
            
            self.leagueTeamsDetails = teamData.teams!
        }
    
    }
}
