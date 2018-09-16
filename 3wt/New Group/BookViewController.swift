//
//  BookViewController.swift
//  3wt
//
//  Created by Seth Merritt on 3/7/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import UIKit
import FirebaseAuth
import SearchTextField

class BookViewController: UIViewController {

	var business = true
	var luxury = true
	var bookNow = true
	var passengerCount = 1
	var departure = ""
	var destination = ""
	
	lazy var logoImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = #imageLiteral(resourceName: "wt_logo")
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill	
		return imageView
	}()
	
	let businessSwitch: UISwitch = {
		let toggle = UISwitch(frame: CGRect(x: 150, y: 300, width: 0, height: 0))
		toggle.isOn = true
        toggle.onTintColor = wtBlue
        toggle.tintColor = wtDark
		toggle.setOn(true, animated: false)
		toggle.translatesAutoresizingMaskIntoConstraints = false
		toggle.addTarget(self, action: #selector(setBusiness), for: .valueChanged)
		return toggle
	}()
	
	let luxurySwitch: UISwitch = {
		let toggle = UISwitch(frame: CGRect(x: 150, y: 300, width: 0, height: 0))
		toggle.isOn = true
        toggle.onTintColor = wtBlue
        toggle.tintColor = wtDark
		toggle.setOn(true, animated: false)
		toggle.translatesAutoresizingMaskIntoConstraints = false
		toggle.addTarget(self, action: #selector(setLuxuary), for: .valueChanged)
		return toggle
	}()
	
	let bookNowSwitch: UISwitch = {
		let toggle = UISwitch(frame: CGRect(x: 150, y: 300, width: 0, height: 0))
		toggle.isOn = true
        toggle.onTintColor = wtBlue
        toggle.tintColor = wtDark
		toggle.setOn(true, animated: false)
		toggle.translatesAutoresizingMaskIntoConstraints = false
		toggle.addTarget(self, action: #selector(setBookNow), for: .valueChanged)
		return toggle
	}()
	
	let departureTextField: SearchTextField = {
		let sf = SearchTextField()
		sf.placeholder = "Departure Location"
		sf.layer.borderWidth = 1
        sf.layer.cornerRadius = 5
        sf.layer.borderColor = wtDark.cgColor
        sf.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
		sf.inlineMode = true
		return sf
	}()
	
	let destinationTextField: SearchTextField = {
		let sf = SearchTextField()
		sf.placeholder = "Destnation Location"
		sf.layer.borderWidth = 1
        sf.layer.cornerRadius = 5
        sf.layer.borderColor = wtDark.cgColor
        sf.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
		sf.inlineMode = true
		return sf
	}()
	
	let businessTitle: UILabel = {
		let label = UILabel()
		label.text = "Business"
        label.textColor = wtDark
		label.textAlignment = .center
		label.font = UIFont.boldSystemFont(ofSize: 16)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let pleasureTitle: UILabel = {
		let label = UILabel()
		label.text = "Pleasure"
        label.textColor = wtDark
		label.textAlignment = .center
		label.font = UIFont.boldSystemFont(ofSize: 16)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let nowTitle: UILabel = {
		let label = UILabel()
		label.text = "Leave Soon"
        label.textColor = wtDark
		label.textAlignment = .center
		label.font = UIFont.boldSystemFont(ofSize: 16)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let laterTitle: UILabel = {
		let label = UILabel()
		label.text = "Leave Later"
        label.textColor = wtDark
		label.textAlignment = .center
		label.font = UIFont.boldSystemFont(ofSize: 16)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let luxuryTitle: UILabel = {
		let label = UILabel()
		label.text = "Luxury"
        label.textColor = wtDark
		label.textAlignment = .center
		label.font = UIFont.boldSystemFont(ofSize: 16)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let adventureTitle: UILabel = {
		let label = UILabel()
		label.text = "Adventure"
        label.textColor = wtDark
		label.textAlignment = .center
		label.font = UIFont.boldSystemFont(ofSize: 16)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	var submitButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("REQUEST FLIGHTS", for: .normal)
		button.backgroundColor = wtFlat
		button.setTitleColor(.white, for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
		button.layer.cornerRadius = 5
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
		return button
	}()
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .white
        checkIfUserIsLoggedIn()

		
    }

   
	func setupInputs() {
		view.addSubview(businessSwitch)
		view.addSubview(luxurySwitch)
		view.addSubview(bookNowSwitch)
		view.addSubview(departureTextField)
		view.addSubview(destinationTextField)
		view.addSubview(submitButton)
		view.addSubview(logoImageView)
		
		logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
		logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		logoImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
		logoImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        departureTextField.anchor(logoImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 50)
		
        destinationTextField.anchor(departureTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 50)
        
		
		businessSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -2).isActive = true
		businessSwitch.centerYAnchor.constraint(equalTo: destinationTextField.bottomAnchor, constant: 35).isActive = true

		luxurySwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -2).isActive = true
		luxurySwitch.topAnchor.constraint(equalTo: businessSwitch.bottomAnchor, constant: 30).isActive = true
		
		bookNowSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -2).isActive = true
		bookNowSwitch.topAnchor.constraint(equalTo: luxurySwitch.bottomAnchor, constant: 30).isActive = true

        submitButton.anchor(bookNowSwitch.bottomAnchor, left: departureTextField.leftAnchor, bottom: nil, right: departureTextField.rightAnchor, topConstant: 30, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
		
		handleAutoComplete()
		
	}
	
	func setupLabels() {

		view.addSubview(nowTitle)
		view.addSubview(laterTitle)
		view.addSubview(luxuryTitle)
		view.addSubview(adventureTitle)
		view.addSubview(businessTitle)
		view.addSubview(pleasureTitle)
        
        pleasureTitle.anchor(businessSwitch.topAnchor, left: nil, bottom: nil, right: businessSwitch.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 15, widthConstant: 100, heightConstant: 20)

		
		businessTitle.topAnchor.constraint(equalTo: businessSwitch.topAnchor).isActive = true
		businessTitle.leftAnchor.constraint(equalTo: businessSwitch.rightAnchor, constant: 15).isActive = true
		businessTitle.widthAnchor.constraint(equalToConstant: 100).isActive = true
		businessTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
		
		adventureTitle.topAnchor.constraint(equalTo: luxurySwitch.topAnchor).isActive = true
		adventureTitle.rightAnchor.constraint(equalTo: luxurySwitch.leftAnchor, constant: -15).isActive = true
		adventureTitle.widthAnchor.constraint(equalToConstant: 100).isActive = true
		adventureTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true

		luxuryTitle.topAnchor.constraint(equalTo: luxurySwitch.topAnchor).isActive = true
		luxuryTitle.leftAnchor.constraint(equalTo: luxurySwitch.rightAnchor, constant: 15).isActive = true
		luxuryTitle.widthAnchor.constraint(equalToConstant: 100).isActive = true
		luxuryTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
		
		laterTitle.topAnchor.constraint(equalTo: bookNowSwitch.topAnchor).isActive = true
		laterTitle.rightAnchor.constraint(equalTo: bookNowSwitch.leftAnchor, constant: -15).isActive = true
		laterTitle.widthAnchor.constraint(equalToConstant: 100).isActive = true
		laterTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
		
		nowTitle.topAnchor.constraint(equalTo: bookNowSwitch.topAnchor).isActive = true
		nowTitle.leftAnchor.constraint(equalTo: bookNowSwitch.rightAnchor, constant: 15).isActive = true
		nowTitle.widthAnchor.constraint(equalToConstant: 100).isActive = true
		nowTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true

	}
	
	@objc func setBusiness() {
		business = !business
	}
	
	@objc func setLuxuary() {
		luxury = !luxury
	}
	
	@objc func setBookNow() {
		bookNow = !bookNow
	}
	
	

}
