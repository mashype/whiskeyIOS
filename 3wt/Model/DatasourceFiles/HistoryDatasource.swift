//
//  HistoryDatasource.swift
//  3wt
//
//  Created by Seth Merritt on 9/1/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import LBTAComponents


class HistoryDatasource: Datasource {
    
    override func numberOfSections() -> Int {
        return 2
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [RequestHistoryCell.self, BookingHistoryCell.self]
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [RequestHistoryHeader.self, BookingHistoryHeader.self]
    }
    //made the size zero, so shouldnt return anything
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [RequestListFooter.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        if indexPath.section == 0 {
            return requestHistoryArray[indexPath.item]
        }
        else {
            return bookingHistoryArray[indexPath.item]
        }
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        if section == 0 {
            return requestHistoryArray.count
        }
        else {
            return bookingHistoryArray.count
        }
    }
}
