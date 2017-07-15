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
    
    // Keychain constants
    let FB_PROVIDER = Provider.FB.rawValue
    let GOOGLE_PROVIDER = Provider.GOOGLE.rawValue
    
    
    // MARK: === Construction ===
    override init() {
        super.init()
    }
    
    // MARK: === Operation ===
    
    func signOut() {
        
    }
    
    func signIn() {
        
    }

}
