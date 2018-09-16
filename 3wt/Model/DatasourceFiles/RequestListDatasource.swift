//
//  RequestListDatasource.swift
//  3wt
//
//  Created by Seth Merritt on 8/18/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import LBTAComponents
import FirebaseFirestore
import UIKit

var requestArray = [Request]()

class RequestListDatasource: Datasource {
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [RequestListCell.self]
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [RequestListHeader.self]
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [RequestListFooter.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return requestArray[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return requestArray.count
    }
    
    
}
