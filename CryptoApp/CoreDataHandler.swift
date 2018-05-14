//
//  CoreDataHandler.swift
//  CryptoApp
//
//  Created by Justin Grosvenor on 5/9/18.
//  Copyright © 2018 Justin Grosvenor. All rights reserved.
//

import UIKit
import CoreData

// FOR BITCOIN
class CoreDataHandler: NSObject {
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    class func saveObject(price: Double, timestamp: Date) -> Bool {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "BTC", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        
        manageObject.setValue(price, forKey: "priceUSD")
        manageObject.setValue(timestamp, forKey: "timestamp")
        
        
        do{
            try context.save()
            return true
        }catch{
            return false
        }
    }
    
    class func fetchObject() -> [BTC]? {
        let context = getContext()
        var info:[BTC]? = nil
        do {
            info = try context.fetch(BTC.fetchRequest())
            return info
        }catch {
            return info
        }
        
    }
    
}



