//
//  DDBDetailViewController.swift
//  TheManna
//
//  Created by Sean Zhang on 7/4/17.
//  Copyright © 2017 Sean Zhang. All rights reserved.
//

import Foundation
import AWSDynamoDB

class DDBDetailViewController: UIViewController {
    
    var viewType: DDBDetailViewType = DDBDetailViewType.unkown
    var tableRow: DDBTableRow?
    var dataChanged = false
    
    enum DDBDetailViewType {
        case unkown
        case insert
        case update
    }
    
    lazy var hashKeyTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.font = UIFont.systemFont(ofSize: 12)
        textField.borderStyle = UITextBorderStyle.line
        textField.backgroundColor = .yellow
        return textField
    }()
    
    var rangeKeyTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 12)
        textField.borderStyle = UITextBorderStyle.line
        textField.backgroundColor = .red
        return textField
    }()
    
    var attribute1TextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 12)
        textField.borderStyle = UITextBorderStyle.line
        textField.backgroundColor = .red
        return textField
    }()
    
    var attribute2TextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 12)
        textField.borderStyle = UITextBorderStyle.line
        textField.backgroundColor = .red
        return textField
    }()
    
    var attribute3TextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 12)
        textField.borderStyle = UITextBorderStyle.line
        textField.backgroundColor = .red
        return textField
    }()

    var saveButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(submit), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var userIDLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "userID"
        return label
    }()
    
    var gameTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Game Title"
        return label
    }()
    
    var topScoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Top Score"
        return label
    }()
    
    var winsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Wins"
        return label
    }()
    
    var losesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Loses"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupNavigationBar()
        
        // Do any additional setup after loading the view.
        switch self.viewType {
        case DDBDetailViewType.insert:
            self.title = "Insert"
            self.hashKeyTextField.isEnabled = true
            self.rangeKeyTextField.isEnabled = true
            
        case DDBDetailViewType.update:
            self.title = "Update"
            self.hashKeyTextField.isEnabled = false
            self.rangeKeyTextField.isEnabled = false
            self.getTableRow()
            
        default:
            print("ERROR: Invalid viewType!")
        }
    }
    
    override func didReceiveMemoryWarning() {
        print("received Memory Warning for DetailViewController")
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //code here
        super.viewWillDisappear(true)
        if (self.dataChanged) {
            let c = self.navigationController?.viewControllers.count
            let mainTableViewController = self.navigationController?.viewControllers [c! - 1] as! DDBMainTableViewController
            mainTableViewController.needsToRefresh = true
        }
        
    }
    
    func setupViews() {
        self.view.backgroundColor = .white
        self.view.addSubview(hashKeyTextField)
        self.view.addSubview(rangeKeyTextField)
        self.view.addSubview(attribute1TextField)
        self.view.addSubview(attribute2TextField)
        self.view.addSubview(attribute3TextField)
        
        self.view.addSubview(userIDLabel)
        self.view.addSubview(gameTitleLabel)
        self.view.addSubview(topScoreLabel)
        self.view.addSubview(winsLabel)
        self.view.addSubview(losesLabel)
        
        // Needs x, y, width, and height constraints
        hashKeyTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        hashKeyTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        hashKeyTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true
        hashKeyTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // Needs x, y, width, and height constraints
        rangeKeyTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        rangeKeyTextField.topAnchor.constraint(equalTo: hashKeyTextField.bottomAnchor, constant: 40).isActive = true
        rangeKeyTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true
        rangeKeyTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // Needs x, y, width, and height constraints
        attribute1TextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        attribute1TextField.topAnchor.constraint(equalTo: rangeKeyTextField.bottomAnchor, constant: 40).isActive = true
        attribute1TextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true
        attribute1TextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // Needs x, y, width, and height constraints
        attribute2TextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        attribute2TextField.topAnchor.constraint(equalTo: attribute1TextField.bottomAnchor, constant: 40).isActive = true
        attribute2TextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true
        attribute2TextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // Needs x, y, width, and height constraints
        attribute3TextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        attribute3TextField.topAnchor.constraint(equalTo: attribute2TextField.bottomAnchor, constant: 40).isActive = true
        attribute3TextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true
        attribute3TextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // Needs x, y, width, and height constraints
        userIDLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        userIDLabel.bottomAnchor.constraint(equalTo: hashKeyTextField.topAnchor, constant: -5).isActive = true
        userIDLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true
        userIDLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        // Needs x, y, width, and height constraints
        gameTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        gameTitleLabel.bottomAnchor.constraint(equalTo: rangeKeyTextField.topAnchor, constant: -5).isActive = true
        gameTitleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true
        gameTitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        // Needs x, y, width, and height constraints
        topScoreLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        topScoreLabel.bottomAnchor.constraint(equalTo: attribute1TextField.topAnchor, constant: -5).isActive = true
        topScoreLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true
        topScoreLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        // Needs x, y, width, and height constraints
        winsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        winsLabel.bottomAnchor.constraint(equalTo: attribute2TextField.topAnchor, constant: -5).isActive = true
        winsLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true
        winsLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        // Needs x, y, width, and height constraints
        losesLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        losesLabel.bottomAnchor.constraint(equalTo: attribute3TextField.topAnchor, constant: -5).isActive = true
        losesLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true
        losesLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func setupNavigationBar() {
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(submit))
        self.navigationItem.rightBarButtonItems = [addBarButtonItem]
    }
    
    func getTableRow() {
        let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()
        
        //tableRow?.UserId --> (tableRow?.UserId)!
        dynamoDBObjectMapper.load(DDBTableRow.self, hashKey: (tableRow?.UserId)!, rangeKey: tableRow?.GameTitle)
            .continueWith(executor: AWSExecutor.mainThread()) { task -> Any? in
                if let err = task.error {
                    print("getTableRow failed: \(err)")
                    let alertController = UIAlertController(title: "getTableRow Failed",
                                                            message: err as? String,
                                                            preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Ok",
                                                    style: .cancel,
                                                    handler: nil)
                    alertController.addAction(alertAction)
                    self.present(alertController,
                                 animated: true, completion: nil)
                } else if let tableRow = task.result as? DDBTableRow {
                    print("getTableRow success")
                    self.rangeKeyTextField.text = tableRow.UserId!
                    self.hashKeyTextField.text = String(describing: tableRow.GameTitle!)
                    self.attribute1TextField.text = String(describing: tableRow.Losses!)
                    self.attribute2TextField.text = String(describing: tableRow.Wins!)
                    self.attribute3TextField.text = String(describing: tableRow.TopScore!)
                    
                    
                }
              return nil
        }
        
       
    }
    
    func insertTableRow(_ tableRow: DDBTableRow) {
        print(1)
        let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()
        
        dynamoDBObjectMapper.save(tableRow).continueWith(executor: AWSExecutor.mainThread()) { (task) -> Any? in
            if let err = task.error {
                let alertController = UIAlertController(title: "insertTableRow failed",
                                                        message: err as? String, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok",
                                                style: .cancel, handler: nil)
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
            } else if let result = task.result {
                let alertController = UIAlertController(title: "insertTableRow Success",
                                                        message: "\(result.isFinished)", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok",
                                                style: .cancel, handler: nil)
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
                
                self.hashKeyTextField.text = nil
                
                self.dataChanged = true
            }
            return nil
        }
    }
    
    func updateTableRow(_ tableRow: DDBTableRow){
        let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()
        
        dynamoDBObjectMapper.save(tableRow).continueWith(executor: AWSExecutor.mainThread()) { (task) -> Any? in
            if let err = task.error {
                let alertController = UIAlertController(title: "updateTableRow failed",
                                                        message: err as? String,
                                                        preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok",
                                                style: .cancel,
                                                handler: nil)
                alertController.addAction(alertAction)
                self.present(alertController,
                             animated: true,
                             completion: nil)
                
            } else {
                let alertController = UIAlertController(title: "Success",
                                                        message: "Successfully updated the data into the table.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .default,
                                                handler: nil)
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
                
                if (self.viewType == DDBDetailViewType.insert) {
                    self.rangeKeyTextField.text = nil
                    self.hashKeyTextField.text = nil
                }
                self.dataChanged = true
            }
            return nil
        }
        
    }
    
    func submit() {
        let tableRow = DDBTableRow()
        tableRow?.UserId = self.hashKeyTextField.text
        tableRow?.GameTitle = self.rangeKeyTextField.text
        
        if let attr1 = Int(self.attribute1TextField.text!) {
            tableRow?.TopScore = attr1 as NSNumber
        }
        if let attr2 = Int(self.attribute2TextField.text!) {
            tableRow?.Wins = attr2 as NSNumber
        }
        if let attr3 = Int(self.attribute3TextField.text!) {
            tableRow?.Losses = attr3 as NSNumber
        }
        
        
        switch self.viewType {
        case DDBDetailViewType.insert:
            if ((self.rangeKeyTextField.text?.utf16.count)! > 0) {
                self.insertTableRow(tableRow!)
            } else {
                let alertController = UIAlertController(title: "Error: Invalid Input",
                                                        message: "Range Key Value cannot be empty.",
                                                        preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
        case DDBDetailViewType.update:
            if ((self.rangeKeyTextField.text?.utf16.count)! > 0) {
                self.updateTableRow(tableRow!)
            } else {
                let alertController = UIAlertController(title: "Error: Invalid Input",
                                                        message: "Range Key Value cannot be empty.",
                                                        preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
        default:
            print("Invalid View.Type")
            
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
}
