//
//  AppDelegate.swift
//  3wt
//
//  Created by Seth Merritt on 3/7/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		FirebaseApp.configure()
        
        //grabbing the local airport file and appending to my array of airports.
        do {
            let path = Bundle.main.path(forResource: "airports", ofType: "json")
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: path!))
            
            do {
                let airportJSON = try JSONDecoder().decode([Airport].self, from: jsonData)
                for airport in airportJSON {
                    if airport.country == "United States" {
                        airportDictionary.append(airport)
                        airportArray.append(airport.name!)
                    }
                }
            } catch let error{
                print("TRYING TO DECORD AIRPORT JSON", error.localizedDescription)
            }
        } catch let error {
            print("TRYING TO FIND THE AIRPORT FILE", error.localizedDescription)
        }
        
        
       
		
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.makeKeyAndVisible()
		window?.rootViewController = CustomTabBarController()
		self.window?.tintColor = wtDark
		return true
	}

	func applicationWillResignActive(_ application: UIApplication) {
	}

	func applicationDidEnterBackground(_ application: UIApplication) {

	}

	func applicationWillEnterForeground(_ application: UIApplication) {
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
	}

	func applicationWillTerminate(_ application: UIApplication) {
	}
    
}

