//
//  Service.swift
//  TheManna
//
//  Created by Sean Zhang on 6/29/17.
//  Copyright © 2017 Sean Zhang. All rights reserved.
//

import Foundation
import TRON
import SwiftyJSON

struct Service {
    
    static let sharedInstance = Service()
    
    let tron = TRON(baseURL: "https://api.letsbuildthatapp.com")
    
    func fetchHomeFeed(completion: @escaping (HomeDataSource) -> ()) {
        
        //start our json fetch
        let request: APIRequest<HomeDataSource, JSONError> = tron.request("twitter/home")
        
        request.perform(
            withSuccess: { (home: HomeDataSource) in
                print("Successfully Fetched \n")
                completion(home)
        },
            failure: { (err: APIError<JSONError>) in
                print("Failed to fetched json \n \(err)")
        }
        )
    }
    
    class JSONError: JSONDecodable{
        required init(json: JSON) throws {
            print("json Error")
        }
    }
}
