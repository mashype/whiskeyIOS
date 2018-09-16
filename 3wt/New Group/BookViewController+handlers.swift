//
//  BookViewController+handlers.swift
//  3wt
//
//  Created by Seth Merritt on 9/5/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//


import UIKit
import FirebaseAuth
import SearchTextField

extension BookViewController {
    
    @objc func checkIfUserIsLoggedIn() {
        //user is not logged in.
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            setupNavigationBarItems()
            setupInputs()
            setupLabels()
            
        }
    }
    
    func setupNavigationBarItems() {
        setupRightNavItems()
        //comment this out until I clean up the functions to have the back button
        setupRemainingNavItems()
    }
    
    private func setupRightNavItems() {
        
        let infoButton = UIButton(type: .system)
        infoButton.setImage(#imageLiteral(resourceName: "info"), for: .normal)
        infoButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: infoButton)
        
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
    }
    
    private func setupRemainingNavItems() {
        
        //just removes the shadow line from under the nav bar and replaces it with a lighter line
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        let navBarSeperatorView = UIView()
        navBarSeperatorView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        view.addSubview(navBarSeperatorView)
        navBarSeperatorView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0.5)
    }
    
    
    func handleAutoComplete() {
        departureTextField.filterStrings(airportArray)
        destinationTextField.filterStrings(airportArray)
    }
    
    @objc func handleSubmit() {
        
        let bookingRef = db.collection("bookings")
        let newBooking = Booking(business: business, luxury: luxury, bookNow: bookNow, passengerCount: passengerCount, departure: departureTextField.text!, destination: destinationTextField.text!, requestDate: Date())
        
        bookingRef.addDocument(data: newBooking.dictionary!) { //add the data to Firestore
            error in
            
            if let error = error {
                print(error)
            } else {
                print("Booking Added")
                self.presentConfirmation()
            }
        }
    }
    
    func presentConfirmation() {
        let confirmationController = ConfirmationController()
        let navController = UINavigationController(rootViewController: confirmationController)
        self.present(navController, animated: true, completion: nil)
    }

    
}
