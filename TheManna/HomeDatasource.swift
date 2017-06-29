//
//  HomeDatasource.swift
//  TheManna
//
//  Created by Sean Zhang on 6/1/17.
//  Copyright © 2017 Sean Zhang. All rights reserved.
//

import Foundation
import LBTAComponents
import SwiftyJSON
import TRON

class HomeDataSource: Datasource, JSONDecodable {
    
    
    let users: [User]
    
    required init(json: JSON) throws {
        var users = [User]()
        
        let array = json["users"].array
        for userJson in array! {
            let name = userJson["name"].stringValue
            let username = userJson["username"].stringValue
            let bio = userJson["bio"].stringValue
            let user = User(name: name, username: username, bioText: bio, profileImage: UIImage())
            users.append(user)
        }
        self.users = users
    }
    
    let tweets: [Tweet] = {
        let brianUser = User(name: "Sean Zhang", username: "@sean7218", bioText: "For the wages of sin is death and the free gift of God is eternal life in Christ Jesus.", profileImage: #imageLiteral(resourceName: "selfie"))
        
        let tweet = Tweet(user: brianUser, message: "Welcome to episode 9 of the Twitter Series, really hope you guys are enjoying series so far. I really really need a long ext block to ender out so w're going to stop here.")
        
        let tweet2 = Tweet(user: brianUser, message: "This is the second tweet message for our sample project. Very very exciting message......")
        return [tweet,tweet2]
    }()
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [UserFooter.self]
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [UserHeader.self]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [UserCell.self, TweetCell.self]
    }
    
    override func numberOfSections() -> Int {
        return 2
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        if section == 0 {
            return users.count
        } else {
            return tweets.count
        }
        
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        if indexPath.section == 1 {
            return tweets[indexPath.row]
        }
        return users[indexPath.row]
    }
}
