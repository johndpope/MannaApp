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


class DDBTableRow :AWSDynamoDBObjectModel ,AWSDynamoDBModeling  {
    
    var UserId:String?
    var GameTitle:String?
    
    //set the default values of scores, wins and losses to 0
    var TopScore:NSNumber? = 0
    var Wins:NSNumber? = 0
    var Losses:NSNumber? = 0
    
    //should be ignored according to ignoreAttributes
    var internalName:String?
    var internalState:NSNumber?
    
    class func dynamoDBTableName() -> String {
        return AWSSampleDynamoDBTableName
    }
    
    class func hashKeyAttribute() -> String {
        return "UserId"
    }
    
    class func rangeKeyAttribute() -> String {
        return "GameTitle"
    }
    
    class func ignoreAttributes() -> [String] {
        return ["internalName", "internalState"]
    }
}
