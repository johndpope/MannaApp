//
//  PDFView.swift
//  TheManna
//
//  Created by Sean Zhang on 6/14/17.
//  Copyright © 2017 Sean Zhang. All rights reserved.
//

import Foundation
import UIKit
import Parse

class PDFViewController: UIViewController {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        return imageView
        
    }()
    
    override func viewDidLoad() {
        setupViews()
    }
    
    
    func setupViews (){
        
        self.view.addSubview(imageView)
        
        let parse = ParseServerController()
        let imagedown = parse.downloadImageFile()
        imageView.image = imagedown
        imageView.anchor(self.view.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
}
