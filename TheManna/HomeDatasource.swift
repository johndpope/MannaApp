//
//  HomeDatasource.swift
//  TheManna
//
//  Created by Sean Zhang on 6/1/17.
//  Copyright © 2017 Sean Zhang. All rights reserved.
//

import Foundation
import LBTAComponents

class HomeDataSource: Datasource {
    
    let users: [User] = {
        
        let brianUser = User(name: "Sean Zhang", username: "@sean7218", bioText: "For the wages of sin is death and the free gift of God is eternal life in Christ Jesus.", profileImage: #imageLiteral(resourceName: "selfie"))
        
        let rayUser = User(name: "Ray Wenderlich", username: "@rwenderlich", bioText: "For All have sinned and fall short of the glory of God.", profileImage: #imageLiteral(resourceName: "rwenderlich"))
        
        let kindleCourseUser = User(name: "Brian Vooon", username: "@BrianVoong", bioText: "21 But now the righteousness of God has been manifested apart from the law, although the Law and the Prophets bear witness to it— 22 the righteousness of God through faith in Jesus Christ for all who believe. For there is no distinction: 23 for all have sinned and fall short of the glory of God, 24 and are justified by his grace as a gift, through the redemption that is in Christ Jesus, 25 whom God put forward as a propitiation by his blood, to be received by faith. This was to show God's righteousness, because in his divine forbearance he had passed over former sins. 26 It was to show his righteousness at the present time, so that he might be just and the justifier of the one who has faith in Jesus.", profileImage: #imageLiteral(resourceName: "brianVoong"))
        
        return [brianUser, rayUser, kindleCourseUser]
    }()
    
    let tweets = ["Tweet1", "Tweet2"]
    
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
        return users[indexPath.row]
    }
}
