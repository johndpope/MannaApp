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
    
    var sendTo: String?
    var user: AWSCognitoIdentityUser?
    
    lazy var sentToLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .red
        return label
        
    }()
    
    lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .yellow
        return textField
    }()
    
    lazy var codeTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Entering the Code"
        textField.backgroundColor = .brown
        return textField
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.text = self.user?.username
        sentToLabel.text = "Sending to \(self.sendTo ?? "")"
        setUpViews()
    }
    
    func setUpViews() {
        
        self.view.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        self.view.addSubview(sentToLabel)
        self.view.addSubview(usernameTextField)
        self.view.addSubview(codeTextField)
        //setup views
        
        
    }
}
