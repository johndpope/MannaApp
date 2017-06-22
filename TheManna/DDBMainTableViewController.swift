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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellID, for: indexPath)
        
        cell.textLabel?.text = "Test "
        reutrn cell
    }
}

class DBMainTableCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        <#code#>
    }
}
