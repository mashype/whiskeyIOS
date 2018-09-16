//
//  CustomTabBarController.swift
//  3wt
//
//  Created by Seth Merritt on 3/7/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import SearchTextField

let db = Firestore.firestore()

var wtUser = WTUser()

let licenseArray = ["None", "Student Pilot", "Private Pilot - VFR", "Private Pilot - IFR", "Multi Engine", "Commercial" , "CFI"]
let flightTypeArray = ["Local", "Training", "Cross Country"]
let planeTypeArray = ["Cessna 172", "Cessna 182", "Piper P-28"]
var airportDictionary = [Airport]()
var airportArray = [String]()

let wtBlue = UIColor(r: 77, g: 120, b: 191)
let wtDark = UIColor(r: 13, g: 56, b: 127)
let wtLight = UIColor(r: 138, g: 182, b: 254)
let wtFlat = UIColor(r: 18, g: 79, b: 178)
let wtBright = UIColor(r: 26, g: 113, b: 254)
let wtGreen = UIColor(r: 41, g: 178, b: 169)
let wtLightGray = UIColor(r: 200, g: 200, b: 200)
let wtDarkGray = UIColor(r: 68, g: 68, b: 68)


class CustomTabBarController: UITabBarController {
	
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchUser()
    }
    
    override func viewDidLoad() {
		super.viewDidLoad()
        print("loading the tab controller")
		
        let requestViewController = UINavigationController(rootViewController: RequestListDatasourceController())
        requestViewController.tabBarItem.title = "Pilots"
        requestViewController.tabBarItem.image = #imageLiteral(resourceName: "copilot")
        
		let bookViewController = UINavigationController(rootViewController: BookViewController())
		bookViewController.tabBarItem.title = "Passengers"
		bookViewController.tabBarItem.image = #imageLiteral(resourceName: "passenger")


        let historyViewController = UINavigationController(rootViewController: HistoryDatasourceController())
        historyViewController.tabBarItem.title = "History"
        historyViewController.tabBarItem.image = #imageLiteral(resourceName: "tickets")
        
		let aboutViewController = UINavigationController(rootViewController: AboutViewController())
		aboutViewController.tabBarItem.title = "About Us"
		aboutViewController.tabBarItem.image = #imageLiteral(resourceName: "about")

		
		let profileController = UINavigationController(rootViewController: ProfileDatasourceController())
		profileController.tabBarItem.title = "Account"
		profileController.tabBarItem.image = #imageLiteral(resourceName: "account")
		
		viewControllers = [requestViewController, bookViewController, historyViewController, aboutViewController, profileController]
		
	}
	
}


