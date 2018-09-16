//
//  RequestDetailController.swift
//  3wt
//
//  Created by Seth Merritt on 8/26/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import LBTAComponents

class RequestDetailController: UIViewController {
    
    var selectedRequest = Request()
    
    var selectedPilot: Pilot? {
        didSet {
            licenseLabel.text = selectedPilot?.licenseType
            homeLabel.text = selectedPilot?.homeAirport
            hoursLabel.text = selectedPilot?.flightHours
        }
    }
    
    var selectedUser: WTUser? {
        didSet {
            pilotNameLabel.text = selectedUser?.firstName
            departureLabel.text = selectedRequest.location
            navigationItem.title = selectedUser?.firstName
            
            if let profileImageURL = selectedRequest.requestorImageURL {
                self.profileImageview.loadImageUsingCacheWithUrlString(urlString: profileImageURL)
            }
        }
    }
    
    let pilotNameTitle: UILabel = {
        let label = UILabel()
        label.text = "Name:"
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let pilotNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let departureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let departureTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Departure Location:"
        return label
    }()
    
    let licenseTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Current License:"
        return label
    }()
    
    let licenseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let homeTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Home Airport:"
        return label
    }()
    
    let homeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let hoursTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Flight Hours:"
        return label
    }()
    
    let hoursLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let profileImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 90
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = wtLight.cgColor
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var respondButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = wtDark
        button.setTitle("COPILOT", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(displayConfirmationAlert), for: .touchUpInside)
        return button
    }()
    
    lazy var button2: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = wtFlat
        button.setTitle("MESSAGE", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        //button.addTarget(self, action: #selector(presentResposeController(requestID:selectedRequest.requestID!)), for: .touchUpInside)
        return button
    }()
    
    lazy var button3: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = wtBlue
        button.setTitle("FOLLOW", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        //button.addTarget(self, action: #selector(presentResposeController(requestID:selectedRequest.requestID!)), for: .touchUpInside)
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        getUserDetail()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBarItems()
        setupButtons()
        setupLabels()
    }
    
    func setupNavBarItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.title = "NO PILOT"
    }
    
    func getUserDetail() {
        guard let userID = selectedRequest.requestorID else { return }
        let userRef = db.collection("users").document(userID)
        let pilotRef = db.collection("pilots").document(userID)
        
        pilotRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.selectedPilot = Pilot(dictionary: (document.data())!)
            } else {
                print("Document does not exist")
            }
        }
        
        userRef.getDocument { (document, error) in
            if error != nil {
                print(error as Any)
            } else {
                self.selectedUser = WTUser(dictionary: (document?.data())!)!
            }
        }
    }

    
    func setupButtons() {
        
        view.addSubview(profileImageview)
        view.addSubview(respondButton)
        view.addSubview(button2)
        view.addSubview(button3)
        

        
        let buttonWidth = (view.bounds.width)/3
        
        profileImageview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageview.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        profileImageview.widthAnchor.constraint(equalToConstant: 180).isActive = true
        profileImageview.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        respondButton.anchor(profileImageview.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 30, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: buttonWidth, heightConstant: 50)
        
        button2.anchor(respondButton.topAnchor, left: respondButton.rightAnchor, bottom: respondButton.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: buttonWidth, heightConstant: 0)
        
        button3.anchor(respondButton.topAnchor, left: button2.rightAnchor, bottom: respondButton.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: buttonWidth, heightConstant: 0)
        
 
    }
    
    func setupLabels() {
        
        view.addSubview(pilotNameTitle)
        view.addSubview(pilotNameLabel)
        view.addSubview(departureTitle)
        view.addSubview(departureLabel)
        view.addSubview(licenseTitle)
        view.addSubview(licenseLabel)
        view.addSubview(homeTitle)
        view.addSubview(homeLabel)
        view.addSubview(hoursTitle)
        view.addSubview(hoursLabel)
        
        pilotNameTitle.anchor(respondButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 30, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 180, heightConstant: 20)
        
        pilotNameLabel.anchor(pilotNameTitle.topAnchor, left: pilotNameTitle.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 20)
        
        departureTitle.anchor(pilotNameTitle.bottomAnchor, left: pilotNameTitle.leftAnchor, bottom: nil, right: pilotNameTitle.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        departureLabel.anchor(departureTitle.topAnchor, left: pilotNameTitle.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 20)
        
        licenseTitle.anchor(departureTitle.bottomAnchor, left: pilotNameTitle.leftAnchor, bottom: nil, right: pilotNameTitle.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        licenseLabel.anchor(licenseTitle.topAnchor, left: pilotNameTitle.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 20)
        
        homeTitle.anchor(licenseTitle.bottomAnchor, left: pilotNameTitle.leftAnchor, bottom: nil, right: pilotNameTitle.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        homeLabel.anchor(homeTitle.topAnchor, left: pilotNameTitle.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 20)
        
        hoursTitle.anchor(homeTitle.bottomAnchor, left: pilotNameTitle.leftAnchor, bottom: nil, right: pilotNameTitle.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        hoursLabel.anchor(hoursTitle.topAnchor, left: pilotNameTitle.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 20)
        
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
    
    
    func presentResposeController(requestID: String) {
        let requestResponseViewController = RequestResponseViewController()
        let navController = UINavigationController(rootViewController: requestResponseViewController)
        requestResponseViewController.currentRequestID = requestID
        present(navController, animated: true, completion: nil)
    }
    
}
