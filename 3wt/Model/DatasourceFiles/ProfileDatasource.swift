//
//  ProfileDatasource.swift
//  3wt
//
//  Created by Seth Merritt on 8/25/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import LBTAComponents

class ProfileDatasource: Datasource {
    
    let profileComponents = ["Pilot Detail", "Flight History", "Bookings"]
    
    override func numberOfSections() -> Int {
        return 2
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [ProfileSummaryCell.self, ProfileComponentCell.self]
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [ProfileSummaryHeader.self, ProfileComponentHeader.self]
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [ProfileSummaryFooter.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        if indexPath.section == 0 {
            return wtUser
        }
        else {
            return profileComponents[indexPath.item]
        }
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
            return profileComponents.count
        }
    }
    
}
