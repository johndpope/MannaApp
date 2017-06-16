//
//  ParseServerController.swift
//  TheManna
//
//  Created by Sean Zhang on 6/11/17.
//  Copyright © 2017 Sean Zhang. All rights reserved.
//

import Foundation
import Parse

class ParseServerController: NSObject {
    
    override init() {
        
        super.init()
    }
    
    func uploadFile() {
        
        let testObject = PFObject(className: "TestObject")
        testObject["foo"] = "pooo"
        testObject.saveInBackground { (success: Bool, error: Error?) -> Void in
            print("Object has been saved.----------------------------------------")
        }
    }
    
    func uploadImage()  {

        let testObject = PFObject(className: "TestObject")
        
        testObject["files"] = UIImagePNGRepresentation(#imageLiteral(resourceName: "twitter"))
        
        testObject.saveInBackground { (success: Bool, error: Error?) -> Void in
            print("Object has been saved.----------------------------------------")
        }
    }
    
    func retrieveObjects()  {
        let query = PFQuery(className: "JSONTable")
        query.whereKey("name", contains: "josh")
        query.findObjectsInBackground{ (objects: [PFObject]?, error: Error?) in
            if (error != nil) {
                if let fetchedObjects = objects {
                    for ojb in fetchedObjects {
                        print(ojb)
                    }
                }
            } else {
                if let err = error {
                    print(err)
                }
                
            }
            
        }
    }

    func downloadImageFile() -> Data? {
     
        var returnData: Data?
        
        let query = PFQuery(className: "TestObject")
        query.whereKey("objectId", equalTo: "mUdedS4oJB")
        //query.whereKey("foo", contains: "bar")
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(String(describing: objects?.count)) items.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        //place this in your for loop
                        let imageFile = object["files"] as! PFFile
                        
                        imageFile.getDataInBackground {
                            (imageData: Data?, error: Error?) -> Void in
                            if error == nil {
                                print("Image File Data Transmitted")
                                if let data = imageData {
                                
                                    returnData = data

                                }
                            }
                        }
                        
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.localizedDescription)")
            }
        }
        return returnData
    }
        
}

