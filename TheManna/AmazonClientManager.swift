//
//  AmazonClientManager.swift
//  TheManna
//
//  Created by Sean Zhang on 7/15/17.
//  Copyright © 2017 Sean Zhang. All rights reserved.
//

import Foundation
import UIKit
import AWSCore
import AWSCognito


class AmazonClientManager: NSObject {
    

    // MARK: === Data Member ===
    
    static let sharedInstance = AmazonClientManager()
    
    // MARK: === Properties ===
    
    enum Provider: String {
        case FB, GOOGLE
    }
    
    var credentialProvider: AWSCognitoCredentialsProvider?
    
    // Keychain constants
    let FB_PROVIDER = Provider.FB.rawValue
    let GOOGLE_PROVIDER = Provider.GOOGLE.rawValue
    
    
    // MARK: === Construction ===
    override init() {
        super.init()
    }
    
    // MARK: === Operation ===
    
    // General Login
    
    func completeLogin(logins: [NSObject: AnyObject]?) {
        var task: AWSTask<AnyObject>?
        
        if self.credentialProvider == nil {
            
        } else {
            
        }
    }
    
    func initializeClients(logins: [NSObject: AnyObject]?) -> AWSTask<AnyObject>? {
        print("Initializing Client")
        
        
        return self.credentialProvider?.getIdentityId() as! AWSTask<AnyObject>
    }
    func signOut() {
        
    }
    
    func signIn() {
        
    }

}
