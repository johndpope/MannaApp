//
//  ForgotPasswordViewController.swift
//  TheManna
//
//  Created by Sean Zhang on 7/3/17.
//  Copyright © 2017 Sean Zhang. All rights reserved.
//

import Foundation
import UIKit
import AWSCognitoIdentityProvider

class ForgotPasswordViewController: UIViewController {
    
    var pool: AWSCognitoIdentityUserPool?
    var user: AWSCognitoIdentityUser?
    
    lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.autocapitalizationType = .none
        textField.placeholder = " user name"
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        return textField
    }()
    
    lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Submit", for: .normal)
        button.addTarget(self, action: #selector(forgotPassword), for: .touchUpInside)
        return button
    }()
    
    lazy var cancelForgotPasswordButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", for: .normal)
        button.contentHorizontalAlignment = .right
        button.contentEdgeInsets = UIEdgeInsetsMake(10, 0, 10, 10)
        button.addTarget(self, action: #selector(cancelForgotPassword), for: .touchUpInside)
        return button
    }()
    
    lazy var contactUsButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Contact Us", for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 0)
        button.addTarget(self, action: #selector(contactUsButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pool = AWSCognitoIdentityUserPool(forKey: "UserPool")
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func setupViews() {
        
        self.view.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        self.view.addSubview(usernameTextField)
        self.view.addSubview(forgotPasswordButton)
        self.view.addSubview(cancelForgotPasswordButton)
        self.view.addSubview(contactUsButton)
        
        //Needs x, y, width, and height constrains
        usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        usernameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -70).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        //Needs x, y, width, and height constrains
        forgotPasswordButton.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 10).isActive = true
        forgotPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        forgotPasswordButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -150).isActive = true
        forgotPasswordButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //Needs x, y, width, and height constrains
        let size1 = NSString(string: "Cancel").size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 11)])
        cancelForgotPasswordButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        cancelForgotPasswordButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        cancelForgotPasswordButton.widthAnchor.constraint(equalToConstant: size1.width + 20).isActive = true
        cancelForgotPasswordButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        //Needs x, y, width, and height constrains
        let size2 = NSString(string: "Contact Us").size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 11)])
        contactUsButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        contactUsButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        contactUsButton.widthAnchor.constraint(equalToConstant: size2.width + 20).isActive = true
        contactUsButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    // MARK :- IBActions

    // handle forgot password
    func forgotPassword() {
        
        guard let username = usernameTextField.text, !(usernameTextField.text?.isEmpty)! else {
        
            let alertController = UIAlertController(title: "Missing UserName",
                                                    message: "Please enter a valid user name.",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion:  nil)
            
            return
        }
        
        self.user = self.pool?.getUser(username)
        self.user?.forgotPassword().continueWith(block: { (task: AWSTask<AWSCognitoIdentityUserForgotPasswordResponse>) -> Any? in
            DispatchQueue.main.async(execute: {
                if let err = task.error  {
                    let alertController = UIAlertController(title: err.localizedDescription,
                                                            message: err as? String,
                                                            preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alertController.addAction(okAction)
                } else {
                    //go to ConfirmForgotPasswordViewController
                    let forgotPasswordViewController = ConfirmForgotPasswordViewController()
                    forgotPasswordViewController.user = self.user
                    self.present(forgotPasswordViewController, animated: true, completion: nil)
                }
            })
        })
    }
    
    func cancelForgotPassword() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func contactUsButtonPressed() {
        let alertController = UIAlertController(title: "Contact Us",
                                                message: "Please Call +1 (800) xxx-xxx",
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
