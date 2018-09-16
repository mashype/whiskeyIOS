//
//  Booking.swift
//  3wt
//
//  Created by Seth Merritt on 3/7/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import Foundation

protocol DocumentSerializable  {
	init?(dictionary:[String:Any])
}

struct Booking {
	var business: Bool
	var luxury: Bool
	var bookNow: Bool
	var passengerCount: Int
	var departure: String
	var destination: String
	var requestDate: Date
	
	var dictionary: [String:Any]? {
		return [
			"business" : business,
			"luxury" : luxury,
			"bookNow" : bookNow,
			"passengerCount" : passengerCount,
			"departure" : departure,
			"destination" : destination,
			"requestDate" : requestDate,
		]
	}
}

extension Booking : DocumentSerializable {
	init?(dictionary: [String : Any]) {
		guard let business = dictionary["business"] as? Bool,
		let luxury = dictionary["luxury"] as? Bool,
		let bookNow = dictionary["bookNow"] as? Bool,
		let passengerCount = dictionary["passengerCount"] as? Int,
		let departure = dictionary["departure"] as? String,
		let destination = dictionary["destination"] as? String,
		let requestDate = dictionary["requestDate"] as? Date else { return nil }

		self.init(business: business, luxury: luxury, bookNow: bookNow, passengerCount: passengerCount, departure: departure, destination: destination, requestDate: requestDate)
		
	}
}
