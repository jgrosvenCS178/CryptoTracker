//
//  DetailViewController.swift
//  CryptoApp
//
//  Created by Justin Grosvenor on 5/15/18.
//  Copyright © 2018 Justin Grosvenor. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let getDetail = GetDetail()
    var newData: Welcome? = nil
    var dataSuccess: Bool = false
    
    // 1=bitcoin 2=bytecoin 3=litecoin 4=EOS 5=ETH 6=XRP 7=BCH
    let logos: [UIImage] = [#imageLiteral(resourceName: "btc"),#imageLiteral(resourceName: "ltc"),#imageLiteral(resourceName: "eos"),#imageLiteral(resourceName: "eth"),#imageLiteral(resourceName: "xrp"),#imageLiteral(resourceName: "bch"),#imageLiteral(resourceName: "bcn")]
    let symbols: [String] = ["BTC", "LTC", "EOS", "ETH", "XRP", "BCH", "BCN"]
    let names: [String] = ["BITCOIN", "LITECOIN", "EOS", "ETHERIUM", "RIPPLE", "BITCOIN CASH", "BYTECOIN"]
    
    
    @IBOutlet weak var fiatController: UISegmentedControl!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var symb: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var mcap: UILabel!
    @IBOutlet weak var high: UILabel!
    @IBOutlet weak var low: UILabel!
    @IBOutlet weak var delta: UILabel!
    @IBOutlet weak var volume: UILabel!

    /////////////////////////////////////////////////////////////////////////
    // FIAT SEGMENTED SELECTOR
    //////////
    
    @IBAction func fiat(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            switch symb.text {
                case "BTC":
                    price.text = String(newData!.raw.btc.usd.price)
                case "LTC":
                    price.text = String(newData!.raw.ltc.usd.price)
                case "ETH":
                    price.text = String(newData!.raw.eth.usd.price)
                case "EOS":
                    price.text = String(newData!.raw.eth.usd.price)
                case "XRP":
                    price.text = String(newData!.raw.eth.usd.price)
                default:
                    break
                
            }
        case 1:
            switch symb.text {
                case "BTC":
                    price.text = String(newData!.raw.btc.eur.price)
                case "LTC":
                    price.text = String(newData!.raw.ltc.eur.price)
                case "ETH":
                    price.text = String(newData!.raw.eth.eur.price)
                case "EOS":
                    price.text = String(newData!.raw.eth.eur.price)
                case "XRP":
                    price.text = String(newData!.raw.eth.eur.price)
                
                default:
                    break
            }
        case 2:
            switch symb.text {
                case "BTC":
                    price.text = String(newData!.raw.btc.gbp.price)
                case "LTC":
                    price.text = String(newData!.raw.ltc.gbp.price)
                case "ETH":
                    price.text = String(newData!.raw.eth.gbp.price)
                case "EOS":
                    price.text = String(newData!.raw.eth.gbp.price)
                case "XRP":
                    price.text = String(newData!.raw.eth.gbp.price)
                
                default:
                    break
            }
            
        default:
            break
        }
    }
    
    
    //////////////////////////////////////////////////////
    // VIEW DID LOAD
    /////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logo.image = logos[0]
        getDetail.searchDetails()
        if setData(){
            setLabels("BTC")
        }
        
    }

    //////////////////////////////////////////////////////
    // SET DATA
    ////////
    
    func setData() -> Bool {
        sleep(1)
        if let thisData = getDetail.results {
            newData = thisData
            print("data success")
            dataSuccess = true
        }
        else {
            usleep(1500000)
            if let thisData = getDetail.results {
                newData = thisData
                print("data success second try")
                dataSuccess = true
                return dataSuccess
            }
            else {
                print("inner fail")
                sleep(1)
                if let thisData = getDetail.results {
                    newData = thisData
                    print("data success third try")
                    dataSuccess = true
                    return dataSuccess
                }
                else {
                    print("Data Failure")
                    return false
                }
            }
        }
        return false
    }
    
    func setImage(){
        
    }
    
    /////////////////////////////////////////////////////////////////////
    // SET LABELS
    //////////
    
    func setLabels(_ symbol: String) {
        symb.text = symbol
        
        switch symbol {
        case "BTC":
            price.text = String(newData!.raw.btc.usd.price)
            mcap.text = String(newData!.raw.btc.usd.mktcap)
            high.text = String(newData!.raw.btc.usd.high24Hour)
            low.text = String(newData!.raw.btc.usd.low24Hour)
            delta.text = String(newData!.raw.btc.usd.change24Hour)
            volume.text = String(newData!.raw.btc.usd.totalvolume24Hto)
        case "LTC":
            price.text = String(newData!.raw.ltc.usd.price)
            mcap.text = String(newData!.raw.ltc.usd.mktcap)
            high.text = String(newData!.raw.ltc.usd.high24Hour)
            low.text = String(newData!.raw.ltc.usd.low24Hour)
            delta.text = String(newData!.raw.ltc.usd.change24Hour)
            volume.text = String(newData!.raw.ltc.usd.totalvolume24Hto)
        case "EOS":
            price.text = String(newData!.raw.eos.usd.price)
            mcap.text = String(newData!.raw.eos.usd.mktcap)
            high.text = String(newData!.raw.eos.usd.high24Hour)
            low.text = String(newData!.raw.eos.usd.low24Hour)
            delta.text = String(newData!.raw.eos.usd.change24Hour)
            volume.text = String(newData!.raw.eos.usd.totalvolume24Hto)
            
        case "ETH":
            price.text = String(newData!.raw.eth.usd.price)
            mcap.text = String(newData!.raw.eth.usd.mktcap)
            high.text = String(newData!.raw.eth.usd.high24Hour)
            low.text = String(newData!.raw.eth.usd.low24Hour)
            delta.text = String(newData!.raw.eth.usd.change24Hour)
            volume.text = String(newData!.raw.eth.usd.totalvolume24Hto)
            
        case "XRP":
            price.text = String(newData!.raw.xrp.usd.price)
            mcap.text = String(newData!.raw.xrp.usd.mktcap)
            high.text = String(newData!.raw.xrp.usd.high24Hour)
            low.text = String(newData!.raw.xrp.usd.low24Hour)
            delta.text = String(newData!.raw.xrp.usd.change24Hour)
            volume.text = String(newData!.raw.xrp.usd.totalvolume24Hto)
            
        case "BCH":
            price.text = "no data available"
            mcap.text = "no data available"
            high.text = "no data available"
            low.text = "no data available"
            delta.text = "no data available"
            volume.text = "no data available"
        case "BCN":
            price.text = "no data available"
            mcap.text = "no data available"
            high.text = "no data available"
            low.text = "no data available"
            delta.text = "no data available"
            volume.text = "no data available"
            
        default :
            break
        }
        
    }
    
    ////////////////////////////////////////////////////////////////////
    // PICKERVIEW
    ////////
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        logo.image = logos[row]
        setLabels(symbols[row])
        fiatController.selectedSegmentIndex = 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return names[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return symbols.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //////////////////////////////////////////////////////////////////
    // REFRESH BUTTON
    /////////
    
    @IBAction func refresh(_ sender: Any) {
        getDetail.searchDetails()
        sleep(3)
         if setData(){
            setLabels(symb.text!)
        }
         else {
            print("reload failure")
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
