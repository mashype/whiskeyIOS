//
//  ConfirmationController.swift
//  3wt
//
//  Created by Seth Merritt on 3/10/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import UIKit

class ConfirmationController: UIViewController {
	
	let thanksTitle: UILabel = {
		let label = UILabel()
		label.text = "Thank You"
		label.textAlignment = .center
		label.font = UIFont.boldSystemFont(ofSize: 20)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
    
    let thanksDetail: UITextView = {
        let tv = UITextView()
        tv.text = "Thank you for requesting a flight on 3 Whiskey Tango. We will review all of our available pilots and send you our most qualified candidates within 24 hours. In the meantime, plase share our service with your friends and earn a free flight."
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
		
		view.addSubview(thanksTitle)
        view.addSubview(thanksDetail)
		
		thanksTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		thanksTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
		thanksTitle.widthAnchor.constraint(equalToConstant: 200).isActive = true
		thanksTitle.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        thanksDetail.anchor(thanksTitle.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 30, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 0)
	}
	
}



