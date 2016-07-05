//
//  JsonParser.swift
//  SmartOrderWaiter
//
//  Created by Marina Georgieva on 7/5/16.
//  Copyright © 2016 Marina Georgieva. All rights reserved.
//

import Foundation

class JsonParser{
    
    var data: NSData!
    init(withData: NSData){
        self.data = withData
    }
    
    func parse(){
        do {
            let json = try  NSJSONSerialization.JSONObjectWithData(self.data, options: .AllowFragments) as? NSDictionary
            NSNotificationCenter.defaultCenter().postNotificationName("SmartOrder", object: json)
        }
        catch{
            print("Error serializing JSON \(error)")
        }
    }
}
