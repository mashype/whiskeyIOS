//
//  AboutViewController.swift
//  3wt
//
//  Created by Seth Merritt on 3/7/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    let aboutBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = wtBlue
        return view
    }()
	
    let aboutTitle: UILabel = {
        let label = UILabel()
        label.text = "ABOUT US"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let aboutDescription: UITextView = {
        let tv = UITextView()
        tv.text = "3 Whiskey Tango was the call sign of the first plane that I got my private pilot license in, and just thought the name was the coolest thing ever. As I started spending more and more time flying in empty planes, I always thought it was such a waste, and whenever I told my friends what I was doing they would beg to come with me. I then started thinking about all the people who don't have pilot friends, but would love the chance to go up in a small plane either just to do some sight seeing, or to beat the traffic of a regional trip."
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let worksBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = wtBlue
        return view
    }()
    
    let worksTitle: UILabel = {
        let label = UILabel()
        label.text = "HOW IT WORKS"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let worksDescription: UITextView = {
        let tv = UITextView()
        tv.text = "Pilots need to spend so many hours building up their flight hours to get licensed, and most of that time is spent flying back and forth in an empty airplane just to build those hours. That flying time can get lonely, so we thought what a great idea to broaden the scope of family and friends who would love to hitch a ride and share in the cost."
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(aboutBackgroundView)
        view.addSubview(aboutTitle)
        view.addSubview(aboutDescription)
        
        view.addSubview(worksBackgroundView)
        view.addSubview(worksTitle)
        view.addSubview(worksDescription)
        
        setupLabels()
        setupNavItems()
    }

	
	func setupLabels() {
        
        aboutBackgroundView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 60)
        
		aboutTitle.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 15, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 20)

        aboutDescription.anchor(aboutBackgroundView.bottomAnchor, left: aboutTitle.leftAnchor, bottom: nil, right: aboutTitle.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 220)
        
        worksBackgroundView.anchor(aboutDescription.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 60)
        
        worksTitle.anchor(worksBackgroundView.topAnchor, left: aboutTitle.leftAnchor, bottom: nil, right: aboutTitle.rightAnchor, topConstant: 15, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        worksDescription.anchor(worksBackgroundView.bottomAnchor, left: aboutTitle.leftAnchor, bottom: nil, right: aboutTitle.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 220)
		
	}
    
    private func setupNavItems() {
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "wt_logo"))
        //set the frame for the icon at the top of the nav bar
        titleImageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        //force the image into the frame we made above
        titleImageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = titleImageView
        
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
    }
    

}
