//
//  RequestListDatasourceController.swift
//  3wt
//
//  Created by Seth Merritt on 8/18/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import LBTAComponents
import FirebaseFirestore


class RequestListDatasourceController: DatasourceController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor(r: 232, g: 236, b: 241)
        observeData()
        setupNavigationBarItems()
        
        NotificationCenter.default.addObserver(self, selector: #selector(presentResposeController), name: NSNotification.Name(rawValue: "notifyRequestResponse"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showRequestAddController), name: NSNotification.Name(rawValue: "notifyNewRequest"), object: nil)
        
        let requestListDatasource = RequestListDatasource()
        self.datasource = requestListDatasource
        
    }
    
    func observeData() {
        let requestRef = db.collection("requests")
        
        //listens for updates on the database and will refresh when needed.
        requestRef.addSnapshotListener { snapshot, error in
            if error != nil {
                print(error as Any)
            } else {
                requestArray = (snapshot?.documents.compactMap({Request(dictionary: $0.data())}))!
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
        }
    }
    
    //show the request detail page
    func showRequestDetailController(request: Request) {
        let requestDetailController = RequestDetailController()
        let navController = UINavigationController(rootViewController: requestDetailController)
        requestDetailController.selectedRequest = request
        present(navController, animated: true, completion: nil)
    }
    
    @objc func presentResposeController(_ notification:Notification) {
        let requestResponseViewController = RequestResponseViewController()
        let navController = UINavigationController(rootViewController: requestResponseViewController)
        requestResponseViewController.currentRequestID = notification.userInfo!["requestID"] as! String
        present(navController, animated: true, completion: nil)
    }
    
    
    //selected the controller based on the table selection
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let request = requestArray[indexPath.row]
        showRequestDetailController(request: request)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //removes the default gap between the cells in the standard collection layout.
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .zero
    }
}
