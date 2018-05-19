//
//  ViewController.swift
//  CryptoApp
//
//  Created by Justin Grosvenor on 5/9/18.
//  Copyright © 2018 Justin Grosvenor. All rights reserved.
//

import UIKit
import CoreData

extension URL {
    func withQueriess(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    let names: [String] = ["BITCOIN", "LITECOIN", "ETHERIUM", "RIPPLE", "EOS", "BITCOIN CASH", "BYTECOIN"]
    let symbols: [String] = ["BTC", "LTC", "ETH", "XRP", "EOS", "BCH", "BCN"]
    var row: Int = 0
    var getPrice = GetPrices()
    var showCoins: [String] = []
    var getDetails = GetDetail()
    private var newData: Welcome? = nil
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return symbols.count
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return names[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.row = row
    }
    
    @IBOutlet weak var btcl: UILabel!
    @IBOutlet weak var ltcl: UILabel!
    @IBOutlet weak var ethl: UILabel!
    @IBOutlet weak var xrpl: UILabel!
    @IBOutlet weak var eosl: UILabel!
    @IBOutlet weak var bchl: UILabel!
    @IBOutlet weak var bcnl: UILabel!
    
    @IBOutlet weak var btcs: UILabel!
    @IBOutlet weak var ltcs: UILabel!
    @IBOutlet weak var eths: UILabel!
    @IBOutlet weak var xrps: UILabel!
    @IBOutlet weak var eoss: UILabel!
    @IBOutlet weak var bchc: UILabel!
    @IBOutlet weak var bcnc: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDetails.searchDetails()
        if setData(){
        
        }
        
    }
    
    func setData() -> Bool {
        sleep(1)
        if let thisData = getDetails.results {
            newData = thisData
            print("data success")
            return true
        }
        else {
            usleep(1500000)
            if let thisData = getDetails.results {
                newData = thisData
                print("data success second try")
                return true
            }
            else {
                print("inner fail")
                sleep(3)
                if let thisData = getDetails.results {
                    newData = thisData
                    print("data success third try")
                    return true
                }
                else {
                    print("Data Failure")
                    return false
                }
            }
        }
    }
    
    @IBAction func refresh(_ sender: Any) {
        if showCoins.contains("BTC") {
            setPrice(coin: "BTC")
            usleep(100000)
        }
        if showCoins.contains("LTC") {
            setPrice(coin: "LTC")
            usleep(100000)
        }
        if showCoins.contains("ETH") {
            setPrice(coin: "ETH")
            usleep(100000)
        }
        if showCoins.contains("EOS") {
            setPrice(coin: "EOS")
            usleep(100000)
        }
        if showCoins.contains("XRP") {
            setPrice(coin: "XRP")
            usleep(100000)
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
    func getBCHPrice() -> Double? {
        return getPrice.searchSingle("BCH")
    }
    func getBCNPrice() -> Double? {
        return getPrice.searchSingle("BCN")
    }
    
    
    func setPrice(coin: String){
        var p: Double?
        var l: UILabel?
        var s: UILabel?
        switch coin {
        case "BTC":
            p = newData!.raw.btc.usd.price
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
            
        case "BCH":
            p = getBCHPrice()
            l = bchc
            s = bchl
            
        case "BCN":
            p = getBCNPrice()
            l = bcnc
            s = bcnl
            
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
                    l!.text = String(CoinData[(index)].priceUSD)
                }
//                if CoinData.count > 1 {
//                    if CoinData[(index)].priceUSD > CoinData[(index - 1)].priceUSD {
//                        colorLabelGreen(l: l!)
//                    }
//                    else {
//                        colorLabelRed(l: l!)
//                    }
//                }
            }
            case "ETH":
           
                if let CoinData = coreDataHandlerETH.fetchObjectETH(){
                    let index = CoinData.count - 1
                    if index > 0{
                        l!.text = String(CoinData[(index)].priceUSD)
                    }
//                    if CoinData.count > 1 {
//                        if CoinData[(index)].priceUSD > CoinData[(index - 1)].priceUSD {
//                            colorLabelGreen(l: l!)
//                        }
//                        else {
//                            colorLabelRed(l: l!)
//                        }
//                    }
                }
            case "LTC":
            
                if let CoinData = coreDataHandlerETH.fetchObjectLTC(){
                    let index = CoinData.count - 1
                    if index > 0{
                        l!.text = String(CoinData[(index)].priceUSD)
                    }
//                    if CoinData.count > 1 {
//                        if CoinData[(index)].priceUSD > CoinData[(index - 1)].priceUSD {
//                            colorLabelGreen(l: l!)
//                        }
//                        else {
//                            colorLabelRed(l: l!)
//                        }
//                    }
                }
            case "XRP":
           
                if let CoinData = coreDataHandlerETH.fetchObjectXRP(){
                    let index = CoinData.count - 1
                    if index > 0{
                        l!.text = String(CoinData[(index)].priceUSD)
                    }
//                    if CoinData.count > 1 {
//                        if CoinData[(index)].priceUSD > CoinData[(index - 1)].priceUSD {
//                            colorLabelGreen(l: l!)
//                        }
//                        else {
//                            colorLabelRed(l: l!)
//                        }
//                    }
                }
            case "EOS":
            
                if let CoinData = coreDataHandlerETH.fetchObjectEOS(){
                    let index = CoinData.count - 1
                    if index > 0{
                        l!.text = String(CoinData[(index)].priceUSD)
                    }
                    if CoinData.count > 1 {
                        if CoinData[(index)].priceUSD > CoinData[(index - 1)].priceUSD {
//                            colorLabelGreen(l: l!)
                        }
                        if CoinData[(index)].priceUSD < CoinData[(index - 1)].priceUSD {
//                            colorLabelRed(l: l!)
                        }
                    }
                }
                
            case "BCH":
                
                if let CoinData = coreDataHandlerETH.fetchObjectBCH(){
                    let index = CoinData.count - 1
                    if index > 0{
                        l!.text = String(CoinData[(index)].priceUSD)
                    }
                    if CoinData.count > 1 {
                        if CoinData[(index)].priceUSD > CoinData[(index - 1)].priceUSD {
//                            colorLabelGreen(l: l!)
                        }
                        if CoinData[(index)].priceUSD < CoinData[(index - 1)].priceUSD {
//                            colorLabelRed(l: l!)
                        }
                    }
                }
                
            case "BCN":
                
                if let CoinData = coreDataHandlerETH.fetchObjectBCN(){
                    let index = CoinData.count - 1
                    if index > 0{
                        l!.text = String(CoinData[(index)].priceUSD)
                    }
                    if CoinData.count > 1 {
                        if CoinData[(index)].priceUSD > CoinData[(index - 1)].priceUSD {
//                            colorLabelGreen(l: l!)
                        }
                        if CoinData[(index)].priceUSD < CoinData[(index - 1)].priceUSD {
//                            colorLabelRed(l: l!)
                        }
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
                btcl.text = String(BTCData[(index)].priceUSD)
                }
            }
            if let _ = btcl.text {
                btcs.text = "BTC"
            }
        }
    }
    
//    func colorLabelGreen(l: UILabel){
//        l.backgroundColor = UIColor(displayP3Red: 0, green: 180, blue: 0, alpha: 0.3)
//    }
//
//    func colorLabelRed(l: UILabel){
//        l.backgroundColor = UIColor(displayP3Red: 255, green: -80, blue: 40, alpha: 0.2)
//    }
    


}

