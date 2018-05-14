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
    
    class func saveObject(symb: String, price: Double, timestamp: Date) -> Bool {
        let context = getContext()
        let sym: String = symb
        let entity = NSEntityDescription.entity(forEntityName: sym, in: context)
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
    
    class func fetchObjectETH() -> [ETH]? {
        let context = getContext()
        var info:[ETH]? = nil
        do {
            info = try context.fetch(ETH.fetchRequest())
            return info
        }catch {
            return info
        }
        
    }
    class func fetchObjectLTC() -> [LTC]? {
        let context = getContext()
        var info:[LTC]? = nil
        do {
            info = try context.fetch(LTC.fetchRequest())
            return info
        }catch {
            return info
        }
        
    }
    class func fetchObjectXRP() -> [XRP]? {
        let context = getContext()
        var info:[XRP]? = nil
        do {
            info = try context.fetch(XRP.fetchRequest())
            return info
        }catch {
            return info
        }
        
    }
    class func fetchObjectEOS() -> [EOS]? {
        let context = getContext()
        var info:[EOS]? = nil
        do {
            info = try context.fetch(EOS.fetchRequest())
            return info
        }catch {
            return info
        }
        
    }
    class func fetchObjectBTC() -> [BTC]? {
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
