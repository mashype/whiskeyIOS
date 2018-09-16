//
//  Pilot.swift
//  3wt
//
//  Created by Seth Merritt on 8/26/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import Foundation

struct Pilot {
    
    var uid: String?
    var requestorImageURL: String?
    var licenseNumber: String?
    var licenseType: String?
    var homeAirport: String?
    var flightHours: String?
    var timeStamp: Date?
    
    var dictionary:[String:Any] {
        return [
            "uid": uid as Any,
            "requestorImageURL": requestorImageURL as Any,
            "licenseNumber": licenseNumber as Any,
            "licenseType": licenseType as Any,
            "homeAirport": homeAirport as Any,
            "flightHours": flightHours as Any,
            "timeStamp": timeStamp as Any
        ]
    }
}

extension Pilot: DocumentSerializable {
    
    init?(dictionary: [String:Any]) {
        guard let uid = dictionary["uid"] as? String,
            let requestorImageURL = dictionary["requestorImageURL"] as? String,
            let licenseNumber = dictionary["licenseNumber"] as? String,
            let licenseType = dictionary["licenseType"] as? String,
            let homeAirport = dictionary["homeAirport"] as? String,
            let flightHours = dictionary["flightHours"] as? String,
            let timeStamp = dictionary["timeStamp"] as? Date else { return nil }
        
        self.init(uid: uid, requestorImageURL: requestorImageURL, licenseNumber: licenseNumber, licenseType: licenseType, homeAirport: homeAirport, flightHours: flightHours, timeStamp: timeStamp)
        
    }
}
