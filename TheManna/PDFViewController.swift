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
import LBTAComponents

class PDFViewController: UIViewController {
    
    var imageDownloaded: UIImage?
    var imageData: Data?
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        
        return imageView
        
    }()
    
    var webView: UIWebView = {
        let webView = UIWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        return webView
    }()
    
    override func viewDidLoad() {
        let parse = ParseServerController()
        imageData = parse.downloadImageFile()
        setupViews()
    }
    
    
    func setupViews (){
        
        if let imageData = imageData {
            
            webView.load(imageData, mimeType: "image/gif", textEncodingName: "UTF-8", baseURL: NSURL() as URL)
            webView.scalesPageToFit = true
            webView.contentMode = UIViewContentMode.scaleAspectFit
        }
       
        
        //self.view.addSubview(imageView)
        self.view.addSubview(webView)

        //imageView.anchor(self.view.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        webView.fillSuperview()
        
    }
}
