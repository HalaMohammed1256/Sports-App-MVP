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
    

    func getResponses<T: Decodable>(url: String, id: String = "" ,completion: @escaping(T?, Error?) ->Void){
        let parameters: Parameters = ["id": Int(id) ?? ""]

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

