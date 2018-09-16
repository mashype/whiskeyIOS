//
//  RequestResponseViewController.swift
//  3wt
//
//  Created by Seth Merritt on 8/31/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import LBTAComponents
import Alamofire

class RequestResponseViewController: UIViewController {
    
    var currentRequestID = String()
    var currentRequest = Request()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 75
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        //imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectedProfileImageview)))
        //imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let planeTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .right
        label.text = "PLANE TYPE"
        return label
    }()
    
    let planeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let departureTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .right
        label.text = "DEPARTURE"
        return label
    }()
    
    let departureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let flightTypeTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .right
        label.text = "FLIGHT TYPE"
        return label
    }()
    
    let flightTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let licenseTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .right
        label.text = "LICENSE"
        return label
    }()
    
    let licenseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    lazy var completeResponseButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = wtDark
        button.setTitle("REQUEST TO COPILOT", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        //button.addTarget(self, action: #selector(displayConfirmationAlert), for: .touchUpInside)
        button.addTarget(self, action: #selector(handleTextToPilot), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        fetchRequest()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
    }
    
    //grabs the expected request to populate the data
    func fetchRequest() {
        
        let requestRef = db.collection("requests").document(currentRequestID)
        
        requestRef.getDocument { (document, error) in
            if let request = document.flatMap({
                $0.data().flatMap({ (data) in
                    return Request(dictionary: data)
                })
            }) {
                self.currentRequest = request
                self.setData()
            } else {
                print("Document does not exist")
            }
        }
        
    }
    
    //sets the data for the current request.
    func setData() {
        
        planeLabel.text = currentRequest.planeType
        departureLabel.text = currentRequest.location
        flightTypeLabel.text = currentRequest.flightType
        licenseLabel.text = currentRequest.requirements
        
        if let requestorImageURL = currentRequest.requestorImageURL {
            self.profileImageView.loadImageUsingCacheWithUrlString(urlString: requestorImageURL)
        }
        
        setTitles()
        
    }
    
    func setTitles() {
        
        navigationItem.title = "Flight Details"

        view.addSubview(completeResponseButton)
        view.addSubview(profileImageView)
        view.addSubview(planeTitle)
        view.addSubview(planeLabel)
        view.addSubview(departureTitle)
        view.addSubview(departureLabel)
        view.addSubview(flightTypeLabel)
        view.addSubview(flightTypeTitle)
        view.addSubview(licenseTitle)
        view.addSubview(licenseLabel)
        

        
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        planeTitle.anchor(profileImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 30, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 150, heightConstant: 20)
        
        planeLabel.anchor(planeTitle.topAnchor, left: planeTitle.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 20)
        
        departureTitle.anchor(planeTitle.bottomAnchor, left: planeTitle.leftAnchor, bottom: nil, right: nil, topConstant: 30, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 150, heightConstant: 20)
        
        departureLabel.anchor(departureTitle.topAnchor, left: planeLabel.leftAnchor, bottom: nil, right: planeLabel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        flightTypeTitle.anchor(departureTitle.bottomAnchor, left: planeTitle.leftAnchor, bottom: nil, right: nil, topConstant: 30, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 150, heightConstant: 20)
        
        flightTypeLabel.anchor(flightTypeTitle.topAnchor, left: planeLabel.leftAnchor, bottom: nil, right: planeLabel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        licenseTitle.anchor(flightTypeTitle.bottomAnchor, left: planeTitle.leftAnchor, bottom: nil, right: nil, topConstant: 30, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 150, heightConstant: 20)
        
        licenseLabel.anchor(licenseTitle.topAnchor, left: planeLabel.leftAnchor, bottom: nil, right: planeLabel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        completeResponseButton.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 80, rightConstant: 10, widthConstant: 0, heightConstant: 50)
        
    }
    
    //MARK: Alert confirmation
    @objc func displayConfirmationAlert() {
        
        let confirmationAlert = UIAlertController(title: "Thank You", message: "Your request has been submitted", preferredStyle: .alert)
        
        let completeAction = UIAlertAction(title: "Done", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        
        confirmationAlert.addAction(completeAction)
        present(confirmationAlert, animated: true, completion: nil)
        
    }
//      old alert button
//    @objc func handleResponseSubmission() {
//        let confirmationController = RequestConfirmationController()
//        let navController = UINavigationController(rootViewController: confirmationController)
//        self.present(navController, animated: true, completion: nil)
//    }
    
    @objc func handleTextToPilot() {
        
    }
    
}
