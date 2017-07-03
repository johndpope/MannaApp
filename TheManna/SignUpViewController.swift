//
//  SignUpViewController.swift
//  TheManna
//
//  Created by Sean Zhang on 6/18/17.
//  Copyright © 2017 Sean Zhang. All rights reserved.
//

import Foundation
import AWSCognitoIdentityProvider

class SignUpViewController: UIViewController {
    
    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "user name"
        textField.autocapitalizationType = .none
        return textField
        
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "password"
        return textField
        
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "email"
        return textField
        
    }()
    
    let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "phone number"
        return textField
        
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
        return button
    }()
    
    override func viewDidLoad() {
        //setup view here
        self.view.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        self.view.addSubview(usernameTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(emailTextField)
        self.view.addSubview(phoneTextField)
        self.view.addSubview(signUpButton)
        
        setupViews()
    }
    
    func setupViews() {
        
        //setting up views here
        usernameTextField.topAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        usernameTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        usernameTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -100).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -100).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        emailTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -100).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        phoneTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        phoneTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        phoneTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -100).isActive = true
        phoneTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        signUpButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 10).isActive = true
        signUpButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        signUpButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -100).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
