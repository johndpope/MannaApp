//
//  DDBLoadingView.swift
//  TheManna
//
//  Created by Sean Zhang on 6/24/17.
//  Copyright © 2017 Sean Zhang. All rights reserved.
//

import Foundation
import UIKit

class DDBLoadingViewController: UIViewController {
    
    let loadingStatusLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Creating a test table. This may take a few minutes, please wait...."
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(loadingStatusLabel)
        setupViews()
    }
    
    func setupViews(){
        loadingStatusLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        loadingStatusLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loadingStatusLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -20).isActive = true
        loadingStatusLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
}
