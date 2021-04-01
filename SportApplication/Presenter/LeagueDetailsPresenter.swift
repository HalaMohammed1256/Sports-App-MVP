//
//  LeagueDetailsPresenter.swift
//  SportApplication
//
//  Created by Hala on 29/03/2021.
//

import Foundation
import CoreData

protocol LeagueDetailsView: class {
    func reloadTable()
    func startAnimating()
    func stopAnimating()
}

protocol LeagueDetailsViewPresenter {
    init(view: LeagueDetailsView, delegate: AppDelegate)
    func getEventsData(apiURL: String, id: String)
    func getTeamsData(apiURL: String, id: String)
    func saveLeagueToCoreData(leagueID: String, leagueName: String, leagueYoutubeLink: String, leagueImage: String)
    func deleteLeaguefromCoreData()
}

class LeagueDetailsPresenter : LeagueDetailsViewPresenter{
    let delegate : AppDelegate?
    var favoriteLeague : NSManagedObject?
    let dispatchGroup = DispatchGroup()
    weak var view : LeagueDetailsView?
    
    var homeTeamDetails = [[Team]]()
    var leagueTeamsDetails = [Team]()
    var awayTeamDetails = [[Team]]()
    
    required init(view: LeagueDetailsView, delegate: AppDelegate) {
        self.view = view
        self.delegate = delegate
    }
    
    var leagueEventsDetails = [Event](){
        didSet{
            
            for i in 0..<leagueEventsDetails.count{
                dispatchGroup.enter()
                ApiServices.instance.getResponses(url: ApiURLs.teamDetails.rawValue, id: leagueEventsDetails[i].idHomeTeam ?? "") { (data: Teams?, error) in
                    guard let teamData = data, error == nil else{
                        return
                    }
                    self.homeTeamDetails.append(teamData.teams!)
                }
            }
            dispatchGroup.leave()

            for i in 0..<leagueEventsDetails.count{
                dispatchGroup.enter()
                ApiServices.instance.getResponses(url: ApiURLs.teamDetails.rawValue, id: leagueEventsDetails[i].idAwayTeam ?? "") { (data: Teams?, error) in

                    guard let teamData = data, error == nil else{
                        return
                    }
                    self.awayTeamDetails.append(teamData.teams!)
                }
            }
            dispatchGroup.leave()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute:{                self.view?.stopAnimating()
                self.view?.reloadTable()
                })
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
        let context = delegate!.persistentContainer.viewContext
        let favoriteEntity = NSEntityDescription.entity(forEntityName: "FavoriteLeague", in: context)
        let favoriteLeagueRow = NSManagedObject(entity: favoriteEntity!, insertInto: context)
        favoriteLeagueRow.setValue(leagueID, forKey: "leagueID")
        favoriteLeagueRow.setValue(leagueName, forKey: "leagueName")
        favoriteLeagueRow.setValue(leagueYoutubeLink, forKey: "leagueYoutubeLink")
        favoriteLeagueRow.setValue(leagueImage, forKey: "leagueImage")
        favoriteLeague = favoriteLeagueRow
        do{
            try context.save()
            print("Data added successfully")
        }catch let error as NSError{
            print(error)
        }
        delegate!.saveContext()
    }
    func deleteLeaguefromCoreData(){
        let context = delegate!.persistentContainer.viewContext
        context.delete(favoriteLeague!)
        do{
            try context.save()
            print("Data deleted successfully")
        }catch let error as NSError{
            print(error)
        }
        delegate!.saveContext()
    }
}
