//
//  ProfileSummaryCell.swift
//  3wt
//
//  Created by Seth Merritt on 8/25/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import LBTAComponents

class ProfileSummaryCell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet {
            guard let wtUser = datasourceItem as? WTUser else { return }
            nameLabel.text = wtUser.firstName
            lastNameLabel.text = wtUser.lastName
            
            if let profileImageURL = wtUser.profileImageURL {
                self.profileImageview.loadImageUsingCacheWithUrlString(urlString: profileImageURL)
            }
        }
    }
    
    let nameTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "FIRST NAME:"
        return label
    }()
    
    let nameLabel: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 5
        tf.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        return tf
    }()
    
    let lastNameTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "LAST NAME:"
        return label
    }()
    
    let lastNameLabel: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 5
        tf.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        return tf
    }()
    
    let profileImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 60
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = wtDark.cgColor
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        //imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectedProfileImageview)))
        //imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    override func setupViews() {
        
        super.setupViews()

        addSubview(nameTitle)
        addSubview(nameLabel)
        addSubview(lastNameTitle)
        addSubview(lastNameLabel)
        addSubview(profileImageview)
        
        profileImageview.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileImageview.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        profileImageview.widthAnchor.constraint(equalToConstant: 120).isActive = true
        profileImageview.heightAnchor.constraint(equalToConstant: 120).isActive = true

        nameTitle.anchor(profileImageview.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 20, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 100, heightConstant: 20)
        
        nameLabel.anchor(nameTitle.topAnchor, left: nameTitle.rightAnchor, bottom: nil, right: rightAnchor, topConstant: -12, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 40)
        
        lastNameTitle.anchor(nameTitle.bottomAnchor, left: nameTitle.leftAnchor, bottom: nil, right: nameTitle.rightAnchor, topConstant: 30, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        lastNameLabel.anchor(lastNameTitle.topAnchor, left: nameTitle.rightAnchor, bottom: nil, right: rightAnchor, topConstant: -12, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 40)
    }
}


class ProfileComponentCell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet {
            titleLabel.text = datasourceItem as? String
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let arrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "right_arrow")
        
        return imageView
    }()
    
    
    override func setupViews() {
        super.setupViews()
        addSubview(titleLabel)
        addSubview(arrowImage)
        
        titleLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        arrowImage.anchor(topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 15, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 20, heightConstant: 20)
    }
}

class ProfileSummaryHeader: DatasourceCell {
    
    let profileLabel: UILabel = {
        let label = UILabel()
        label.text = "USER PROFILE"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = wtBlue
        addSubview(profileLabel)
        
        profileLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}

class ProfileSummaryFooter: DatasourceCell {
    
    let profileLabel: UILabel = {
        let label = UILabel()
        label.text = "Edit"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = wtGreen
        addSubview(profileLabel)
        
        profileLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}

class ProfileComponentHeader: DatasourceCell {
    
    let profileLabel: UILabel = {
        let label = UILabel()
        label.text = "PROFILE DETAIL"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = wtBlue
        addSubview(profileLabel)
        
        profileLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
}
