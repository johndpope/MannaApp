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
        //Well
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
        //Upload an image file onto the Parse Server
        let imageData = UIImagePNGRepresentation(#imageLiteral(resourceName: "twitter"))
        print("imageData: \(String(describing: imageData))")
        let imageFile = PFile
    }
}
