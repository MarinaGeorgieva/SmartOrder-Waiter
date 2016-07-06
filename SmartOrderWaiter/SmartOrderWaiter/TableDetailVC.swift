//
//  TableDetailVC.swift
//  SmartOrderWaiter
//
//  Created by Emil Iliev on 7/6/16.
//  Copyright © 2016 Marina Georgieva. All rights reserved.
//

import UIKit

class TableDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var currentOrder: NSDictionary? = nil
    var orderKeys = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        let nib = UINib(nibName: "OrderCustomCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "OrderCustomCell")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if(currentOrder != nil){
            self.orderKeys = currentOrder!.allKeys
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(currentOrder != nil){
            return currentOrder!.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellID = "OrderCustomCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! OrderCustomCell
        if( currentOrder != nil){
            let curProduct = orderKeys[indexPath.row]
            cell.quantity.digit.text = "\(self.currentOrder!.objectForKey(curProduct)!)"
            cell.productName.text = "\(curProduct)"
        }
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
