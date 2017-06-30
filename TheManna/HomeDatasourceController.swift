//
//  HomeDatasourceController.swift
//  TheManna
//
//  Created by Sean Zhang on 6/1/17.
//  Copyright © 2017 Sean Zhang. All rights reserved.
//

import LBTAComponents
import TRON
import SwiftyJSON

class HomeDatasourceController: DatasourceController {
    
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor(r: 232, g: 236, b: 241)
        
        setupNavigationBarItems()

        
        Service.sharedInstance.fetchHomeFeed { (homeDataSource: HomeDataSource) in
            self.datasource = homeDataSource
        }
    }
    


    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let user = self.datasource?.item(indexPath) as? User {
            
            let approximateWidthOfBioTextView = view.frame.width - 12 - 50 - 12
            
            let size = CGSize(width: approximateWidthOfBioTextView, height: 1000)
            
            let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 15)]
            
            let estimatedFrame = NSString(string: user.bioText).boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes, context: nil)
            
            return CGSize(width: view.frame.width, height: estimatedFrame.height + 75)
        }
        
        return CGSize(width: view.frame.width, height: 450)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: view.frame.width, height: 50)
        } else {
            return CGSize.zero
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: view.frame.width, height: 64)
        } else {
            return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


















