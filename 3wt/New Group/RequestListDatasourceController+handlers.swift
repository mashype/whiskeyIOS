//
//  RequestListDatasourceController+handlers.swift
//  3wt
//
//  Created by Seth Merritt on 8/18/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import UIKit

extension RequestListDatasourceController {
    
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
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "wt_logo"))
        //set the frame for the icon at the top of the nav bar
        titleImageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        //force the image into the frame we made above
        titleImageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = titleImageView
        
        //just removes the shadow line from under the nav bar and replaces it with a lighter line
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        let navBarSeperatorView = UIView()
        navBarSeperatorView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        view.addSubview(navBarSeperatorView)
        navBarSeperatorView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0.5)
    }
    
    @objc func showRequestAddController() {
        let requestAddController = RequestAddController()
        let navController = UINavigationController(rootViewController: requestAddController)
        present(navController, animated: true, completion: nil)
    }
    
}
