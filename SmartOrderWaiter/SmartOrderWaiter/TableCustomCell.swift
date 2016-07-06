//
//  TableCustomCell.swift
//  SmartOrderWaiter
//
//  Created by Emil Iliev on 7/6/16.
//  Copyright © 2016 Marina Georgieva. All rights reserved.
//

import UIKit

class TableCustomCell: UICollectionViewCell {
    
    @IBOutlet weak var tableNumber: UILabel!
    @IBOutlet weak var orderImg: UIImageView!
    @IBOutlet weak var billImg: UIImageView!

    override func awakeFromNib() {
        print("hello")
    }

    func addTableNumber(tableID: Int){
        self.tableNumber.text = "Table number: \(tableID)"
    }
}
