//
//  AmazonClientManager.swift
//  TheManna
//
//  Created by Sean Zhang on 6/11/17.
//  Copyright © 2017 Sean Zhang. All rights reserved.
//

import Foundation
import UICKeyChainStore
import AWSCore
import AWSCognito

class AmazonClientManager: NSObject {
    
    static let sharedInstance = AmazonClientManager()
    
    enum Provider: String {
        case FB,GOOGLE
    }
    
    //KeyChain Constants
    let FB_PROVIDER = Provider.FB.rawValue
    let GOOGLE_PROVIDER = Provider.GOOGLE.rawValue

    //Properties
    var keyChain: UICKeyChainStore
    var completionHandler: AWSContinuationBlock?
    var credentialsProvider: AWSCognitoCredentialsProvider?
    var loginViewController: UIViewController?
    
    override init() {
        keyChain = UICKeyChainStore(service: Bundle.main.bundleIdentifier!)
        
        super.init()
    }
    
    
    
    // MARK: General Login
    
    func isConfigured() -> Bool {
        return !(Constants.COGNITO_IDENTITY_POOL_ID == "YourCognitoIdentityPoolId" || Constants.COGNITO_REGIONTYPE == AWSRegionType.Unknown)
    }
    
    func resumeSession(completionHandler: AWSContinuationBlock) {
        self.completionHandler = completionHandler
        
        if self.keyChain[BYOI_PROVIDER] != nil {
            self.reloadBYOISession()
        } else if self.keyChain[FB_PROVIDER] != nil {
            self.reloadFBSession()
        } else if self.keyChain[AMAZON_PROVIDER] != nil {
            self.amazonLogin()
        } else if self.keyChain[GOOGLE_PROVIDER] != nil {
            self.reloadGSession()
        } else if self.keyChain[TWITTER_PROVIDER] != nil {
            self.twitterLogin()
        } else if self.keyChain[DIGITS_PROVIDER] != nil {
            self.digitsLogin()
        }
        
        if self.credentialsProvider == nil {
            self.completeLogin(nil)
        }
    }
    
    //Sends the appropriate URL based on login provider
    func application(application: UIApplication,
        openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
            if GPPURLHandler.handleURL(url, sourceApplication: sourceApplication, annotation: annotation) {
                return true
            }
            
            if FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation) {
                return true
            }
            
            if AIMobileLib.handleOpenURL(url, sourceApplication: sourceApplication) {
                return true
            }
            return false
    }
    
    func completeLogin(logins: [NSObject : AnyObject]?) {
        var task: AWSTask?
        
        if self.credentialsProvider == nil {
            task = self.initializeClients(logins)
        } else {
            var merge = [NSObject : AnyObject]()
            
            //Add existing logins
            if let previousLogins = self.credentialsProvider?.logins {
                merge = previousLogins
            }
            
            //Add new logins
            if let unwrappedLogins = logins {
                for (key, value) in unwrappedLogins {
                    merge[key] = value
                }
                self.credentialsProvider?.logins = merge
            }
            //Force a refresh of credentials to see if merge is necessary
            task = self.credentialsProvider?.refresh()
        }
        task?.continueWithBlock {
        (task: AWSTask!) -> AnyObject! in
            if (task.error != nil) {
                let userDefaults = NSUserDefaults.standardUserDefaults()
                let currentDeviceToken: NSData? = userDefaults.objectForKey(Constants.DEVICE_TOKEN_KEY) as? NSData
                var currentDeviceTokenString : String
                
                if currentDeviceToken != nil {
                    currentDeviceTokenString = currentDeviceToken!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
                } else {
                    currentDeviceTokenString = ""
                }
                
                if currentDeviceToken != nil && currentDeviceTokenString != userDefaults.stringForKey(Constants.COGNITO_DEVICE_TOKEN_KEY) {
                    
                    AWSCognito.defaultCognito().registerDevice(currentDeviceToken).continueWithBlock { (task: AWSTask!) -> AnyObject! in
                        if (task.error == nil) {
                            userDefaults.setObject(currentDeviceTokenString, forKey: Constants.COGNITO_DEVICE_TOKEN_KEY)
                            userDefaults.synchronize()
                        }
                        return nil
                    }
                }
            }
            return task
        }.continueWithBlock(self.completionHandler)
    }
    
    func initializeClients(logins: [NSObject : AnyObject]?) -> AWSTask? {
        print("Initializing Clients...")
        
        AWSLogger.defaultLogger().logLevel = AWSLogLevel.Verbose
        
        let identityProvider = DeveloperAuthenticatedIdentityProvider(
            regionType: Constants.COGNITO_REGIONTYPE,
            identityId: nil,
            identityPoolId: Constants.COGNITO_IDENTITY_POOL_ID,
            logins: logins,
            providerName: Constants.DEVELOPER_AUTH_PROVIDER_NAME,
            authClient: self.devAuthClient)
        self.credentialsProvider = AWSCognitoCredentialsProvider(regionType: Constants.COGNITO_REGIONTYPE, identityProvider: identityProvider, unauthRoleArn: nil, authRoleArn: nil)
        let configuration = AWSServiceConfiguration(region: Constants.COGNITO_REGIONTYPE, credentialsProvider: self.credentialsProvider)
        AWSServiceManager.defaultServiceManager().defaultServiceConfiguration = configuration
        
        return self.credentialsProvider?.getIdentityId()
    }
    
    func loginFromView(theViewController: UIViewController, withCompletionHandler completionHandler: AWSContinuationBlock) {
        self.completionHandler = completionHandler
        self.loginViewController = theViewController
        self.displayLoginSheet()
    }
    
    func logOut(completionHandler: AWSContinuationBlock) {
        if self.isLoggedInWithFacebook() {
            self.fbLogout()
        } else if self.isLoggedInWithAmazon() {
            self.amazonLogout()
        } else if self.isLoggedInWithGoogle() {
            self.googleLogout()
        } else if self.isLoggedInWithTwitter() {
            self.twitterLogout()
        } else if self.isLoggedInWithDigits() {
            self.digitsLogout()
        }
        self.devAuthClient?.logout()
        
        // Wipe credentials
        self.credentialsProvider?.logins = nil
        AWSCognito.defaultCognito().wipe()
        self.credentialsProvider?.clearKeychain()
        
        AWSTask(result: nil).continueWithBlock(completionHandler)
    }
    
    func isLoggedIn() -> Bool {
        return isLoggedInWithFacebook() || isLoggedInWithGoogle() || isLoggedInWithTwitter() || isLoggedInWithDigits() || isLoggedInWithAmazon() || isLoggedInWithBYOI()
    }
    
}
