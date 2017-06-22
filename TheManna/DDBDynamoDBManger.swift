//
//  DDBDynamoDBManger.swift
//  TheManna
//
//  Created by Sean Zhang on 6/21/17.
//  Copyright © 2017 Sean Zhang. All rights reserved.
//

import Foundation
import AWSDynamoDB

let AWSSampleDynamoDBTableName = "DynamoDB-OM-SwiftSample"

class DDBDynamoDBManager: NSObject {
    
    class func describeTable() -> AWSTask<AnyObject> {
        let dynamoDB = AWSDynamoDB.default()
        
        // See if the test table exists.
        let describeTableInput = AWSDynamoDBDescribeTableInput()
        describeTableInput?.tableName = AWSSampleDynamoDBTableName
        return dynamoDB.describeTable(describeTableInput!) as! AWSTask<AnyObject>
    }
    
    class func createTable() -> AWSTask<AnyObject> {
        print(123)
        
        return AWSTask()
    }
    
}

class DDBTableRow :AWSDynamoDBObjectModel ,AWSDynamoDBModeling  {
    
    var UserId:String?
    var verseBook: String?
    var verseChapter:String?
    var verseNumber: Int?
    var verseTopic: String?
    var verseTags: [String]?
    
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
        return "verseTopic"
    }
    
    class func ignoreAttributes() -> [String] {
        return ["internalName", "internalState"]
    }
}
