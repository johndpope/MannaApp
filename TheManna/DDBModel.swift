//
//  DDBModel.swift
//  TheManna
//
//  Created by Sean Zhang on 6/22/17.
//  Copyright © 2017 Sean Zhang. All rights reserved.
//

import Foundation
import AWSDynamoDB


class DDBModel: AWSDynamoDBObjectModel, AWSDynamoDBModeling {
    
    var topic: String?
    var book: String?
    var chapter: Int?
    var verse: Int?
    var body: String?
    var reference: String?
    var imageURL: String?
    
    static func dynamoDBTableName() -> String {
        return "ScriptureDB"
    }
    
    static func hashKeyAttribute() -> String {
        return "reference"
    }
    
    static func rangeKeyAttribute() -> String {
        return "book"
    }
    
}
