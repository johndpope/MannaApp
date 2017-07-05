//
//  SignInViewController.swift
//  TheManna
//
//  Created by Sean Zhang on 6/18/17.
//  Copyright © 2017 Sean Zhang. All rights reserved.
//

import Foundation
import AWSCore
import AWSCognitoIdentityProvider

class SignInViewController: UIViewController {
    
    var passwordAuthenticationCompletion: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>?
    var usernameText: String?
    
    lazy var forgotPasswordViewController: ForgotPasswordViewController? = {
        return ForgotPasswordViewController()
    }()
    
    lazy var signUpViewController: SignUpViewController? = {
        return SignUpViewController()
    }()
    
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
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
        button.addTarget(self, action: #selector(segueToSignUpViewController), for: .touchUpInside)
        return button
    }()
    
    lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Forget Password", for: UIControlState.normal)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
        button.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
        button.addTarget(self, action: #selector(segueToForgotPasswordViewController), for: .touchUpInside)
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
        self.view.addSubview(forgotPasswordButton)
        
        setupInputContainerView()
        setupLogInButton()
        setupSignUpButton()
        setupForgetPasswordButton()
        
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationController()
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    func setupNavigationController() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = UIColor(r: 80, g: 101, b: 161)
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
        
        let size = NSString(string: "Sign Up").size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 11)])
        SignUpButton.bottomAnchor.constraint(
            equalTo: view.bottomAnchor).isActive = true
        SignUpButton.leftAnchor.constraint(
            equalTo: view.leftAnchor, constant: 0).isActive = true
        SignUpButton.widthAnchor.constraint(
            equalToConstant: size.width + 25).isActive = true
        SignUpButton.heightAnchor.constraint(
            equalToConstant: size.height + 20).isActive = true
        
        
    }
    
    func setupForgetPasswordButton() {
        //need x, y, width, height constraints
        let size = NSString(string: " Forget Password ").size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 11)])
        forgotPasswordButton.bottomAnchor.constraint(
            equalTo: view.bottomAnchor).isActive = true
        forgotPasswordButton.rightAnchor.constraint(
            equalTo: view.rightAnchor, constant: 0).isActive = true
        forgotPasswordButton.widthAnchor.constraint(
            equalToConstant: size.width + 20).isActive = true
        forgotPasswordButton.heightAnchor.constraint(
            equalToConstant: size.height + 20).isActive = true
        
        
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
        print("SignInPressed")
        if (self.usernameTextField.text != nil && self.passwordTextField.text != nil) {
            print("Usrenname and password all good")
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

    func segueToForgotPasswordViewController(){
        print("going to forgotPasswordViewController now")
        self.navigationController?.pushViewController(self.forgotPasswordViewController!, animated: true)
        
    }
    
    func segueToSignUpViewController(){
        print("going to signUpViewController now")
        self.navigationController?.pushViewController(self.signUpViewController!, animated: true)
        
    }
}


extension SignInViewController: AWSCognitoIdentityPasswordAuthentication {
    
    
    
    func getDetails(_ authenticationInput: AWSCognitoIdentityPasswordAuthenticationInput, passwordAuthenticationCompletionSource: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>) {
        print(2.2)
        print("GetDetails function Called")
            self.passwordAuthenticationCompletion = passwordAuthenticationCompletionSource
            DispatchQueue.main.async {
                print(2.3)
                if (self.usernameText == nil) {
                    self.usernameText = authenticationInput.lastKnownUsername
                }
            }
    }
    
    
    func didCompleteStepWithError(_ error: Error?) {
        print(3.1)
        DispatchQueue.main.async {
            if let error = error as NSError? {
                print("DidCompletestepWithError --- Error Found")
                let alertController = UIAlertController(title: error.userInfo["__type"] as? String,
                                                        message: error.userInfo["message"] as? String,
                                                        preferredStyle: .alert)
                let retryAction = UIAlertAction(title: "Retry", style: .default, handler: nil)
                alertController.addAction(retryAction)
                
                self.present(alertController, animated: true, completion:  nil)
            } else {
                print("DidCompleteStep - WithoutError")
                self.usernameTextField.text = nil
                
                
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
