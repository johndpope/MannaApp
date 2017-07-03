//
//  ConfirmForgotPasswordViewController.swift
//  TheManna
//
//  Created by Sean Zhang on 7/3/17.
//  Copyright © 2017 Sean Zhang. All rights reserved.
//

import Foundation
import UIKit
import AWSCognitoIdentityProvider

class ConfirmForgotPasswordViewController: UIViewController {
    

    var user: AWSCognitoIdentityUser?
    
    lazy var confirmationCodeTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "confirmation code"
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.backgroundColor = .white
        return textField
    }()
    
    lazy var proposedPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.placeholder = "New Password"
        textField.backgroundColor = .white
        return textField
    }()

    
    lazy var updatePasswordButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Submit", for: .normal)
        button.addTarget(self, action: #selector(updatePassword), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupViews()
    }
    
    
    func setupViews() {
        
        self.view.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        self.view.addSubview(confirmationCodeTextField)
        self.view.addSubview(proposedPasswordTextField)
        self.view.addSubview(updatePasswordButton)

        
        // Needs x, y, width, and height constraints
        confirmationCodeTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        confirmationCodeTextField.topAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100).isActive = true
        confirmationCodeTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -150).isActive = true
        confirmationCodeTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // Needs x, y, width, and height constraints
        proposedPasswordTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        proposedPasswordTextField.topAnchor.constraint(equalTo: confirmationCodeTextField.bottomAnchor, constant: 10).isActive = true
        proposedPasswordTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -150).isActive = true
        proposedPasswordTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // Needs x, y, width, and height constraints
        updatePasswordButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        updatePasswordButton.topAnchor.constraint(equalTo: proposedPasswordTextField.bottomAnchor, constant: 10).isActive = true
        updatePasswordButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -150).isActive = true
        updatePasswordButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    // MARK: IBActions
    
    // handle updating password
    func updatePassword(){
        print(1)
    }

    
    
}
