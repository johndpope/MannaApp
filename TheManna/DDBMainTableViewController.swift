//
//  DDBMainTableViewController.swift
//  TheManna
//
//  Created by Sean Zhang on 6/21/17.
//  Copyright © 2017 Sean Zhang. All rights reserved.
//

import Foundation
import AWSDynamoDB
import AWSCognito
import AWSCognitoIdentityProvider

let tableCellID = "tID"

class DDBMainTableViewController: UITableViewController {
    
    var response: AWSCognitoIdentityUserGetDetailsResponse?
    var user: AWSCognitoIdentityUser?
    var pool: AWSCognitoIdentityUserPool?
    
    var needsToRefresh = false
    
    var scriptures: [DDBModel] = {
        let scriptOne = DDBModel()
        scriptOne?.reference = "romans:3-21"
        scriptOne?.book = "Romans"
        scriptOne?.chapter = 3
        scriptOne?.verse = 21
        scriptOne?.topic = "Prayer"
        scriptOne?.body = "But now the righteousness of God has been manifested apart from the law, although the Law and the Prophets near witness to it"
        scriptOne?.imageURL = "https://s3.amazonaws.com/scripturebucket/IMG_2403.jpg"
        let scriptTwo = DDBModel()
        scriptTwo?.reference = "ephesians:2-15"
        scriptTwo?.book = "Ephesians"
        scriptTwo?.chapter = 2
        scriptTwo?.verse = 15
        scriptTwo?.topic = "Praise"
        scriptTwo?.body = "By abolishing the law of commandments expressed in ordinances, that he might create in himself one new man in place of the two, so making peace."
        scriptTwo?.imageURL = "https://s3.amazonaws.com/scripturebucket/IMG_2403.jpg"
        
        return [scriptOne!, scriptTwo!]
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(DBMainTableCell.self, forCellReuseIdentifier: tableCellID)
        setupNavigationBar()
        self.pool = AWSCognitoIdentityUserPool(forKey: "UserPool")
        if self.user == nil {
            self.user = self.pool?.currentUser()
        }
        
       self.refresh()
        
        //setupTable()
        //addTableRow()
        
    }
    
    func refresh() {
        self.user?.getDetails().continueOnSuccessWith(block: { (task: AWSTask<AWSCognitoIdentityUserGetDetailsResponse>) -> Any? in
            DispatchQueue.main.async {
                self.response = task.result
                print("getDetail in TableView Called")
                //print(self.response.debugDescription)
                self.tableView.reloadData()
            }
            
            return nil
        })
    }
    
    func setupNavigationBar(){
 
        let cancelBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(signOut))
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        let refreshBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshItem))
        let editBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(editItem))
        self.navigationItem.rightBarButtonItems = [editBarButtonItem, cancelBarButtonItem]
        self.navigationItem.leftBarButtonItems = [addBarButtonItem, refreshBarButtonItem]
        
    }
    
    func editItem(){
        print("edit Item")
    }
    
    func addItem() {
        print("addItem")
        let detailViewController = DDBDetailViewController()
        detailViewController.viewType = .insert
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func readItem() {
        print("updateItem")
        
    }
    
    func updateItem() {
        print("update Item")
    }
    
    func deleteItem() {
        print("deleteItem")
    }
    

    func refreshItem(){
        print("refreshing items")
    }
    
    
    func signOut() {
        print("Signout")
        user?.signOut()
        response = nil
        pool?.clearAll()
        self.refresh()
        tableView.reloadData()
    }
    func setupTable() {
        
        DDBDynamoDBManager.describeTable().continueWith(executor: AWSExecutor.mainThread(), block: { task -> Any? in
            
            // If the test table doesn't exist, create one.
            if let error = task.error as NSError?, error.domain == AWSDynamoDBErrorDomain && error.code == AWSDynamoDBErrorType.resourceNotFound.rawValue {
                self.navigationController?.present(DDBLoadingViewController(), animated: true, completion: nil)
                
                return DDBDynamoDBManager.createTable() .continueWith(executor: AWSExecutor.mainThread(), block: { (task:AWSTask!) -> AnyObject! in
                    if let error = task.error as NSError? {
                        //Handle errors.
                        print("Error: \(error)")
                        
                        let alertController = UIAlertController(title: "Failed to setup a test table.", message: error.description, preferredStyle: UIAlertControllerStyle.alert)
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                        alertController.addAction(okAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                    } else {
                        self.dismiss(animated: false, completion: nil)
                    }
                    
                    return nil
                    
                })
            } else {
                //load table contents
                print("Refreshing List because table already exist")
                self.refreshList(true)
            }
            return nil
        })
    }
    
    func refreshList(_ startFromBegining: Bool)  {
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







