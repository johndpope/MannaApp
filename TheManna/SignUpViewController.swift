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
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "user name"
        return tf
        
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "password"
        return tf
        
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "email"
        return tf
        
    }()
    
    let phoneTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "phone number"
        return tf
        
    }()
    
    override func viewDidLoad() {
        //setup view here
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(emailTextField)
        view.addSubview(phoneTextField)
        
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
    }
}
