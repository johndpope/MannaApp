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
    
    let words = ["user1", "user2", "user3"]
    
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
        return words.count
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return words[indexPath.row]
    }
}
