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
        
//        let homeDatasource = HomeDataSource()
//        self.datasource = homeDatasource
        
        fetchHomeFeed()

    }
    
    let tron = TRON(baseURL: "https://api.letsbuildthatapp.com")
    

    class Home: JSONDecodable {
        
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
    }
    
    class JSONError: JSONDecodable{
        required init(json: JSON) throws {
            print("json Error")
        }
    }
    fileprivate func fetchHomeFeed() {
        //start our json fetch
        let request: APIRequest<HomeDataSource, JSONError> = tron.request("twitter/home")
        
        request.perform(
            withSuccess: { (home: HomeDataSource) in
                print("Successfully Fetched \n")
                self.datasource = home
            },
            failure: { (err: APIError<HomeDatasourceController.JSONError>) in
                print("Failed to fetched json \n \(err)")
            }
        )
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


















