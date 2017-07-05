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
    
    var pool: AWSCognitoIdentityUserPool?
    var sentTo: String?
    
    lazy var confirmSignUpViewController: ConfirmSignUpViewController? = {
        let viewController = ConfirmSignUpViewController()
        return viewController
    }()
    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 11)
        
        textField.placeholder = "user name"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.autocapitalizationType = .none
        return textField
        
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 11)
        textField.placeholder = "password"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        return textField
        
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 11)
        textField.placeholder = "email"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        return textField
        
    }()
    
    let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 11)
        textField.placeholder = "phone number"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        return textField
        
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
        button.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pool = AWSCognitoIdentityUserPool.init(forKey: "UserPool")
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationController()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func setupNavigationController() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(r: 80, g: 101, b: 161)
    }
    
    func setupViews() {
        
        //setup view here
        self.view.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        self.view.addSubview(usernameTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(emailTextField)
        self.view.addSubview(phoneTextField)
        self.view.addSubview(signUpButton)
        
        //setting up views here
        usernameTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200).isActive = true
        usernameTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        usernameTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -100).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 10).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -100).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        emailTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -100).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        phoneTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10).isActive = true
        phoneTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        phoneTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -100).isActive = true
        phoneTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        signUpButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 10).isActive = true
        signUpButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        signUpButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -100).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func signUp() {
        guard let userNameValue = self.usernameTextField.text, !userNameValue.isEmpty,
            let passwordValue = self.passwordTextField.text, !passwordValue.isEmpty else {
                let alertController = UIAlertController(title: "Missing Required Fields",
                                                        message: "Username / Password are required for registration.",
                                                        preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion:  nil)
                return
        }
        
        var attributes = [AWSCognitoIdentityUserAttributeType]()
        
        if let phoneValue = self.phoneTextField.text, !phoneValue.isEmpty {
            let phone = AWSCognitoIdentityUserAttributeType()
            phone?.name = "phone_number"
            phone?.value = phoneValue
            attributes.append(phone!)
        }
        
        if let emailValue = self.emailTextField.text, !emailValue.isEmpty {
            let email = AWSCognitoIdentityUserAttributeType()
            email?.name = "email"
            email?.value = emailValue
            attributes.append(email!)
        }
        
        self.pool?.signUp(userNameValue, password: passwordValue, userAttributes: attributes, validationData: nil).continueWith(block: { [weak self](task: AWSTask<AWSCognitoIdentityUserPoolSignUpResponse>) -> Any? in
            
            guard let strongSelf = self else { return nil }
            DispatchQueue.main.async {
                if let err = task.error {
                    let alertController = UIAlertController(title: "Error", message: err as? String, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
                    alertController.addAction(alertAction)
                    strongSelf.present(alertController, animated: true, completion: nil)
                } else if let result = task.result {
                    if result.user.confirmedStatus != AWSCognitoIdentityUserStatus.confirmed {
                        strongSelf.confirmSignUpViewController?.sendTo = result.codeDeliveryDetails?.destination
                        strongSelf.navigationController?.pushViewController(strongSelf.confirmSignUpViewController!, animated: true)
                    } else {
                        strongSelf.navigationController?.popToRootViewController(animated: true)
                    }
                }
            }
    
            return nil
        })
        
    }
}
