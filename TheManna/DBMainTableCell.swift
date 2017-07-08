//
//  DBMainTableCell.swift
//  TheManna
//
//  Created by Sean Zhang on 7/8/17.
//  Copyright © 2017 Sean Zhang. All rights reserved.
//

import Foundation
import UIKit

class DBMainTableCell: UITableViewCell {
    
    var tableRow: DDBTableRow? {
        didSet {
            self.label1.text = "User Id" + String(describing: tableRow!.UserId)
            self.label2.text = String(describing: tableRow!.GameTitle)
        }
    }
    
    var label1: UILabel = { () -> UILabel in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Label 1"
        label.font = UIFont.boldSystemFont(ofSize: 9)
        
        return label
    }()
    
    var label2: UILabel = { () -> UILabel in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Label 2"
        label.font = UIFont.boldSystemFont(ofSize: 9)
        
        return label
    }()
    
    var label3: UILabel = { () -> UILabel in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Label 3"
        label.font = UIFont.boldSystemFont(ofSize: 9)
        
        return label
    }()
    
    var label4: UILabel = { () -> UILabel in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Label 4"
        label.font = UIFont.boldSystemFont(ofSize: 9)
        
        return label
    }()
    
    var oneTextView: UITextView = { () -> UITextView in
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Label 5"
        textView.font = UIFont.boldSystemFont(ofSize: 9)
        
        return textView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(label1)
        addSubview(label2)
        addSubview(label3)
        addSubview(label4)
        addSubview(oneTextView)
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
        
        oneTextView.topAnchor.constraint(equalTo: label4.bottomAnchor).isActive = true
        oneTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        oneTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        oneTextView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -30).isActive = true
    }
}
