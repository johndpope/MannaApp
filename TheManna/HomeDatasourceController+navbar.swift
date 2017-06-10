//
//  HomeDatasourceController+navbar.swift
//  TheManna
//
//  Created by Sean Zhang on 6/4/17.
//  Copyright © 2017 Sean Zhang. All rights reserved.
//

import UIKit

extension HomeDatasourceController {
    
    
    func setupNavigationBarItems () {
        setupRemainingNavItems()
        setupRightNavItems()
        setupLeftNavItems()
    }
    
    private func setupRemainingNavItems() {
        navigationItem.titleView = {
            let titleImageView: UIImageView = UIImageView(image: nil)
            titleImageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
            titleImageView.contentMode = .scaleAspectFit
            return titleImageView
        }()
        
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        
        let navBarSeparatorView = UIView()
        navBarSeparatorView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        view.addSubview(navBarSeparatorView)
        navBarSeparatorView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0.5)
        
    }
    
    private func setupLeftNavItems() {
        navigationItem.leftBarButtonItem = {
            let followButton: UIButton = UIButton(type: UIButtonType.system)
            followButton.setImage(#imageLiteral(resourceName: "follow").withRenderingMode(.alwaysOriginal), for: .normal)
            followButton.frame = CGRect(x: 0, y: 10, width: 24, height: 24)
            followButton.contentMode = .scaleAspectFit
            
            let barButtonItem = UIBarButtonItem(customView: followButton)
            
            return barButtonItem
        }()
    }
    
    private func setupRightNavItems(){
        
        navigationItem.rightBarButtonItems = {
            
            let searchButton: UIButton = UIButton(type: .system)
            searchButton.setImage(#imageLiteral(resourceName: "search").withRenderingMode(.alwaysOriginal), for: .normal)
            searchButton.frame = CGRect(x: 0, y: 0, width: 27, height: 27)
            searchButton.contentMode = .scaleAspectFit
            let barItem1 = UIBarButtonItem(customView: searchButton)
            
            
            let composeButton: UIButton = UIButton(type: .system)
            composeButton.setImage(#imageLiteral(resourceName: "compose").withRenderingMode(.alwaysOriginal), for: .normal)
            composeButton.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
            composeButton.contentMode = .scaleAspectFit
            let barItem2 = UIBarButtonItem(customView: composeButton)
            
            return [barItem1,barItem2]
        }()
    }
}
