//
//  RequestListCell.swift
//  3wt
//
//  Created by Seth Merritt on 8/18/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import LBTAComponents


class RequestListHeader: DatasourceCell {
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "LOOKING FOR COPILOTS"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var newRequestButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("POST FLIGHT", for: .normal)
        button.layer.borderWidth = 0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(notifyNewRequest), for: .touchUpInside)
        button.backgroundColor = wtGreen
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        backgroundColor = wtBlue
        
        addSubview(headerLabel)
        addSubview(newRequestButton)
        
        headerLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        newRequestButton.anchor(topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 5, rightConstant: 5, widthConstant: 120, heightConstant: 0)
    }
    
    
    //posts a notification that the button has been pushed and will be listened for by the RequestListDatasourceController
    @objc func notifyNewRequest() {
        print("notified")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notifyNewRequest"), object: nil)
    }
}

class RequestListFooter: DatasourceCell {
    
    let footerLabel: UILabel = {
        let label = UILabel()
        label.text = "SECTION FOOTER"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = wtGreen
        
        addSubview(footerLabel)
        
        footerLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 00)
        
    }
}


class RequestListCell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet {
            //if there is a profile existing
            guard let request = datasourceItem as? Request else { return }
            departureCityLabel.text = request.location
            flightTypeLabel.text = request.flightType
            planeTypeLabel.text = request.planeType
            licenseLabel.text = request.requirements
            requestID = request.requestID!
            
            if let profileImageURL = request.requestorImageURL {
                self.profileImageview.loadImageUsingCacheWithUrlString(urlString: profileImageURL)
            }
        }
    }
    
    //MARK:- Label constants
    
    var requestID = String()
    
    let profileImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = wtLight.cgColor
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    
    
    let pilotLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let departureCityTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        label.text = "Departing:"
        return label
    }()
    
    let departureCityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let flightTypeTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        label.text = "Type:"
        return label
    }()
    
    let flightTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let planeTypeTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        label.text = "Plane Type:"
        return label
    }()
    
    let planeTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let licenseTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        label.text = "License:"
        return label
    }()
    
    let licenseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var respondButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 5
        button.layer.borderColor = wtBlue.cgColor
        button.layer.borderWidth = 1
        button.setTitle("BOOK NOW", for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 0)
        button.setTitleColor(wtBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.tintColor = wtBlue
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(notifyRequestResponse), for: .touchUpInside)
        return button
    }()

    
    override func setupViews() {
        
        super.setupViews()
        
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        
        backgroundColor = .white
        
        addSubview(departureCityTitle)
        addSubview(departureCityLabel)
        addSubview(flightTypeTitle)
        addSubview(flightTypeLabel)
        addSubview(licenseTitle)
        addSubview(licenseLabel)
        addSubview(planeTypeTitle)
        addSubview(planeTypeLabel)
        addSubview(respondButton)
        addSubview(profileImageview)
        
        profileImageview.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 30, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 60)
        
        departureCityTitle.anchor(topAnchor, left: respondButton.rightAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 80, heightConstant: 0)
        
        departureCityLabel.anchor(departureCityTitle.topAnchor, left: departureCityTitle.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 00, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        flightTypeTitle.anchor(departureCityTitle.bottomAnchor, left: departureCityTitle.leftAnchor, bottom: nil, right: departureCityTitle.rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        flightTypeLabel.anchor(flightTypeTitle.topAnchor, left: departureCityLabel.leftAnchor, bottom: nil, right: departureCityLabel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        planeTypeTitle.anchor(flightTypeTitle.bottomAnchor, left: departureCityTitle.leftAnchor, bottom: nil, right: departureCityTitle.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        planeTypeLabel.anchor(planeTypeTitle.topAnchor, left: departureCityLabel.leftAnchor, bottom: nil, right: departureCityLabel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        licenseTitle.anchor(planeTypeTitle.bottomAnchor, left: departureCityTitle.leftAnchor, bottom: nil, right: departureCityTitle.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        licenseLabel.anchor(licenseTitle.topAnchor, left: departureCityLabel.leftAnchor, bottom: nil, right: departureCityLabel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        respondButton.anchor(profileImageview.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 30)
        
    }
    
    //posts a notification that the button has been pushed and will be listened for by the RequestListDatasourceController
    @objc func notifyRequestResponse() {
        
        let userInfo = [
            "requestID" : requestID
        ]
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notifyRequestResponse"), object: nil, userInfo: userInfo)
    }
    
    
}
