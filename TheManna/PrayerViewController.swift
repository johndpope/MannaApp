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
    
    var pool: AWSCognitoIdentityUserPool?
    var provier: AWSCognitoIdentityProvider?
    var user: AWSCognitoIdentityUser?
    
    // MARK: === Operation ===
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(PrayerCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView?.backgroundColor = .white
        setupNavigationBar()
        pool = AWSCognitoIdentityUserPool(forKey: "UserPool")
        user = pool?.currentUser()
        
    }
    
    func setupNavigationBar(){
        let logoutBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(logout))
        self.navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
    
    func logout() {
        
        print("Successfully logout user: \(String(describing: pool?.currentUser()?.username))")
        
        self.collectionView?.reloadData()
        
        //user?.signOut()
        user?.globalSignOut()
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
        return CGSize(width: view.frame.width, height: 200)
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
        return label
    }()
    
    var scriptureTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .yellow
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.backgroundColor = .yellow
        addSubview(titleLabel)
        addSubview(scriptureTextField)
        
        addConstraintsWithFormat("H:|-16-[v0]-16-|", views: scriptureTextField)
        addConstraintsWithFormat("V:|-16-[v0]-50-|", views: scriptureTextField)
        
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
    }
}
