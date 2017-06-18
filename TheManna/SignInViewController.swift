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
        //setup getDetail
    }
    
    func didCompleteStepWithError(_ error: Error?) {
        if error != nil {
            //error for getting the detail
            
        } else {
            
            //completewithout error and do things
        }
    }
}
