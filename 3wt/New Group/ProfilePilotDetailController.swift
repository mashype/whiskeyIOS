//
//  ProfilePilotDetailController.swift
//  3wt
//
//  Created by Seth Merritt on 8/25/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import LBTAComponents
import Firebase

class ProfilePilotDetailController: UIViewController {
    
    var selectedPilot: Pilot? {
        didSet {
            licenseNumberLabel.text = selectedPilot?.licenseNumber
            typeLabel.text = selectedPilot?.licenseType
            homeLabel.text = selectedPilot?.homeAirport
            hoursLabel.text = selectedPilot?.flightHours
        }
    }
    
    let licenseTitle: UILabel = {
        let label = UILabel()
        label.text = "License Number"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let licenseNumberLabel: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 5
        tf.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        tf.placeholder = "12345"
        tf.backgroundColor = .white
        return tf
    }()
    
    let typeTitle: UILabel = {
        let label = UILabel()
        label.text = "License Type"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let typeLabel: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 5
        tf.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        tf.placeholder = "Private IFR"
        tf.backgroundColor = .white
        return tf
    }()
    
    let homeTitle: UILabel = {
        let label = UILabel()
        label.text = "Home Airport"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let homeLabel: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 5
        tf.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        tf.placeholder = "Home airport"
        tf.backgroundColor = .white
        return tf
    }()
    
    let hoursTitle: UILabel = {
        let label = UILabel()
        label.text = "Flight Hours"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let hoursLabel: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 5
        tf.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        tf.placeholder = "Flight hours"
        tf.backgroundColor = .white
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        observeData()
        setupNavigationItems()
        setupLabels()
    }
    
    func setupNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Update", style: .plain, target: self, action: #selector(updatePilotDetail))
        navigationItem.title = "Pilot Detail"
    }

    
    func setupLabels() {
        
        view.addSubview(licenseTitle)
        view.addSubview(licenseNumberLabel)
        view.addSubview(typeTitle)
        view.addSubview(typeLabel)
        view.addSubview(homeTitle)
        view.addSubview(homeLabel)
        view.addSubview(hoursTitle)
        view.addSubview(hoursLabel)
        
        licenseTitle.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 80, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 20)
        
        licenseNumberLabel.anchor(licenseTitle.bottomAnchor, left: licenseTitle.leftAnchor, bottom: nil, right: licenseTitle.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        
        typeTitle.anchor(licenseNumberLabel.bottomAnchor, left: licenseTitle.leftAnchor, bottom: nil, right: licenseTitle.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        typeLabel.anchor(typeTitle.bottomAnchor, left: licenseTitle.leftAnchor, bottom: nil, right: licenseTitle.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        
        homeTitle.anchor(typeLabel.bottomAnchor, left: licenseTitle.leftAnchor, bottom: nil, right: licenseTitle.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        homeLabel.anchor(homeTitle.bottomAnchor, left: licenseTitle.leftAnchor, bottom: nil, right: licenseTitle.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        
        hoursTitle.anchor(homeLabel.bottomAnchor, left: licenseTitle.leftAnchor, bottom: nil, right: licenseTitle.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        hoursLabel.anchor(hoursTitle.bottomAnchor, left: licenseTitle.leftAnchor, bottom: nil, right: licenseTitle.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        
    }
    
    @objc func observeData() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let pilotRef = db.collection("pilots").document(uid)
        //if there is a pilot document, it will update the fields. Otherwise they will stay blank.
        
        
        pilotRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.selectedPilot = Pilot(dictionary: (document.data())!)
                print("Document data: \(document.data())")
            } else {
                print("Document does not exist")
            }
        }
        
        
    }
    
    //sends the new data to Firestore for backend update and dismisses the VC.
    
    @objc func updatePilotDetail() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userRef = db.collection("users").document(uid).collection("qualifications").document(uid)
        let qualificationsRef = db.collection("pilots").document(uid)
        
        guard let licenseNumber = licenseNumberLabel.text, let licenseType = typeLabel.text, let flightHours = hoursLabel.text, let homeAirport = homeLabel.text else { return }
        
        let newPilotData = Pilot(uid: uid, requestorImageURL: wtUser.profileImageURL, licenseNumber: licenseNumber, licenseType: licenseType, homeAirport: homeAirport, flightHours: flightHours, timeStamp: Date())
        
        userRef.setData(newPilotData.dictionary)
        qualificationsRef.setData(newPilotData.dictionary)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

