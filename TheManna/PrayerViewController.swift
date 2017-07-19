//
//  PrayerViewController.swift
//  TheManna
//
//  Created by Sean Zhang on 7/10/17.
//  Copyright © 2017 Sean Zhang. All rights reserved.
//

import Foundation
import UIKit
import AWSCognitoIdentityProvider
import AWSCognito
class PrayerViewContoller: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: === Data Member ===
    
    let startButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.setTitle("Start", for: .normal)
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let stopButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.setTitle("Stop", for: .normal)
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let doneButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.setTitle("Done", for: .normal)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let logoutButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Logout", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let topicLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Topic:"
        return label
    }()
    
    let contentTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .yellow
        return textField
    }()
    
    let feedbackTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = "Feedback from the database will show some hints and also directions"
        textField.backgroundColor = .blue
        return textField
        
    }()
    
    // MARK: === Properties ===
    
//    var pool: AWSCognitoIdentityUserPool?
//    var provier: AWSCognitoIdentityProvider?
//    var user: AWSCognitoIdentityUser?
    
    // MARK: === Operation ===
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(PrayerCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView?.backgroundColor = .white
        setupNavigationBar()
//        pool = AWSCognitoIdentityUserPool(forKey: "UserPool")
//        user = pool?.currentUser()
        
    }
    
    func setupNavigationBar(){
        let logoutBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(slideOut))
        self.navigationItem.leftBarButtonItem = logoutBarButtonItem
    }
    
    let blackView = UIView()
    
    func slideOut()  {
      
        if let window = UIApplication.shared.keyWindow {
              print("Sliding Out")
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, animations: {
                self.blackView.alpha = 1
            })
            
            let menuView = UIView()
            menuView.frame = CGRect(x: 0, y: 0, width: (self.view.frame.width)/2, height: self.view.frame.height)
            menuView.backgroundColor = .blue

        }

        
    }
    
    func handleDismiss(){
        UIView.animate(withDuration: 0.5) { 
            self.blackView.alpha = 0
        }
    }
    
    func logout() {
        
        print("Successfully logout user: ")
        
        self.collectionView?.reloadData()
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 400)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // MARK: END
    
}


class PrayerCell: UICollectionViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "TEST"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.blue
        return label
    }()
    
    var scriptureTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = "For all have sinned and fall short of the glory of God, but the righteous of God has been given to those who believe in him and shall never parish"
        textField.backgroundColor = .yellow
        return textField
    }()
    
    var illustrationImageView: UIImageView = {
       let imageView = UIImageView(image: #imageLiteral(resourceName: "selfie"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    var iconImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "rwenderlich"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.layer.cornerRadius = 40
        imageView.layer.masksToBounds = true
        return imageView
        
    }()
    
    var addButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("REP", for: .normal)
        button.backgroundColor = .brown
        button.addTarget(self, action: #selector(REP), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func REP() {
        print("Button Being Pushed")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.backgroundColor = .yellow
        addSubview(illustrationImageView)
        addSubview(illustrationImageView)
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(scriptureTextField)
        addSubview(addButton)
        
        
        addConstraintsWithFormat("H:|-10-[v0]-10-|", views: illustrationImageView)
        addConstraintsWithFormat("V:|-10-[v0]-100-|", views: illustrationImageView)
        
        addConstraintsWithFormat("H:|-10-[v0(80)]", views: iconImageView)
        addConstraintsWithFormat("V:[v0]-5-[v1]-5-|", views: illustrationImageView, iconImageView)
        
        addConstraintsWithFormat("H:[v0(50)]-10-|", views: addButton)
        addConstraintsWithFormat("V:|-10-[v0(50)]", views: addButton)
        
        titleLabel.topAnchor.constraint(equalTo: illustrationImageView.bottomAnchor, constant: 5).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 5).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        
        scriptureTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        scriptureTextField.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 5).isActive = true
        scriptureTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        scriptureTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        
    }
}
