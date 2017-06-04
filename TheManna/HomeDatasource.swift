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
        
        let brianUser = User(name: "Sean Zhang", username: "@sean7218", bioText: "Sean is Mechanical Engineer who works in the energy industry and he loves running and coding with focus on iOS apps", profileImage: #imageLiteral(resourceName: "selfie"))
        
        let rayUser = User(name: "Ray Wenderlich", username: "@rwenderlich", bioText: "Ray Wenderlich is an iPhone developer and tweets on topics related to iPhone, software, and gaming. Check out our conference.", profileImage: #imageLiteral(resourceName: "rwenderlich"))
        
        let kindleCourseUser = User(name: "Kindle Course", username: "@kindleCourse", bioText: "This recently released course on http:\\videos.letsbuildthatapp.com/basic-training provides some excellent guidance on how to use UITableView and UICollectionView. This course also teaches some basics on the Swift language, for example IF statements, For loops. This will be an excellent purchase for you", profileImage: #imageLiteral(resourceName: "brianVoong"))
        
        return [brianUser, rayUser, kindleCourseUser]
    }()
    
 
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [UserFooter.self]
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [UserHeader.self]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [UserCell.self]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return users.count
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return users[indexPath.row]
    }
}
