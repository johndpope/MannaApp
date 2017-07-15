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



class DDBMainTableViewController: UITableViewController {
    
    var response: AWSCognitoIdentityUserGetDetailsResponse?
    var user: AWSCognitoIdentityUser?
    var pool: AWSCognitoIdentityUserPool?
    let tableCellID = "CellID"
    
    var needsToRefresh = false
    
    var tableRows: [DDBTableRow]? = {
        let rowOne = DDBTableRow()
        rowOne?.UserId = "221"
        rowOne?.GameTitle = "Flash"
        rowOne?.Wins = 1
        rowOne?.Losses = 2
        rowOne?.TopScore = 4
        
        let rowTwo = DDBTableRow()
        rowOne?.UserId = "221"
        rowOne?.GameTitle = "Flash"
        rowOne?.Wins = 1
        rowOne?.Losses = 2
        rowOne?.TopScore = 4
        
        return [rowOne!, rowTwo!]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(DBMainTableCell.self, forCellReuseIdentifier: tableCellID)
        setupNavigationBar()
        self.pool = AWSCognitoIdentityUserPool(forKey: "UserPool")
        if self.user == nil {
            self.user = self.pool?.currentUser()
        }
        
        tableRows = []
        self.setupTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if self.needsToRefresh {
            self.refreshList(true)
            self.needsToRefresh = false
        }
    }
    
    // Setting up views
    func setupNavigationBar(){
        
        let cancelBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(signOut))
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTableRow))
        self.navigationItem.rightBarButtonItems = [cancelBarButtonItem]
        self.navigationItem.leftBarButtonItems = [addBarButtonItem]
        
    }
    
    // This function called for user pool
    func refresh() {
        self.user?.getDetails().continueOnSuccessWith(block: { (task: AWSTask<AWSCognitoIdentityUserGetDetailsResponse>) -> Any? in
            DispatchQueue.main.async {
                self.response = task.result
                print("getDetail in TableView Called")
                self.tableView.reloadData()
            }
            
            return nil
        })
    }
    
    func signOut() {
        print("Signout")
        user?.signOut()
        response = nil
        pool?.clearAll()
        self.refresh()
        tableView.reloadData()
    }
    

    
    func addTableRow() {
        let detailViewController = DDBDetailViewController()
        detailViewController.viewType = .insert
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func deleteTableRow() {
        
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
        
        
        let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()
        let queryExpression = AWSDynamoDBScanExpression()
        dynamoDBObjectMapper.scan(DDBTableRow.self, expression: queryExpression).continueWith(executor: AWSExecutor.mainThread(), block: { task -> Any? in
            if let err = task.error {
                print("Scanning Error")
                print(err.localizedDescription)
            } else {
                print("Scanning Successed")
                self.tableRows = task.result?.items as? [DDBTableRow]
                
            }
            self.tableView.reloadData()
            
            return nil
        })
    }
    

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rowsCount = tableRows?.count {
            return rowsCount
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellID, for: indexPath) as! DBMainTableCell
        
        cell.tableRow = tableRows?[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DDBDetailViewController()
        detailViewController.viewType = .update
        detailViewController.tableRow = tableRows?[indexPath.row]
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let shareAction = UITableViewRowAction(style: .normal, title: "Share") { (action: UITableViewRowAction, indexPath: IndexPath) in
            print("Share")
        }
        shareAction.backgroundColor = .blue
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (action: UITableViewRowAction, indexPath: IndexPath) in
            print("Deleting.........")
        }
        deleteAction.backgroundColor = .red
        return [shareAction, deleteAction]
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

    }
}








