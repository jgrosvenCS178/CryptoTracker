//
//  coreDataHandlerETH.swift
//  CryptoApp
//
//  Created by Justin Grosvenor on 5/9/18.
//  Copyright © 2018 Justin Grosvenor. All rights reserved.
//

import UIKit
import CoreData

class coreDataHandlerETH: NSObject {
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    class func saveObject(price: String, timestamp: Date) -> Bool {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "ETH", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        
        manageObject.setValue(price, forKey: "price")
        manageObject.setValue(timestamp, forKey: "timestamp")
        
        
        do{
            try context.save()
            return true
        }catch{
            return false
        }
    }
    
    class func fetchObject() -> [ETH]? {
        let context = getContext()
        var info:[ETH]? = nil
        do {
            info = try context.fetch(ETH.fetchRequest())
            return info
        }catch {
            return info
        }
        
    }
    
}
