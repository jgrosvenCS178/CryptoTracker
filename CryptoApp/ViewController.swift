//
//  ViewController.swift
//  CryptoApp
//
//  Created by Justin Grosvenor on 5/9/18.
//  Copyright © 2018 Justin Grosvenor. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let symbols: [String] = ["BTC", "LTC", "ETH", "XRP", "EOS"]
    var row: Int = 0
    var getPrice = GetPrices()
    var showCoins: [String] = []
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return symbols[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.row = row
    }
    
    @IBOutlet weak var btcl: UILabel!
    @IBOutlet weak var ltcl: UILabel!
    @IBOutlet weak var ethl: UILabel!
    @IBOutlet weak var xrpl: UILabel!
    @IBOutlet weak var eosl: UILabel!
    
    @IBOutlet weak var btcs: UILabel!
    @IBOutlet weak var ltcs: UILabel!
    @IBOutlet weak var eths: UILabel!
    @IBOutlet weak var xrps: UILabel!
    @IBOutlet weak var eoss: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
    }
    @IBAction func refresh(_ sender: Any) {
        if showCoins.contains("BTC") {
            setPrice(coin: "BTC")
            sleep(1)
        }
        if showCoins.contains("LTC") {
            setPrice(coin: "LTC")
            sleep(1)
        }
        if showCoins.contains("ETH") {
            setPrice(coin: "ETH")
            sleep(1)
        }
        if showCoins.contains("EOS") {
            setPrice(coin: "EOS")
            sleep(1)
        }
        if showCoins.contains("XRP") {
            setPrice(coin: "XRP")
            sleep(1)
        }
    }
    
    @IBAction func addCoin(_ sender: Any) {
        setPrice(coin: symbols[row])
        showCoins.append(symbols[row])
    }
    
    
    
    
    
    
    
    
    
    
    
    
    func getBTCPrice() -> Double? {
        return getPrice.searchSingle("BTC")
    }
    func getETHPrice() -> Double? {
        return getPrice.searchSingle("ETH")
    }
    func getLTCPrice() -> Double? {
        return getPrice.searchSingle("LTC")
    }
    func getXRPPrice() -> Double? {
        return getPrice.searchSingle("XRP")
    }
    func getEOSPrice() -> Double? {
        return getPrice.searchSingle("EOS")
    }
    
    
    func setPrice(coin: String){
        var p: Double?
        var l: UILabel?
        var s: UILabel?
        switch coin {
        case "BTC":
            p = getBTCPrice()
            l = btcl
            s = btcs
            
        case "ETH":
            p = getETHPrice()
            l = ethl
            s = eths
            
        case "LTC":
            p = getLTCPrice()
            l = ltcl
            s = ltcs
            
        case "XRP":
            p = getXRPPrice()
            l = xrpl
            s = xrps
           
        case "EOS":
            p = getEOSPrice()
            l = eosl
            s = eoss
            
        default:
            print("error")
        }
        

        
        if let CoinPrice = p {
            if !coreDataHandlerETH.saveObject(symb: coin, price: CoinPrice, timestamp: Date()) {
                print("failed to save coin data")
            }
            switch coin {
            case "BTC":
            if let CoinData = coreDataHandlerETH.fetchObjectBTC(){
                let index = CoinData.count - 1
                if index > 0{
                    l!.text = String(format: "%.6f", CoinData[(index)].priceUSD)
                }
            }
            case "ETH":
           
                if let CoinData = coreDataHandlerETH.fetchObjectETH(){
                    let index = CoinData.count - 1
                    if index > 0{
                        l!.text = String(format: "%.6f", CoinData[(index)].priceUSD)
                    }
                }
            case "LTC":
            
                if let CoinData = coreDataHandlerETH.fetchObjectLTC(){
                    let index = CoinData.count - 1
                    if index > 0{
                        l!.text = String(format: "%.6f", CoinData[(index)].priceUSD)
                    }
                }
            case "XRP":
           
                if let CoinData = coreDataHandlerETH.fetchObjectXRP(){
                    let index = CoinData.count - 1
                    if index > 0{
                        l!.text = String(format: "%.6f", CoinData[(index)].priceUSD)
                    }
                }
            case "EOS":
            
                if let CoinData = coreDataHandlerETH.fetchObjectEOS(){
                    let index = CoinData.count - 1
                    if index > 0{
                        l!.text = String(format: "%.6f", CoinData[(index)].priceUSD)
                    }
                }
            default:
            print("error")
            }
          
            if let _ = l!.text {
                s!.text = coin
            }
        }
    }
    
    
    func setLabels(){
        if let BTCPrice = getBTCPrice() {
            if !CoreDataHandler.saveObject(price: BTCPrice, timestamp: Date()) {
                print("failed to save BTC data")
            }
            if let BTCData = CoreDataHandler.fetchObject(){
                let index = BTCData.count - 1
                if index > 0{
                btcl.text = String(format: "%.6f", BTCData[(index)].priceUSD)
                }
            }
            if let _ = btcl.text {
                btcs.text = "BTC"
            }
        }
    }
    
    


}

