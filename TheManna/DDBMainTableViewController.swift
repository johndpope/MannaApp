//
//  DDBMainTableViewController.swift
//  TheManna
//
//  Created by Sean Zhang on 6/21/17.
//  Copyright © 2017 Sean Zhang. All rights reserved.
//

import Foundation
import AWSDynamoDB

let tableCellID = "tID"

class DDBMainTableViewController: UITableViewController {
    
    var scriptures: [DDBModel] = {
        let scriptOne = DDBModel()
        scriptOne?.book = "Romans"
        scriptOne?.chapter = 3
        scriptOne?.verse = 21
        scriptOne?.topic = "Prayer"
        scriptOne?.body = "But now the righteousness of God has been manifested apart from the law, although the Law and the Prophets near witness to it"
        let scriptTwo = DDBModel()
        scriptTwo?.book = "Ephesians"
        scriptTwo?.chapter = 2
        scriptTwo?.verse = 15
        scriptTwo?.topic = "Praise"
        scriptTwo?.body = "By abolishing the law of commandments expressed in ordinances, that he might create in himself one new man in place of the two, so making peace."
        
        return [scriptOne!, scriptTwo!]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(DBMainTableCell.self, forCellReuseIdentifier: tableCellID)
        
        //fetchDynamoDB()
        //addTableRow()
    }
    
    func fetchDynamoDB() {
        
        DDBDynamoDBManager.describeTable().continueWith(executor: AWSExecutor.mainThread(), block: { task -> Any? in
            
            if let error = task.error {
                print("Error when describing the table or the table doesn't exist?")
                print(error.localizedDescription)
                
            } else {
                print("Successful describe Table")
                let resultTask = task as! AWSTask<AWSDynamoDBDescribeTableOutput>
                if let tableName = resultTask.result?.table?.tableName {
                    print("printing tableName")
                    print(tableName)
                    self.refreshList()
                }
                
            }
            return nil
        })
    }
    
    func refreshList()  {
        //
        let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()
        let queryExpression = AWSDynamoDBScanExpression()
        dynamoDBObjectMapper.scan(DDBModel.self, expression: queryExpression).continueWith(executor: AWSExecutor.mainThread(), block: { task -> Any? in
            if let err = task.error {
                print("Scanning Error")
                print(err.localizedDescription)
            } else {
                print("Scanning Successed")
                let outputs = task.result?.items as! [DDBModel]
                for item in outputs {
                    print(item)
                    print("")
                }
            }
            return nil
        })
    }
    
    func addTableRow() {
        let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()
        var task = AWSTask<AnyObject>()
        let tableRow = DDBModel()
        tableRow?.reference = "Titus"
        tableRow?.chapter = 3
        tableRow?.verse = 1
        tableRow?.topic = "Submission"
        tableRow?.body = "Remind them to be submissive to rulers"
        task = dynamoDBObjectMapper.save(tableRow!)
        
        AWSTask<AnyObject>(forCompletionOfAllTasks: [task]).continueWith(executor: AWSExecutor.mainThread(), block: { task -> Any? in
        
            if let err = task.error {
                print("Error Occur when saving tableRow")
                print(err.localizedDescription)
                print(err)
            } else {
                print("Success saving the tablerow")
                
            }
            return nil
        })
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scriptures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellID, for: indexPath) as! DBMainTableCell
        
        cell.label1.text = "Test"
        cell.label2.text = "Label 2"
        cell.scripture = scriptures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

class DBMainTableCell: UITableViewCell {
    
    var scripture: DDBModel? {
        didSet {
            self.label1.text = scripture?.book
            self.label2.text = "Chapter: " + String(describing: scripture!.chapter)
            self.label3.text = "Verse: " + String(describing: scripture!.verse)
            self.label4.text = "Topic: " + (scripture?.topic)!
            self.scriptureTextView.text = scripture?.body
        }
    }
    
    var label1: UILabel = { () -> UILabel in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Label 1"
        label.font = UIFont.boldSystemFont(ofSize: 9)
        label.backgroundColor = .red
        return label
    }()
    
    var label2: UILabel = { () -> UILabel in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Label 2"
        label.font = UIFont.boldSystemFont(ofSize: 9)
        label.backgroundColor = .brown
        return label
    }()
    
    var label3: UILabel = { () -> UILabel in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Label 3"
        label.font = UIFont.boldSystemFont(ofSize: 9)
        label.backgroundColor = .gray
        return label
    }()
    
    var label4: UILabel = { () -> UILabel in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Label 4"
        label.font = UIFont.boldSystemFont(ofSize: 9)
        label.backgroundColor = .yellow
        return label
    }()
    
    var scriptureTextView: UITextView = { () -> UITextView in
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Label 5"
        textView.font = UIFont.boldSystemFont(ofSize: 9)
        textView.backgroundColor = .blue
        return textView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(label1)
        addSubview(label2)
        addSubview(label3)
        addSubview(label4)
        addSubview(scriptureTextView)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews(){
        
        label1.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        label1.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label1.heightAnchor.constraint(equalToConstant: 10).isActive = true
        label1.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -30).isActive = true
        
        label2.topAnchor.constraint(equalTo: label1.bottomAnchor).isActive = true
        label2.leftAnchor.constraint(equalTo: label1.leftAnchor).isActive = true
        label2.heightAnchor.constraint(equalToConstant: 10).isActive = true
        label2.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5, constant: -15).isActive = true
        
        label3.topAnchor.constraint(equalTo: label1.bottomAnchor).isActive = true
        label3.leftAnchor.constraint(equalTo: label2.rightAnchor).isActive = true
        label3.heightAnchor.constraint(equalToConstant: 10).isActive = true
        label3.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5, constant: -15).isActive = true
        
        label4.topAnchor.constraint(equalTo: label3.bottomAnchor).isActive = true
        label4.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label4.heightAnchor.constraint(equalToConstant: 10).isActive = true
        label4.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -30).isActive = true
        
        scriptureTextView.topAnchor.constraint(equalTo: label4.bottomAnchor).isActive = true
        scriptureTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        scriptureTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        scriptureTextView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -30).isActive = true
    }
}







