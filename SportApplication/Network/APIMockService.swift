//
//  APIMockService.swift
//  SportApplication
//
//  Created by AhmedFareed on 29/03/2021.
//

import Foundation
class APIMockService : ApiServices{
    
    
   fileprivate func getStubResponses<T>(url: String, id: String = "", completion: @escaping (T?, Error?) -> Void) where T : Decodable {
        
        if let responseStub = Bundle.main.url(forResource: "sportsStub", withExtension: "json"){
        
        do{
            let decoder = JSONDecoder()
            
            let data = try Data(contentsOf: responseStub, options: .mappedIfSafe)
           // let json = try JSONSerialization.data(withJSONObject: data, options: [])
            let json = try decoder.decode(T.self, from: data)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                completion(json, nil)
            }
            
        }catch{
            debugPrint(error.localizedDescription)
            completion(nil, error)
        }
            
        }
    }
    
    override func getResponses<T>(url: String, id: String = "", completion: @escaping (T?, Error?) -> Void) where T : Decodable {
        getStubResponses(url: url, id: id, completion: completion)
    }
}
