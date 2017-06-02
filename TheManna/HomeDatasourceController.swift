//
//  HomeDatasourceController.swift
//  TheManna
//
//  Created by Sean Zhang on 6/1/17.
//  Copyright © 2017 Sean Zhang. All rights reserved.
//

import LBTAComponents

class HomeDataSource: Datasource {
    
    let words = ["user1", "user2", "user3"]
    
    
    override func numberOfItems(_ section: Int) -> Int {
        return words.count
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return words[indexPath.row]
    }
}
class HomeDatasourceController: DatasourceController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let homeDatasource = HomeDataSource()
        self.datasource = homeDatasource
        collectionView?.backgroundColor = UIColor.darkGray
    }
}
