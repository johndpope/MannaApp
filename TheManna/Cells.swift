//
//  Cells.swift
//  TheManna
//
//  Created by Sean Zhang on 6/1/17.
//  Copyright © 2017 Sean Zhang. All rights reserved.
//

import Foundation
import LBTAComponents

class UserFooter: DatasourceCell {
    override func setupViews() {
        super.setupViews()
        backgroundColor = .red
    }
}

class UserHeader: DatasourceCell {
    override func setupViews() {
        super.setupViews()
        backgroundColor = .blue
        
    }
}

class UserCell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet {
            nameLabel.text = datasourceItem as? String
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "TEST TEST"
        return label
    }()
    
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .yellow
        addSubview(nameLabel)
        nameLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}
