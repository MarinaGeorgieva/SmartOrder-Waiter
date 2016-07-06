//
//  Table.swift
//  SmartOrderWaiter
//
//  Created by Emil Iliev on 7/6/16.
//  Copyright © 2016 Marina Georgieva. All rights reserved.
//

import Foundation

class Table{
    
    private var tableID: Int
    private var name: String
    
    init(_tableID: Int, _name: String){
        self.tableID = _tableID
        self.name = _name
    }
    
    func getTableID() -> Int{
        return self.tableID
    }
    
    func getTableName()-> String{
        return self.name
    }
}