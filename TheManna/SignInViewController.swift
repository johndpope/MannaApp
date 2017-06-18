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
    override func viewDidLoad() {
        //setup here
    }
}


extension SignInViewController: AWSCognitoIdentityPasswordAuthentication {
    
    
    
    func getDetails(_ authenticationInput: AWSCognitoIdentityPasswordAuthenticationInput, passwordAuthenticationCompletionSource: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>) {
            self.passwordAuthenticationCompletion = passwordAuthenticationCompletionSource
            DispatchQueue.main.async {
                if (self.usernameText == nil) {
                    self.usernameText = authenticationInput.lastKnownUsername
                }
            }
    }
    
    
    func didCompleteStepWithError(_ error: Error?) {
        DispatchQueue.main.async {
            print("DidCompletestepWithError")
            if let error = error as? NSError {
                let alertController = UIAlertController(title: error.userInfo["__type"] as? String,
                                                        message: error.userInfo["message"] as? String,
                                                        preferredStyle: .alert)
                let retryAction = UIAlertAction(title: "Retry", style: .default, handler: nil)
                alertController.addAction(retryAction)
                
                self.present(alertController, animated: true, completion:  nil)
            } else {
                self.username.text = nil
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
