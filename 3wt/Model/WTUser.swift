//
//  WTUser.swift
//  3wt
//
//  Created by Seth Merritt on 8/17/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//


import Foundation
import FirebaseFirestore

struct WTUser {
    var email:String?
    var firstName:String?
    var lastName: String?
    var timeStamp:Date?
    var profileImageURL:String?

    
    var dictionary:[String:Any]? {
        return [
            "email":email as Any,
            "firstName":firstName as Any,
            "lastName":lastName as Any,
            "timeStamp":timeStamp as Any,
            "profileImageURL":profileImageURL as Any
        ]
    }
    
}

extension WTUser : DocumentSerializable {
    init?(dictionary: [String : Any]) {
        guard let email = dictionary["email"] as? String,
            let firstName = dictionary["firstName"] as? String,
            let lastName = dictionary["lastName"] as? String,
            let timeStamp = dictionary["timeStamp"] as? Date,
            let profileImageURL = dictionary["profileImageURL"] as? String else {return nil}
        
        self.init(email: email, firstName: firstName, lastName: lastName, timeStamp: timeStamp, profileImageURL: profileImageURL)

    }
}
