//
//  Request.swift
//  3wt
//
//  Created by Seth Merritt on 8/18/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//


//Requests are the requests from other pilots looking to share hours.

import Foundation

struct Request {
    
    var requestID: String?
    var requestorID: String?
    var requestorImageURL: String?
    var flightType: String?
    var requirements: String?
    var planeType: String?
    var location: String?
    var timeStamp: Date?
    
    var dictionary:[String:Any] {
        return [
            "requestID": requestID as Any,
            "requestorID": requestorID as Any,
            "requestorImageURL": requestorImageURL as Any,
            "flightType": flightType as Any,
            "requirements": requirements as Any,
            "planeType": planeType as Any,
            "location": location as Any,
            "timeStamp": timeStamp as Any
        ]
    }
}
    
extension Request: DocumentSerializable {
    init?(dictionary: [String:Any]) {
        guard let requestID = dictionary["requestID"] as? String,
        let requestorID = dictionary["requestorID"] as? String,
        let requestorImageURL = dictionary["requestorImageURL"] as? String,
        let flightType = dictionary["flightType"] as? String,
        let requirements = dictionary["requirements"] as? String,
        let planeType = dictionary["planeType"] as? String,
        let location = dictionary["location"] as? String,
        let timeStamp = dictionary["timeStamp"] as? Date else { return nil }
        
        self.init(requestID: requestID, requestorID: requestorID, requestorImageURL: requestorImageURL, flightType: flightType, requirements: requirements, planeType: planeType, location: location, timeStamp: timeStamp)
        
        
    }
}
    




