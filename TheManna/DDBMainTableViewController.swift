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
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(DBMainTableCell.self, forCellReuseIdentifier: tableCellID)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellID, for: indexPath) as! DBMainTableCell
        
        cell.label1.text = "Test"
        cell.label2.text = "Label 2"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

class DBMainTableCell: UITableViewCell {
    
    var label1: UILabel = { () -> UILabel in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Label 1"
        label.backgroundColor = .red
        return label
    }()
    
    var label2: UILabel = { () -> UILabel in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Label 2"
        label.backgroundColor = .brown
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(label1)
        addSubview(label2)
        
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews(){
        
        label1.topAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label1.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label1.heightAnchor.constraint(equalToConstant: 50).isActive = true
        label1.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -30).isActive = true
        
        label2.topAnchor.constraint(equalTo: label1.bottomAnchor).isActive = true
        label2.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label2.heightAnchor.constraint(equalToConstant: 50).isActive = true
        label2.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -30).isActive = true
        
        
    }
}







