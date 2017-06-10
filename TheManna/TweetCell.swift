//
//  TweetCell.swift
//  TheManna
//
//  Created by Sean Zhang on 6/9/17.
//  Copyright © 2017 Sean Zhang. All rights reserved.
//

import Foundation
import UIKit
import LBTAComponents

class TweetCell: DatasourceCell {
    
    override func setupViews() {
        backgroundColor = .yellow
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        
    }
}
