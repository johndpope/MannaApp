//
//  SignInViewController.swift
//  TheManna
//
//  Created by Sean Zhang on 6/16/17.
//  Copyright © 2017 Sean Zhang. All rights reserved.
//

import Foundation
import UIKit
import AWSCore
import AWSCognito
import AWSCognitoIdentityProvider

class SignInviewController: UIViewController {
    
    var passwordAuthenticationCompletion: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>?
    var usernameText: String?
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var logInButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Login", for: UIControlState.normal)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(signInPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var SignUpButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Sign Up", for: UIControlState.normal)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        return button
    }()
    
    lazy var forgetPasswordButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Forget Password", for: UIControlState.normal)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        return button
    }()
    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "User Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        return textField
    }()
    
    let nameSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        return textField
    }()
    
    
    override func viewDidLoad() {
        //setup your code
        
        self.view.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        self.view.addSubview(inputsContainerView)
        self.view.addSubview(logInButton)
        self.view.addSubview(SignUpButton)
        self.view.addSubview(forgetPasswordButton)
        
        setupInputContainerView()
        setupLogInButton()
        setupSignUpButton()
        setupForgetPasswordButton()
        
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    func setupLogInButton() {
        //need x, y, width, height constraints
        logInButton.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        logInButton.topAnchor.constraint(
            equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        logInButton.widthAnchor.constraint(
            equalTo: inputsContainerView.widthAnchor).isActive = true
        logInButton.heightAnchor.constraint(
            equalToConstant: 50).isActive = true
        
    }
    
    func setupSignUpButton() {
        //need x, y, width, height constraints
        SignUpButton.bottomAnchor.constraint(
            equalTo: view.bottomAnchor).isActive = true
        SignUpButton.leftAnchor.constraint(
            equalTo: view.leftAnchor, constant: 0).isActive = true
        SignUpButton.widthAnchor.constraint(
            equalToConstant: 100).isActive = true
        SignUpButton.heightAnchor.constraint(
            equalToConstant: 50).isActive = true
        
        
    }
    
    func setupForgetPasswordButton() {
        //need x, y, width, height constraints
        forgetPasswordButton.bottomAnchor.constraint(
            equalTo: view.bottomAnchor).isActive = true
        forgetPasswordButton.rightAnchor.constraint(
            equalTo: view.rightAnchor, constant: 0).isActive = true
        forgetPasswordButton.widthAnchor.constraint(
            equalToConstant: 100).isActive = true
        forgetPasswordButton.heightAnchor.constraint(
            equalToConstant: 50).isActive = true
        
        
    }
    
    func setupInputContainerView() {
        //need x, y, width, height constraints
        inputsContainerView.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(
            equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(
            equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerView.heightAnchor.constraint(
            equalToConstant: 100).isActive = true
        
        // Add subviews
        inputsContainerView.addSubview(usernameTextField)
        inputsContainerView.addSubview(passwordTextField)
        inputsContainerView.addSubview(nameSeparatorView)
        
        
        //need x, y, width, height constraints
        usernameTextField.leftAnchor.constraint(
            equalTo: inputsContainerView.leftAnchor,
            constant: 12).isActive = true
        
        usernameTextField.topAnchor.constraint(
            equalTo: inputsContainerView.topAnchor).isActive = true
        
        usernameTextField.widthAnchor.constraint(
            equalTo: inputsContainerView.widthAnchor).isActive = true
        
        usernameTextField.heightAnchor.constraint(
            equalTo: inputsContainerView.heightAnchor,
            multiplier: 1/2).isActive = true
        
      
        
        //need x, y, width, height constraints
        nameSeparatorView.leftAnchor.constraint(
            equalTo: inputsContainerView.leftAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(
            equalTo: usernameTextField.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(
            equalTo: usernameTextField.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(
            equalToConstant: 1).isActive = true
        

        
        //need x, y, width, height constraints
        passwordTextField.leftAnchor.constraint(
            equalTo: inputsContainerView.leftAnchor,
            constant: 12).isActive = true
        
        passwordTextField.topAnchor.constraint(
            equalTo: usernameTextField.bottomAnchor).isActive = true
        
        passwordTextField.widthAnchor.constraint(
            equalTo: inputsContainerView.widthAnchor).isActive = true
        
        passwordTextField.heightAnchor.constraint(
            equalTo: inputsContainerView.heightAnchor,
            multiplier: 1/2).isActive = true
        
    }
    
    func signInPressed() {
        print(1234)
        print(usernameTextField.text)
        print(passwordTextField.text)
        if (self.usernameTextField.text != nil && self.passwordTextField.text != nil) {
            print("Usrenname and password not nils")
            let authDetails = AWSCognitoIdentityPasswordAuthenticationDetails(username: self.usernameTextField.text!, password: self.passwordTextField.text! )
            self.passwordAuthenticationCompletion?.set(result: authDetails)
        } else {
            print("There is no either password nor username")
            let alertController = UIAlertController(title: "Missing information",
                                                    message: "Please enter a valid user name and password",
                                                    preferredStyle: .alert)
            let retryAction = UIAlertAction(title: "Retry", style: .default, handler: nil)
            alertController.addAction(retryAction)
        }
    }

}

extension SignInviewController: AWSCognitoIdentityPasswordAuthentication {
    

    
    public func getDetails(_ authenticationInput: AWSCognitoIdentityPasswordAuthenticationInput, passwordAuthenticationCompletionSource: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>) {
        print("GetDetails Called")
        self.passwordAuthenticationCompletion = passwordAuthenticationCompletionSource
        DispatchQueue.main.async {
            if (self.usernameTextField.text == nil) {
                self.usernameTextField.text = authenticationInput.lastKnownUsername
            }
        }
    }
    
    public func didCompleteStepWithError(_ error: Error?) {
        DispatchQueue.main.async {
            print("Some Errors when completing the step")
            if let error = error as NSError? {
                let alertController = UIAlertController(title: error.userInfo["__type"] as? String,
                                                        message: error.userInfo["message"] as? String,
                                                        preferredStyle: .alert)
                let retryAction = UIAlertAction(title: "Retry", style: .default, handler: nil)
                alertController.addAction(retryAction)
                
                self.present(alertController, animated: true, completion:  nil)
            } else {
                print("Sign In Success.....")
                self.usernameTextField.text = nil
                self.passwordTextField.text = nil
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
