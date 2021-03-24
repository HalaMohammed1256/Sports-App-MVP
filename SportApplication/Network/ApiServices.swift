//
//  ApiServices.swift
//  SportApplication
//
//  Created by Hala on 24/03/2021.
//

import Foundation
import Alamofire

class ApiServices{
    
    // singletone
    static let instance = ApiServices()
    
    
    func getAllSportJsonData<T: Decodable>(url: String, completion: @escaping(T?, Error?) ->Void) {
        
        Alamofire.request(url).responseJSON { (response) in
            
            switch response.result{
            case .success( _):
                    
                    guard let responseData = response.data else{
                        print("error in fetch data")
                        return
                    }
                    
                    do{
                        
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(T.self, from: responseData)
                        
                        completion(data, nil)
                        
                    }catch let error{
                        
                        completion(nil, error)
                        
                    }
                    
                    
                case .failure(let error):
                    
                    completion(nil, error)
                    
            }
        }
    }
}

