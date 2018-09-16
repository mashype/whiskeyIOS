//
//  RequestAddController.swift
//  3wt
//
//  Created by Seth Merritt on 8/18/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import UIKit
import LBTAComponents
import Firebase
import FirebaseAuth
import SearchTextField

class RequestAddController: UIViewController {
    
    // Create a DatePicker
    var endDatePicker = UIDatePicker()
    
    var postButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("POST REQUEST", for: .normal)
        button.backgroundColor = wtDark
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addRequestToDatabase), for: .touchUpInside)
        return button
    }()
    
    let typeTitle: UILabel = {
        let label = UILabel()
        label.text = "Type of flight"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let typeField: SearchTextField = {
        let tf = SearchTextField()
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 5
        tf.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        tf.inlineMode = true
        tf.placeholder = "Cross Country, Local, Training, etc."
        return tf
    }()
    
    let locationTitle: UILabel = {
        let label = UILabel()
        label.text = "Primry location"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let locationField: SearchTextField = {
        let tf = SearchTextField()
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 5
        tf.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        tf.inlineMode = true
        tf.placeholder = "Enter the airport name"
        return tf
    }()
    
    let planeTitle: UILabel = {
        let label = UILabel()
        label.text = "Plane Type"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let planeField: SearchTextField = {
        let tf = SearchTextField()
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 5
        tf.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        tf.inlineMode = true
        tf.placeholder = "Cessna, Piper, Lear, etc."
        return tf
    }()
    
    let reqsTitle: UILabel = {
        let label = UILabel()
        label.text = "Requirements"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let reqsField: SearchTextField = {
        let tf = SearchTextField()
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 5
        tf.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        tf.placeholder = "Private, Commercial, etc."
        tf.inlineMode = true
        return tf
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "New Request"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        setupViews()
    }
    
    func setupViews() {
        
        view.addSubview(typeTitle)
        view.addSubview(typeField)
        view.addSubview(locationTitle)
        view.addSubview(locationField)
        view.addSubview(planeTitle)
        view.addSubview(planeField)
        view.addSubview(reqsTitle)
        view.addSubview(reqsField)
        view.addSubview(postButton)
        
        handleAutoComplete()
        
        typeTitle.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 90, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        typeField.anchor(typeTitle.bottomAnchor, left: typeTitle.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 50)
        
        locationTitle.anchor(typeField.bottomAnchor, left: typeTitle.leftAnchor, bottom: nil, right: typeTitle.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        locationField.anchor(locationTitle.bottomAnchor, left: typeTitle.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 50)
        
        planeTitle.anchor(locationField.bottomAnchor, left: typeTitle.leftAnchor, bottom: nil, right: typeTitle.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        planeField.anchor(planeTitle.bottomAnchor, left: typeTitle.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 50)
        
        reqsTitle.anchor(planeField.bottomAnchor, left: typeTitle.leftAnchor, bottom: nil, right: typeTitle.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        reqsField.anchor(reqsTitle.bottomAnchor, left: typeTitle.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 50)
        
        postButton.anchor(reqsField.bottomAnchor, left: typeTitle.leftAnchor, bottom: nil, right: typeTitle.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        
    }
    
    
    @objc func addRequestToDatabase() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let flightType = typeField.text, let requirements = reqsField.text, let planeType = planeField.text, let location = locationField.text else { return }
        
//        let requestRef = db.collection("requests")
        let userRef = db.collection("users").document(uid).collection("requests")
        
        let newRequest = Request(requestID: "TBD", requestorID: uid, requestorImageURL: wtUser.profileImageURL, flightType: flightType, requirements: requirements, planeType: planeType, location: location, timeStamp: Date())
        
//        //adds the request up to Firebase.
//        requestRef.addDocument(data: newRequest.dictionary) { (error) in
//            if let error = error {
//                print(error)
//            } else {
//                //adds a duplicate of the request to the user record.
//                print("request has been added")
//                userRef.addDocument(data: newRequest.dictionary, completion: { (error) in
//                    if let error = error {
//                        print(error)
//                    } else {
//                        print("request now added to the user")
//                        self.dismiss(animated: true, completion: nil)
//                    }
//                })
//
//            }
//        }
        
        //adding the request to Firestore.
        var requestRef: DocumentReference? = nil
        requestRef = db.collection("requests").addDocument(data: newRequest.dictionary) { (error) in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("did I load a request")
                //once the request is loaded, update the record to add the ID for sharing purposes.
                let newRequestRef = db.collection("requests").document(requestRef!.documentID)
                newRequestRef.updateData([ "requestID" : requestRef!.documentID ])
                //then create a duplicate into the users record.
                userRef.addDocument(data: newRequest.dictionary, completion: { (error) in
                    if let error = error {
                        print(error)
                    } else {
                        print("request now added to the user")
                        self.dismiss(animated: true, completion: nil)
                    }
                })
                print("Document added with ID: \(requestRef!.documentID)")
            }
        }
        
    }
    
    
    func handleAutoComplete() {
        reqsField.filterStrings(licenseArray)
        planeField.filterStrings(planeTypeArray)
        typeField.filterStrings(flightTypeArray)
        locationField.filterStrings(airportArray)
    }

    
}
