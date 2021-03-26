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
    
    
    func getAllSportJsonData<T: Decodable>(url: String, completion: @escaping(T?, Error?) ->Void){
        
        Alamofire.request(url).responseJSON { (response) in
        
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
        }
    }
    
    func getLeguesWithId<T: Decodable>(url: String, id: String ,completion: @escaping(T?, Error?) ->Void){
        let parameters: Parameters = ["id": Int(id) ?? 0]
        
//        let urlQuery = [URLQueryItem(name: "id", value: id)]
//        var urlComponents = URLComponents(string: url)
//        urlComponents?.queryItems = urlQuery

        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { (response) in
            guard let responseData = response.data else{
                return
            }

            do{
                let decoder = JSONDecoder()
                let data = try decoder.decode(T.self, from: responseData)

                completion(data, nil)
                print(url + id)

            }catch{
                completion(nil, error)
            }
        }
    }
}

