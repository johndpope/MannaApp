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
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Username"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()
    
    lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: textField.frame.height))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = false
        textField.autocapitalizationType = .none
        textField.backgroundColor = .white
        textField.font = UIFont.systemFont(ofSize: 12)
        textField.textColor = .black
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()
    
    lazy var confirmationCodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "confirmation code"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()
    
    lazy var confirmationCodeTextField: UITextField = {
        let textField = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: textField.frame.height))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.autocapitalizationType = .none
        textField.font = UIFont.systemFont(ofSize: 12)
        textField.textColor = .black
        textField.placeholder = "confirmation code is right here and we need to do some"
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    lazy var confirmButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Confirm", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(confirmSingUp), for: .touchUpInside)
        return button
    }()
    
    lazy var resendButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Resend Confirmation Code", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(resendCode), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.text = self.user?.username
        sentToLabel.text = "Sending to \(self.sendTo ?? "")"
        setUpViews()
    }
    
    func setUpViews() {
        
        //setup views
        self.view.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        
        self.view.addSubview(sentToLabel)
        self.view.addSubview(usernameLabel)
        self.view.addSubview(usernameTextField)
        self.view.addSubview(confirmationCodeLabel)
        self.view.addSubview(confirmationCodeTextField)
        self.view.addSubview(confirmButton)
        self.view.addSubview(resendButton)
        
        // Need x, y, width, and height constraints
        sentToLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        sentToLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        sentToLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50).isActive = true
        sentToLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // Need x, y, width, and height constraints
        usernameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        usernameLabel.topAnchor.constraint(equalTo: sentToLabel.bottomAnchor, constant: 5).isActive = true
        usernameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // Need x, y, width, and height constraints
        usernameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        usernameTextField.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 5).isActive = true
        usernameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // Need x, y, width, and height constraints
        confirmationCodeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        confirmationCodeLabel.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 5).isActive = true
        confirmationCodeLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50).isActive = true
        confirmationCodeLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // Need x, y, width, and height constraints
        confirmationCodeTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        confirmationCodeTextField.topAnchor.constraint(equalTo: confirmationCodeLabel.bottomAnchor, constant: 5).isActive = true
        confirmationCodeTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50).isActive = true
        confirmationCodeTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // Need x, y, width, and height constraints
        confirmButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        confirmButton.topAnchor.constraint(equalTo: confirmationCodeTextField.bottomAnchor, constant: 5).isActive = true
        confirmButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50).isActive = true
        confirmButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // Need x, y, width, and height constraints
        let resendButtonSize = NSString(string: (resendButton.titleLabel?.text)!)
            .size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12)])
        resendButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        resendButton.topAnchor.constraint(equalTo: confirmButton.bottomAnchor, constant: 10).isActive = true
        resendButton.widthAnchor.constraint(equalToConstant: resendButtonSize.width + 10).isActive = true
        resendButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    // Handle confirm signup
    func confirmSingUp() {
        print("confirmSignUp")
        guard let confirmCodeValue = self.confirmationCodeTextField.text, !(confirmationCodeTextField.text?.isEmpty)! else {
            let alertController = UIAlertController(title: "Error", message: "Confirmation Code is Empty", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        self.user?.confirmSignUp(confirmCodeValue).continueWith(block: { [weak self] (task: AWSTask) -> Any? in
            guard let strongSelf = self else { return nil }
            DispatchQueue.main.async {
                if let err = task.error {
                    let alertController = UIAlertController(title: "Error", message: err as? String, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alertController.addAction(alertAction)
                    self?.present(alertController, animated: true, completion: nil)
                } else {
                    strongSelf.navigationController?.popToRootViewController(animated: true)
                }
            }
            return nil
        })
    }
    
    // Handle Code Resend
    func resendCode() {
        self.user?.resendConfirmationCode().continueWith(block:{ [weak self] (task)-> Any? in

            guard let strongSelf = self else { return nil }
            DispatchQueue.main.async {
                if let err = task.error {
                    let alertController = UIAlertController(title: "Error", message: err as? String, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alertController.addAction(alertAction)
                    strongSelf.present(alertController, animated: true, completion: nil)
                } else if let result = task.result {
                    let alertController = UIAlertController(title: "Code Resent",
                                                            message: "Code resent to \(String(describing: result.codeDeliveryDetails?.destination!))",
                        preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    strongSelf.present(alertController, animated: true, completion: nil)
                }
            }
            return nil
        })
    }
}
