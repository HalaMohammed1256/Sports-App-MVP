//
//  LeagueDetailsPresenter.swift
//  SportApplication
//
//  Created by Hala on 29/03/2021.
//

import Foundation
import CoreData

protocol LeagueDetailsView: class, SuperClass {
    func reloadData()
    func startAnimating()
    func stopAnimating()
}

protocol LeagueDetailsViewPresenter {
    init(view: LeagueDetailsView, delegate : AppDelegate)
    func getEventsData(apiURL: String, id: String)
    func getTeamsData(apiURL: String, id: String)
    func saveLeagueToCoreData(leagueID: String, leagueName: String, leagueYoutubeLink: String, leagueImage: String)
    func deleteLeaguefromCoreData(leagueID: String)
}

class LeagueDetailsPresenter : LeagueDetailsViewPresenter{
    let delegate : AppDelegate?
    var favoriteLeague = NSManagedObject()
    let dispatchGroup = DispatchGroup()
    weak var view : LeagueDetailsView?
    
    var fetchedLeaguesArray = [NSManagedObject](){
    didSet{
        self.view?.reloadData()
    }
}
    
    var homeTeamDetails = [[Team]]()
    var leagueTeamsDetails = [Team](){
        didSet{
            self.view?.stopAnimating()
            self.view?.reloadData()
        }
        
    }
    var awayTeamDetails = [[Team]](){
        didSet{
            if awayTeamDetails.count == leagueEventsDetails.count{
                self.view?.stopAnimating()
                self.view?.reloadData()
            }
        }
    }
    
    required init(view: LeagueDetailsView, delegate : AppDelegate) {
        self.view = view
        self.delegate = delegate
    }
    
    var leagueEventsDetails = [Event](){
        didSet{
            
            for i in 0..<leagueEventsDetails.count{
                dispatchGroup.enter()
                
                if leagueEventsDetails[i].idHomeTeam != nil{
                    ApiServices.instance.getResponses(url: ApiURLs.teamDetails.rawValue, id: leagueEventsDetails[i].idHomeTeam ?? "") { (data: Teams?, error) in
                        guard let teamData = data, error == nil else{
                            return
                        }
                        self.homeTeamDetails.append(teamData.teams!)
                    }
                }
            }
            dispatchGroup.leave()

            for i in 0..<leagueEventsDetails.count{
                dispatchGroup.enter()
                
                if leagueEventsDetails[i].idAwayTeam != nil{
                    ApiServices.instance.getResponses(url: ApiURLs.teamDetails.rawValue, id: leagueEventsDetails[i].idAwayTeam ?? "") { (data: Teams?, error) in

                        guard let teamData = data, error == nil else{
                            return
                        }
                        self.awayTeamDetails.append(teamData.teams!)
                    }
                }else{
                    self.view?.stopAnimating()
                    self.view?.reloadData()
                }
            }
            dispatchGroup.leave()


//            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute:{
//                self.view?.stopAnimating()
//                self.view?.reloadTable()
//                })
            
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
    
    func getHomeTeamsDetails(completion : @escaping (([[Team]]) -> Void)){
        
        var homeTeams  = [[Team]]()
        
         for i in 0..<leagueEventsDetails.count{
  
             ApiServices.instance.getResponses(url: ApiURLs.teamDetails.rawValue, id: leagueEventsDetails[i].idAwayTeam ?? "") { (data: Teams?, error) in
                 guard let teamData = data, error == nil else{
                     return
                 }
                 homeTeams.append(teamData.teams!)
             }
         }
        completion(homeTeams)
    }
    
    func getAwayTeamsDetails(completion : @escaping (([[Team]]) -> Void)){
        var homeTeams  = [[Team]]()
        for i in 0..<leagueEventsDetails.count{
             ApiServices.instance.getResponses(url: ApiURLs.teamDetails.rawValue, id: leagueEventsDetails[i].idHomeTeam ?? "") { (data: Teams?, error) in
                 guard let teamData = data, error == nil else{
                     return
                 }
                 homeTeams.append(teamData.teams!)
             }
         }
        completion(homeTeams)
    }
    
    
    // coreData
    func saveLeagueToCoreData(leagueID: String, leagueName: String, leagueYoutubeLink: String, leagueImage: String){
        
        let dataArray = [leagueID, leagueName, leagueYoutubeLink, leagueImage]
        let KeysArray = ["leagueID", "leagueName", "leagueYoutubeLink", "leagueImage"]
        
        CoreDataBuilder.saveToCoreData(delegate: delegate!, entityName: "FavoriteLeague", dataArray: dataArray, KeysArray: KeysArray, removeDataInSameTime: &(favoriteLeague))
    }
    
    func deleteLeaguefromCoreData(leagueID: String){
        
        var index = 0
        
        fetchLeaguefromCoreData()
        
        for i in 0..<fetchedLeaguesArray.count{
            if fetchedLeaguesArray[i].value(forKey: "leagueID") as! String == leagueID{
                index = i
                break
            }
        }
        
        CoreDataBuilder.deletefromCoreData(delegate: delegate!, index: index, view: view!, dataDeletedArray: &fetchedLeaguesArray)
    }
    
    func fetchLeaguefromCoreData(){
        CoreDataBuilder.fetchFromCoreData(delegate: delegate!, view: view!, fetchedDataArray: &fetchedLeaguesArray, entityName: "FavoriteLeague")
    }
    
    
    
    func isFavoriteLeague(leagueID: String) -> Bool{
        
        fetchLeaguefromCoreData()
        
        var isFavorite = false
        
        for i in 0..<fetchedLeaguesArray.count{
            if fetchedLeaguesArray[i].value(forKey: "leagueID") as! String == leagueID{
                isFavorite = !isFavorite
                break
            }
        }
        
        
        return isFavorite
    }
    
}
