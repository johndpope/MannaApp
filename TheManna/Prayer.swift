//
//  Prayer.swift
//  TheManna
//
//  Created by Sean Zhang on 7/14/17.
//  Copyright © 2017 Sean Zhang. All rights reserved.
//

import Foundation
import UIKit

class Prayer: NSObject {
    
    var date: NSData?
    var duration: NSDate?
    var topic: String?
    var content: String?
    var challenge: String?
    
    init(topic: String) {
        super.init()
        self.topic = topic
    }
    
    func startPray(){
        
        print("Starting pray now");
        
    }
    
    func stopPray(){
        
        print("Stop Pray now")
        
    }
    
    
}
