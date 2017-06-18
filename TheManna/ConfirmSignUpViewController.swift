//
//  ConfirmSignUpViewController.swift
//  TheManna
//
//  Created by Sean Zhang on 6/18/17.
//  Copyright © 2017 Sean Zhang. All rights reserved.
//

import Foundation
import AWSCognitoIdentityProvider

class ConfirmSignUpViewController: UIViewController {
    
    let confirmCodeTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .red
        tf.placeholder = "Confirmation Code"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    override func viewDidLoad() {
        
        view.addSubview(confirmCodeTextField)
        //setup views
        setUpViews()
    }
    
    func setUpViews() {
        print("setting up views")
        
        confirmCodeTextField.topAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        confirmCodeTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        confirmCodeTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -100).isActive = true
        confirmCodeTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
    }
}
