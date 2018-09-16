//
//  HistoryDatasourceController.swift
//  3wt
//
//  Created by Seth Merritt on 9/1/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import LBTAComponents
import Firebase

var requestHistoryArray = [Request]()
var bookingHistoryArray = [Booking]()

class HistoryDatasourceController: DatasourceController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeData()
        
        let historyDatasource = HistoryDatasource()
        self.datasource = historyDatasource
    }
    
    func observeData() {
        let requestHistoryRef = db.collection("requests")
        let bookingHistoryRef = db.collection("bookings")
        
        //listens for updates on the database and will refresh when needed.
        requestHistoryRef.addSnapshotListener { snapshot, error in
            if error != nil {
                print(error as Any)
            } else {
                requestHistoryArray = (snapshot?.documents.compactMap({Request(dictionary: $0.data())}))!
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
        }
        
        bookingHistoryRef.addSnapshotListener { snapshot, error in
            if error != nil {
                print(error as Any)
            } else {
                bookingHistoryArray = (snapshot?.documents.compactMap({Booking(dictionary: $0.data())}))!
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: view.frame.width, height: 100)
        }
        else {
            return CGSize(width: view.frame.width, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return.zero
    }
    
}
