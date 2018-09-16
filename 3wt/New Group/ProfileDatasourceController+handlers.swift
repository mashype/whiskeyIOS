//
//  ProfileDatasourceController+handlers.swift
//  3wt
//
//  Created by Seth Merritt on 8/25/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import LBTAComponents


extension ProfileDatasourceController {
    
    func setupNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Update", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.title = "Account Profile"
//
//        NotificationCenter.default.addObserver(self, selector: #selector(createBooking(not:)), name: NSNotification.Name(rawValue: "notifyOpenBooking"), object: nil)
    }
    
    func showPilotProfileDetail() {
        let pilotController = ProfilePilotDetailController()
        let navController = UINavigationController(rootViewController: pilotController)
        present(navController, animated: true, completion: nil)
    }
    
    
    
}
