//
//  ProfileDatasourceController.swift
//  3wt
//
//  Created by Seth Merritt on 8/25/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import LBTAComponents
import Firebase

class ProfileDatasourceController: DatasourceController {
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        fetchUser()
//    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
        
        let profileDatasource = ProfileDatasource()
        self.datasource = profileDatasource
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                showPilotProfileDetail()
            }
        }

    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: view.frame.width, height: 250)
        }
        else {
            return CGSize(width: view.frame.width, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return.zero
    }
    
}
