//
//  TablesViewController.swift
//  SmartOrderWaiter
//
//  Created by Marina Georgieva on 7/5/16.
//  Copyright © 2016 Marina Georgieva. All rights reserved.
//

import UIKit

class TablesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    let url = "https://cryptic-mountain-25848.herokuapp.com/api/tables.php"
    let orderURL = "http://cryptic-mountain-25848.herokuapp.com/api/current-orders.php"
    
    @IBOutlet weak var collectionView: UICollectionView!
    var mainTables: [Table]? = []
    var clientsOrders = NSMutableDictionary()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        let request = RequestManager(requestUrl: url)
        request.getRequest()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TablesViewController.loadTables(_:)) , name: "SmartOrder", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TablesViewController.getOrders(_:)) , name: "GetOrders", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.mainTables?.count)!
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cellID = "TableCell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! TableCustomCell
        let tableID = self.mainTables![indexPath.row].getTableID()
        cell.addTableNumber(tableID)
        if(self.clientsOrders[tableID] != nil){
            cell.orderImg.image = UIImage(named: "OrderActive")
        }else{
            cell.orderImg.image = UIImage(named: "OrderNotActive")
        }
        
        return cell
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        let curMenu = (clientsOrders[indexPath.row + 1]) as? NSMutableDictionary
        let DVC = storyboard?.instantiateViewControllerWithIdentifier("TableDVC") as? TableDetailVC
        if(curMenu != nil){
            DVC?.currentOrder = curMenu!
        }
        self.navigationController?.pushViewController(DVC!, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    func loadTables(notification: NSNotification) {
        let jsonData = notification.object as? NSDictionary
        let state = jsonData!["code"] as? Int
        if(state == 200){
            print(jsonData)
            if let dictData = jsonData!["data"] as? NSDictionary{
                let tables = dictData["tables"] as? NSArray
                fetchArrays(tables!)
            }
        }
        else{
            print("Error came up")
        }
    }
    
    
    func fetchArrays(tables: NSArray){
        for table in tables{
            if let jsonTable = table as? NSDictionary{
                print(jsonTable)
                let tableID = Int(jsonTable["id"] as! String)
                let tableName = jsonTable["name"] as? String
                let newTable =  Table(_tableID: tableID!, _name: tableName!)
                self.mainTables?.append(newTable)
            }
        }
        self.collectionView.reloadData()
    }
    @IBAction func reset(sender: AnyObject) {
        let request = RequestManager(requestUrl: orderURL)
        request.getOrders()
        
    }

    
    func getOrders(notification: NSNotification){
        let obj = notification.object as? NSDictionary
        print(obj)
        if let data = obj!["data"] as? NSDictionary{
            if let ordersArray = data["orders"] as? NSArray {
                fetchOrders(ordersArray)
            }
        }
    }
    
    private func fetchOrders(ordersArray: NSArray){
        for order in ordersArray{
            print(order)
            if let dict = order as? NSDictionary{
                let tableID = Int(dict["table_id"] as! String)
                if let products = dict["products"] as? NSArray{
                    fetchProducts(products, tableID: tableID!)
                }
            }
        }
    }
    
    private func fetchProducts(productArray: NSArray, tableID: Int){
        for product in productArray{
            if let productDict = product as? NSDictionary{
                let productName = productDict["name"] as? String
                let productQuantity = Int(productDict["quantity"] as! String)!
                orderList(tableID, productName: productName!, productQunatity: productQuantity)
            }
        }
        self.collectionView.reloadData()
    }
    
    func orderList(tableID: Int, productName: String, productQunatity: Int){
        
        
        if (self.clientsOrders[tableID] != nil){
            if let dict = self.clientsOrders[tableID] as? NSMutableDictionary{
                if(dict[productName] != nil){
                    dict[productName] = (dict[productName] as? Int)! + productQunatity
                }else{
                    dict[productName] = productQunatity
                }
            }
        }
        else{
            let orderList = NSMutableDictionary()
            orderList[productName] = productQunatity
            self.clientsOrders[tableID] = orderList
        }
        
    }
    
}
