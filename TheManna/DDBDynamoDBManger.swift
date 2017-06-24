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
let AWSScriptureTableName = "ScriptureDB"

class DDBDynamoDBManager: NSObject {
    
    class func describeTable() -> AWSTask<AnyObject> {
        let dynamoDB = AWSDynamoDB.default()
        
        // See if the test table exists.
        let describeTableInput = AWSDynamoDBDescribeTableInput()
        describeTableInput?.tableName = AWSScriptureTableName
        return dynamoDB.describeTable(describeTableInput!) as! AWSTask<AnyObject>
    }
    
    class func createTable() -> AWSTask<AnyObject> {
        print("Creating Table Right now.......")
        let dynamoDB = AWSDynamoDB.default()

        // Hash Key and Range Key
        let hashKeyAttributeDefinition = AWSDynamoDBAttributeDefinition()
        hashKeyAttributeDefinition?.attributeName = "reference"
        hashKeyAttributeDefinition?.attributeType = .S
        
        let hashKeySchemaElement = AWSDynamoDBKeySchemaElement()
        hashKeySchemaElement?.attributeName = "reference"
        hashKeySchemaElement?.keyType = .hash
        
        let rangeKeyAttributeDefinition = AWSDynamoDBAttributeDefinition()
        rangeKeyAttributeDefinition?.attributeName = "book"
        rangeKeyAttributeDefinition?.attributeType = .S
        
        let rangeKeySchemaElement = AWSDynamoDBKeySchemaElement()
        rangeKeySchemaElement?.attributeName = "book"
        rangeKeySchemaElement?.keyType = .range
        
        // Add non key attributes
        let chapterAttributeDefinition = AWSDynamoDBAttributeDefinition()
        chapterAttributeDefinition?.attributeName = "chapter"
        chapterAttributeDefinition?.attributeType = .N
        
        let verseAttributeDefinition = AWSDynamoDBAttributeDefinition()
        verseAttributeDefinition?.attributeName = "verse"
        verseAttributeDefinition?.attributeType = .N
        
        let bodyAttributeDefinition = AWSDynamoDBAttributeDefinition()
        bodyAttributeDefinition?.attributeName = "body"
        bodyAttributeDefinition?.attributeType = .S
        
        let topicAttributeDefinition = AWSDynamoDBAttributeDefinition()
        topicAttributeDefinition?.attributeName = "topic"
        topicAttributeDefinition?.attributeType = .S
        
        let provisionedThroughput = AWSDynamoDBProvisionedThroughput()
        provisionedThroughput?.writeCapacityUnits = 5
        provisionedThroughput?.readCapacityUnits = 5
        
        // Create global secondary index
        let rangeKeyArray = ["chapter", "verse", "topic"]
        var gsiArray = [AWSDynamoDBGlobalSecondaryIndex]()
        
        for rangeKey in rangeKeyArray {
            let gsi = AWSDynamoDBGlobalSecondaryIndex()
            
            let gsiHashKeySchema = AWSDynamoDBKeySchemaElement()
            gsiHashKeySchema?.attributeName = "reference"
            gsiHashKeySchema?.keyType = .hash
            
            let gsiRangeKeySchema = AWSDynamoDBKeySchemaElement()
            gsiRangeKeySchema?.attributeName = rangeKey
            gsiRangeKeySchema?.keyType = .range
            
            let gsiProjection = AWSDynamoDBProjection()
            gsiProjection?.projectionType = .all
            
            gsi?.keySchema = [gsiHashKeySchema!, gsiRangeKeySchema!]
            gsi?.indexName = rangeKey
            gsi?.projection = gsiProjection
            gsi?.provisionedThroughput = provisionedThroughput
            
            gsiArray.append(gsi!)
        }
        
        // Create Table 
        let createTableInput = AWSDynamoDBCreateTableInput()
        createTableInput?.tableName = AWSScriptureTableName
        createTableInput?.attributeDefinitions = [hashKeyAttributeDefinition!, rangeKeyAttributeDefinition!, chapterAttributeDefinition!, verseAttributeDefinition!, bodyAttributeDefinition!, topicAttributeDefinition!]
        createTableInput?.keySchema = [hashKeySchemaElement!, rangeKeySchemaElement!]
        createTableInput?.provisionedThroughput = provisionedThroughput
        createTableInput?.globalSecondaryIndexes = gsiArray
        
        // Create Table Request
        return dynamoDB.createTable(createTableInput!).continueOnSuccessWith(block: { (task:AWSTask<AWSDynamoDBCreateTableOutput>) -> Any? in
            
            guard task.result != nil else {
                return task
            }
            
            // wait up for 4 minutes until the table become active
            let describeTableInput = AWSDynamoDBDescribeTableInput()
            describeTableInput?.tableName = AWSScriptureTableName
            let describeTask = dynamoDB.describeTable(describeTableInput!)
            
            var localTask: AWSTask<AnyObject>?
            for _ in 0...15 {
                localTask = describeTask.continueOnSuccessWith(block: { (task: AWSTask<AWSDynamoDBDescribeTableOutput>) -> Any? in
                    let describeTableOuput: AWSDynamoDBDescribeTableOutput = task.result!
                    let tableStatus = describeTableOuput.table?.tableStatus
                    if tableStatus == AWSDynamoDBTableStatus.active {
                        return task
                    }
                    
                    sleep(15)
                    return dynamoDB.describeTable(describeTableInput!)
                })
                    
            }
        
            
            return localTask
        })
     
        
        
    }
    
    class func generateTestData() {
        
    }
}

class DDBTableRow :AWSDynamoDBObjectModel ,AWSDynamoDBModeling  {
    
    var UserId:String?
    
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
