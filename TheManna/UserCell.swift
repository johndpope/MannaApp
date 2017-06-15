//
//  UserCell.swift
//  TheManna
//
//  Created by Sean Zhang on 6/3/17.
//  Copyright © 2017 Sean Zhang. All rights reserved.
//

import Foundation
import UIKit
import LBTAComponents

class UserCell: DatasourceCell {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "selfie")
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override var datasourceItem: Any? {
        
        didSet {
            guard let user = datasourceItem as? User else { return }
            nameLabel.text = user.name
            usernameLabel.text = user.username
            bioTextView.text = user.bioText
            profileImageView.image = user.profileImage
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sean Zhang"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "@sean7218"
        label.textColor = UIColor(r: 130, g: 130, b: 130)
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let bioTextView: UITextView = {
        let textView = UITextView()
        textView.text = "THis is Sean Zhang"
        textView.text = "iPhone iPad iOS programming community and join us to learn Swift or Objective-C to build apps that we can do a lot of fun things"
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.backgroundColor = UIColor.clear
   
        return textView
    }()
    
    let followButton: UIButton = {
        
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.layer.borderColor = twitterBlue.cgColor
        button.layer.borderWidth = 1
        button.setTitle("Actions", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(twitterBlue, for: .normal)
        button.setImage(nil, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        
        button.titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.centerXAnchor.constraint(equalTo: button.centerXAnchor, constant: 5).isActive = true
        
        button.imageView?.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.widthAnchor.constraint(equalToConstant: 20).isActive = true
        button.imageView?.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.imageView?.rightAnchor.constraint(equalTo: (button.titleLabel?.leftAnchor)!, constant: -5).isActive = true
        
        button.addTarget(self, action: #selector(triggerPDFViewControoler), for: UIControlEvents.touchUpInside)
        
        return button
    }()
    
    func triggerPDFViewControoler()  {
        print(123)
    }
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .white
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(usernameLabel)
        addSubview(bioTextView)
        addSubview(followButton)
        
        profileImageView.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 50)
        
        nameLabel.anchor(profileImageView.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: followButton.leftAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 20)
        
        usernameLabel.anchor(nameLabel.bottomAnchor, left: profileImageView.rightAnchor, bottom: nil, right: followButton.leftAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 20)
        
        bioTextView.anchor(usernameLabel.bottomAnchor, left: usernameLabel.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 4, leftConstant: -4, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        followButton.anchor(self.topAnchor, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 12, widthConstant: 120, heightConstant: 34)
        
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
       
        
    }
    
    
}
