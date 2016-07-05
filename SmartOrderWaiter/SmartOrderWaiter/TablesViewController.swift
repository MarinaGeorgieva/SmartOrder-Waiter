//
//  TablesViewController.swift
//  SmartOrderWaiter
//
//  Created by Marina Georgieva on 7/5/16.
//  Copyright © 2016 Marina Georgieva. All rights reserved.
//

import UIKit

class TablesViewController: UIViewController {

    let url = "https://cryptic-mountain-25848.herokuapp.com/api/tables.php"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        self.collectionView.dataSource = self
//        self.collectionView.delegate = self
        
        let request = RequestManager(requestUrl: url)
        request.getRequest()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TablesViewController.loadTables(_:)) , name: "SmartOrder", object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadTables(notification: NSNotification) {
        let jsonData = notification.object as? NSDictionary
        let state = jsonData!["code"] as? Int
        if(state == 200){
            
        }
        else{
            print("Error came up")
        }
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
