//
//  ViewController.swift
//  SmartOrderWaiter
//
//  Created by Marina Georgieva on 7/5/16.
//  Copyright © 2016 Marina Georgieva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let url = "https://cryptic-mountain-25848.herokuapp.com/api/waiters.php";
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.loginResponse(_:)), name: "SmartOrder", object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func loginResponse(notification: NSNotification) {
        let jsonData = notification.object as? NSDictionary
        let state = jsonData!["code"] as? Int
        if(state == 200){
            let tablesVC = storyboard?.instantiateViewControllerWithIdentifier("Tables") as? TablesViewController
            self.navigationController?.pushViewController(tablesVC!, animated: true)
        }
        else{
            let message = jsonData!["message"] as! String
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func login(sender: AnyObject) {
        if(self.username.text?.isEmpty == true) {
            let alert = UIAlertController(title: title, message: "Please, enter username!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else if (self.password.text?.isEmpty == true) {
            let alert = UIAlertController(title: title, message: "Please, enter password!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else {
            let data = NSMutableDictionary()
            data["username"] = self.username.text
            data["password"] = self.password.text
            do{
                let jsonData = try NSJSONSerialization.dataWithJSONObject(data, options: .PrettyPrinted)
                let jsonString = NSString(data: jsonData, encoding: NSUTF8StringEncoding)! as String
                let request = RequestManager(requestUrl: url)
                request.postRequest(jsonString)
            }
            catch let error as NSError{
                print(error)
            }
        }
    }
}

