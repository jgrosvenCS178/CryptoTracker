//
//  DetailViewController.swift
//  CryptoApp
//
//  Created by Justin Grosvenor on 5/15/18.
//  Copyright © 2018 Justin Grosvenor. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    //////////////////////////
    // MARK: - DECLARATIONS
    /////////
    
    var getPrice = GetPrices()
    private let getDetail = GetDetail()
    private let getMore = getMoreData()
    private var newData: Welcome? = nil
    private var moreData: Welcome2? = nil
    private var dataSuccess: Bool = false
    
    // 1=bitcoin 2=litecoin 3=EOS 4=ETH 5=XRP 6=BCH 7=BCN
    let logos: [UIImage] = [#imageLiteral(resourceName: "btc"),#imageLiteral(resourceName: "ltc"),#imageLiteral(resourceName: "eos"),#imageLiteral(resourceName: "eth"),#imageLiteral(resourceName: "xrp"),#imageLiteral(resourceName: "bch"),#imageLiteral(resourceName: "bcn"),#imageLiteral(resourceName: "ada"),#imageLiteral(resourceName: "trx")]
    let symbols: [String] = ["BTC", "LTC", "EOS", "ETH", "XRP", "BCH", "BCN", "ADA", "TRX"]
    let names: [String] = ["BITCOIN", "LITECOIN", "EOS", "ETHERIUM", "RIPPLE", "BITCOIN CASH", "BYTECOIN", "CARDANO", "TRON"]
    
    @IBOutlet weak var fiatController: UISegmentedControl!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var symb: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var mcap: UILabel!
    @IBOutlet weak var high: UILabel!
    @IBOutlet weak var low: UILabel!
    @IBOutlet weak var delta: UILabel!
    @IBOutlet weak var volume: UILabel!
 
    ///////////////////////////
    // MARK: -  VIEW DID LOAD
    /////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logo.image = logos[0]
        getDetail.searchDetails()
        if setData(){
            setLabels("BTC")
            print("Data success first batch")
        }
        else {
            print("Data failure first batch")
        }
        getMore.getData()
        if setMoreData(){
            print("Data success second batch")
        }
        else {
            print("Data failure second batch")
        }
        setLabels("BTC")
    }

    ///////////////////////
    // MARK: - SET DATA
    ////////
    
    func setData() -> Bool {
        usleep(300000)
        if let thisData = getDetail.results {
            newData = thisData
            print("data success")
            dataSuccess = true
            return dataSuccess
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
                sleep(3)
                if let thisData = getDetail.results {
                    newData = thisData
                    print("data success third try")
                    dataSuccess = true
                    return dataSuccess
                }
                else {
                    print("Data Failure")
                    dataSuccess = false
                    return dataSuccess
                }
            }
        }
    }
    
    func setMoreData() -> Bool {
        usleep(300000)
        if let thisMoreData = getMore.datas {
            moreData = thisMoreData
            print("more data success second dump")
            dataSuccess = true
            return dataSuccess
        }
        else {
            usleep(1500000)
            if let thisMoreData = getMore.datas {
                moreData = thisMoreData
                print("data success second try second dump")
                dataSuccess = true
                return dataSuccess
            }
            else {
                print("inner fail")
                sleep(3)
                if let thisMoreData = getMore.datas {
                    moreData = thisMoreData
                    print("data success third try second dump")
                    dataSuccess = true
                    return dataSuccess
                }
                else {
                    print("Data Failure second dump")
                    dataSuccess = false
                    return false
                }
            }
        }
    }
    
    
    
    /////////////////////////
    // MARK: - PICKERVIEW
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
    
    ///////////////////////////////
    // MARK: - REFRESH BUTTON
    /////////
    
    @IBAction func refresh(_ sender: Any) {
        getDetail.searchDetails()
         if setData(){
            setLabels(symb.text!)
        }
         else {
            print("reload failure")
        }
        fiatController.selectedSegmentIndex = 0
    }
    
    
    ////////////////////////////
    // MARK: -  SET LABELS
    //////////
    
    func setLabels(_ symbol: String) {
        symb.text = symbol
        if let newData = newData {
            if let moreData = moreData {
                switch symbol {
                case "BTC":
                    price.text = "$\(String(newData.raw.btc.usd.price))"
                    mcap.text = "$\(String(newData.raw.btc.usd.mktcap))"
                    high.text = "$\(String(newData.raw.btc.usd.high24Hour))"
                    low.text = "$\(String(newData.raw.btc.usd.low24Hour))"
                    delta.text = "$\(String(format: "%.2f", newData.raw.btc.usd.change24Hour))"
                    volume.text = "$\(String(newData.raw.btc.usd.totalvolume24Hto))"
                    
                case "LTC":
                    price.text = "$\(String(newData.raw.ltc.usd.price))"
                    mcap.text = "$\(String(newData.raw.ltc.usd.mktcap))"
                    high.text = "$\(String(newData.raw.ltc.usd.high24Hour))"
                    low.text = "$\(String(newData.raw.ltc.usd.low24Hour))"
                    delta.text = "$\(String(format: "%.2f", newData.raw.ltc.usd.change24Hour))"
                    volume.text = "$\(String(newData.raw.ltc.usd.totalvolume24Hto))"
                    
                case "EOS":
                    price.text = "$\(String(newData.raw.eos.usd.price))"
                    mcap.text = "$\(String(newData.raw.eos.usd.mktcap))"
                    high.text = "$\(String(newData.raw.eos.usd.high24Hour))"
                    low.text = "$\(String(newData.raw.eos.usd.low24Hour))"
                    delta.text = "$\(String(format: "%.2f", newData.raw.eos.usd.change24Hour))"
                    volume.text = "$\(String(newData.raw.eos.usd.totalvolume24Hto))"
                    
                case "ETH":
                    price.text = "$\(String(newData.raw.eth.usd.price))"
                    mcap.text = "$\(String(newData.raw.eth.usd.mktcap))"
                    high.text = "$\(String(newData.raw.eth.usd.high24Hour))"
                    low.text = "$\(String(newData.raw.eth.usd.low24Hour))"
                    delta.text = "$\(String(format: "%.2f", newData.raw.eth.usd.change24Hour))"
                    volume.text = "$\(String(newData.raw.eth.usd.totalvolume24Hto))"
                    
                case "XRP":
                    price.text = "$\(String(newData.raw.xrp.usd.price))"
                    mcap.text = "$\(String(newData.raw.xrp.usd.mktcap))"
                    high.text = "$\(String(newData.raw.xrp.usd.high24Hour))"
                    low.text = "$\(String(newData.raw.xrp.usd.low24Hour))"
                    delta.text = "$\(String(format: "%.2f", newData.raw.xrp.usd.change24Hour))"
                    volume.text = "$\(String(newData.raw.xrp.usd.totalvolume24Hto))"
                    
                case "BCH":
                    price.text = "$\(String(moreData.raw.bch.usd.price))"
                    mcap.text = "$\(String(moreData.raw.bch.usd.mktcap))"
                    high.text = "$\(String(moreData.raw.bch.usd.high24Hour))"
                    low.text = "$\(String(moreData.raw.bch.usd.low24Hour))"
                    delta.text = "$\(String(format: "%.2f", moreData.raw.bch.usd.change24Hour))"
                    volume.text = "$\(String(moreData.raw.bch.usd.totalvolume24Hto))"
                    
                case "BCN":
                    price.text = "$\(String(moreData.raw.bcn.usd.price))"
                    mcap.text = "$\(String(moreData.raw.bcn.usd.mktcap))"
                    high.text = "$\(String(moreData.raw.bcn.usd.high24Hour))"
                    low.text = "$\(String(moreData.raw.bcn.usd.low24Hour))"
                    delta.text = "$\(String(format: "%.2f", moreData.raw.bcn.usd.change24Hour))"
                    volume.text = "$\(String(moreData.raw.bcn.usd.totalvolume24Hto))"
                    
                case "ADA":
                    price.text = "$\(String(moreData.raw.ada.usd.price))"
                    mcap.text = "$\(String(moreData.raw.ada.usd.mktcap))"
                    high.text = "$\(String(moreData.raw.ada.usd.high24Hour))"
                    low.text = "$\(String(moreData.raw.ada.usd.low24Hour))"
                    delta.text = "$\(String(format: "%.2f", moreData.raw.ada.usd.change24Hour))"
                    volume.text = "$\(String(moreData.raw.ada.usd.totalvolume24Hto))"
                    
                case "TRX":
                    price.text = "$\(String(moreData.raw.trx.usd.price))"
                    mcap.text = "$\(String(moreData.raw.trx.usd.mktcap))"
                    high.text = "$\(String(moreData.raw.trx.usd.high24Hour))"
                    low.text = "$\(String(moreData.raw.trx.usd.low24Hour))"
                    delta.text = "$\(String(format: "%.2f", moreData.raw.trx.usd.change24Hour))"
                    volume.text = "$\(String(moreData.raw.trx.usd.totalvolume24Hto))"
                    
                default :
                    break
                }
            }
        }
    }
    
    ////////////////////////////////
    // MARK: -  FIAT SEGMENTED SELECTOR
    //////////
    
    @IBAction func fiat(_ sender: UISegmentedControl) {
        
        
        if let newData = newData {
            if let moreData = moreData {
                switch sender.selectedSegmentIndex {
                case 0:
                    switch symb.text {
                    case "BTC":
                        price.text = "$\(String(newData.raw.btc.usd.price))"
                        mcap.text = "$\(String(newData.raw.btc.usd.mktcap))"
                        high.text = "$\(String(newData.raw.btc.usd.high24Hour))"
                        low.text = "$\(String(newData.raw.btc.usd.low24Hour))"
                        delta.text = "$\(String(format: "%.2f", newData.raw.btc.usd.change24Hour))"
                        volume.text = "$\(String(newData.raw.btc.usd.totalvolume24Hto))"
                    case "LTC":
                        price.text = "$\(String(newData.raw.ltc.usd.price))"
                        mcap.text = "$\(String(newData.raw.ltc.usd.mktcap))"
                        high.text = "$\(String(newData.raw.ltc.usd.high24Hour))"
                        low.text = "$\(String(newData.raw.ltc.usd.low24Hour))"
                        delta.text = "$\(String(format: "%.2f", newData.raw.ltc.usd.change24Hour))"
                        volume.text = "$\(String(newData.raw.ltc.usd.totalvolume24Hto))"
                    case "ETH":
                        price.text = "$\(String(newData.raw.eth.usd.price))"
                        mcap.text = "$\(String(newData.raw.eth.usd.mktcap))"
                        high.text = "$\(String(newData.raw.eth.usd.high24Hour))"
                        low.text = "$\(String(newData.raw.eth.usd.low24Hour))"
                        delta.text = "$\(String(format: "%.2f", newData.raw.eth.usd.change24Hour))"
                        volume.text = "$\(String(newData.raw.eth.usd.totalvolume24Hto))"
                    case "EOS":
                        price.text = "$\(String(newData.raw.eos.usd.price))"
                        mcap.text = "$\(String(newData.raw.eos.usd.mktcap))"
                        high.text = "$\(String(newData.raw.eos.usd.high24Hour))"
                        low.text = "$\(String(newData.raw.eos.usd.low24Hour))"
                        delta.text = "$\(String(format: "%.2f", newData.raw.eos.usd.change24Hour))"
                        volume.text = "$\(String(newData.raw.eos.usd.totalvolume24Hto))"
                    case "XRP":
                        price.text = "$\(String(newData.raw.xrp.usd.price))"
                        mcap.text = "$\(String(newData.raw.xrp.usd.mktcap))"
                        high.text = "$\(String(newData.raw.xrp.usd.high24Hour))"
                        low.text = "$\(String(newData.raw.xrp.usd.low24Hour))"
                        delta.text = "$\(String(format: "%.2f", newData.raw.xrp.usd.change24Hour))"
                        volume.text = "$\(String(newData.raw.xrp.usd.totalvolume24Hto))"
                    case "BCH":
                        price.text = "$\(String(moreData.raw.bch.usd.price))"
                        mcap.text = "$\(String(moreData.raw.bch.usd.mktcap))"
                        high.text = "$\(String(moreData.raw.bch.usd.high24Hour))"
                        low.text = "$\(String(moreData.raw.bch.usd.low24Hour))"
                        delta.text = "$\(String(format: "%.2f", moreData.raw.bch.usd.change24Hour))"
                        volume.text = "$\(String(moreData.raw.bch.usd.totalvolume24Hto))"
                    case "BCN":
                        price.text = "$\(String(moreData.raw.bcn.usd.price))"
                        mcap.text = "$\(String(moreData.raw.bcn.usd.mktcap))"
                        high.text = "$\(String(moreData.raw.bcn.usd.high24Hour))"
                        low.text = "$\(String(moreData.raw.bcn.usd.low24Hour))"
                        delta.text = "$\(String(format: "%.2f", moreData.raw.bcn.usd.change24Hour))"
                        volume.text = "$\(String(moreData.raw.bcn.usd.totalvolume24Hto))"
                    case "ADA":
                        price.text = "$\(String(moreData.raw.ada.usd.price))"
                        mcap.text = "$\(String(moreData.raw.ada.usd.mktcap))"
                        high.text = "$\(String(moreData.raw.ada.usd.high24Hour))"
                        low.text = "$\(String(moreData.raw.ada.usd.low24Hour))"
                        delta.text = "$\(String(format: "%.2f", moreData.raw.ada.usd.change24Hour))"
                        volume.text = "$\(String(moreData.raw.ada.usd.totalvolume24Hto))"
                    case "TRX":
                        price.text = "$\(String(moreData.raw.trx.usd.price))"
                        mcap.text = "$\(String(moreData.raw.trx.usd.mktcap))"
                        high.text = "$\(String(moreData.raw.trx.usd.high24Hour))"
                        low.text = "$\(String(moreData.raw.trx.usd.low24Hour))"
                        delta.text = "$\(String(format: "%.2f", moreData.raw.trx.usd.change24Hour))"
                        volume.text = "$\(String(moreData.raw.trx.usd.totalvolume24Hto))"
                    default:
                        break
                        
                    }
                case 1:
                    switch symb.text {
                    case "BTC":
                        price.text = "€\(String(newData.raw.btc.eur.price))"
                        mcap.text = "€\(String(newData.raw.btc.eur.mktcap))"
                        high.text = "€\(String(newData.raw.btc.eur.high24Hour))"
                        low.text = "€\(String(newData.raw.btc.eur.low24Hour))"
                        delta.text = "€\(String(format: "%.2f", newData.raw.btc.eur.change24Hour))"
                        volume.text = "€\(String(newData.raw.btc.eur.totalvolume24Hto))"
                    case "LTC":
                        price.text = "€\(String(newData.raw.ltc.eur.price))"
                        mcap.text = "€\(String(newData.raw.ltc.eur.mktcap))"
                        high.text = "€\(String(newData.raw.ltc.eur.high24Hour))"
                        low.text = "€\(String(newData.raw.ltc.eur.low24Hour))"
                        delta.text = "€\(String(format: "%.2f", newData.raw.ltc.eur.change24Hour))"
                        volume.text = "€\(String(newData.raw.ltc.eur.totalvolume24Hto))"
                    case "ETH":
                        price.text = "€\(String(newData.raw.eth.eur.price))"
                        mcap.text = "€\(String(newData.raw.eth.eur.mktcap))"
                        high.text = "€\(String(newData.raw.eth.eur.high24Hour))"
                        low.text = "€\(String(newData.raw.eth.eur.low24Hour))"
                        delta.text = "€\(String(format: "%.2f", newData.raw.eth.eur.change24Hour))"
                        volume.text = "€\(String(newData.raw.eth.eur.totalvolume24Hto))"
                    case "EOS":
                        price.text = "€\(String(newData.raw.eos.eur.price))"
                        mcap.text = "€\(String(newData.raw.eos.eur.mktcap))"
                        high.text = "€\(String(newData.raw.eos.eur.high24Hour))"
                        low.text = "€\(String(newData.raw.eos.eur.low24Hour))"
                        delta.text = "€\(String(format: "%.2f", newData.raw.eos.eur.change24Hour))"
                        volume.text = "€\(String(newData.raw.eos.eur.totalvolume24Hto))"
                    case "XRP":
                        price.text = "€\(String(newData.raw.xrp.eur.price))"
                        mcap.text = "€\(String(newData.raw.xrp.eur.mktcap))"
                        high.text = "€\(String(newData.raw.xrp.eur.high24Hour))"
                        low.text = "€\(String(newData.raw.xrp.eur.low24Hour))"
                        delta.text = "€\(String(format: "%.2f", newData.raw.xrp.eur.change24Hour))"
                        volume.text = "€\(String(newData.raw.xrp.eur.totalvolume24Hto))"
                    case "BCH":
                        price.text = "€\(String(moreData.raw.bch.eur.price))"
                        mcap.text = "€\(String(moreData.raw.bch.eur.mktcap))"
                        high.text = "€\(String(moreData.raw.bch.eur.high24Hour))"
                        low.text = "€\(String(moreData.raw.bch.eur.low24Hour))"
                        delta.text = "€\(String(format: "%.2f", moreData.raw.bch.eur.change24Hour))"
                        volume.text = "€\(String(moreData.raw.bch.eur.totalvolume24Hto))"
                    case "BCN":
                        price.text = "€\(String(moreData.raw.bcn.eur.price))"
                        mcap.text = "€\(String(moreData.raw.bcn.eur.mktcap))"
                        high.text = "€\(String(moreData.raw.bcn.eur.high24Hour))"
                        low.text = "€\(String(moreData.raw.bcn.eur.low24Hour))"
                        delta.text = "€\(String(format: "%.2f", moreData.raw.bcn.eur.change24Hour))"
                        volume.text = "€\(String(moreData.raw.bcn.eur.totalvolume24Hto))"
                    case "ADA":
                        price.text = "€\(String(moreData.raw.ada.eur.price))"
                        mcap.text = "€\(String(moreData.raw.ada.eur.mktcap))"
                        high.text = "€\(String(moreData.raw.ada.eur.high24Hour))"
                        low.text = "€\(String(moreData.raw.ada.eur.low24Hour))"
                        delta.text = "€\(String(format: "%.2f", moreData.raw.ada.eur.change24Hour))"
                        volume.text = "€\(String(moreData.raw.ada.eur.totalvolume24Hto))"
                    case "TRX":
                        price.text = "€\(String(moreData.raw.trx.eur.price))"
                        mcap.text = "€\(String(moreData.raw.trx.eur.mktcap))"
                        high.text = "€\(String(moreData.raw.trx.eur.high24Hour))"
                        low.text = "€\(String(moreData.raw.trx.eur.low24Hour))"
                        delta.text = "€\(String(format: "%.2f", moreData.raw.trx.eur.change24Hour))"
                        volume.text = "€\(String(moreData.raw.trx.eur.totalvolume24Hto))"
                        
                    default:
                        break
                    }
                case 2:
                    switch symb.text {
                    case "BTC":
                        price.text = "£\(String(newData.raw.btc.gbp.price))"
                        mcap.text = "£\(String(newData.raw.btc.gbp.mktcap))"
                        high.text = "£\(String(newData.raw.btc.gbp.high24Hour))"
                        low.text = "£\(String(newData.raw.btc.gbp.low24Hour))"
                        delta.text = "£\(String(format: "%.2f", newData.raw.btc.gbp.change24Hour))"
                        volume.text = "£\(String(newData.raw.btc.gbp.totalvolume24Hto))"
                    case "LTC":
                        price.text = "£\(String(newData.raw.ltc.gbp.price))"
                        mcap.text = "£\(String(newData.raw.ltc.gbp.mktcap))"
                        high.text = "£\(String(newData.raw.ltc.gbp.high24Hour))"
                        low.text = "£\(String(newData.raw.ltc.gbp.low24Hour))"
                        delta.text = "£\(String(format: "%.2f", newData.raw.ltc.gbp.change24Hour))"
                        volume.text = "£\(String(newData.raw.ltc.gbp.totalvolume24Hto))"
                    case "ETH":
                        price.text = "£\(String(newData.raw.eth.gbp.price))"
                        mcap.text = "£\(String(newData.raw.eth.gbp.mktcap))"
                        high.text = "£\(String(newData.raw.eth.gbp.high24Hour))"
                        low.text = "£\(String(newData.raw.eth.gbp.low24Hour))"
                        delta.text = "£\(String(format: "%.2f", newData.raw.eth.gbp.change24Hour))"
                        volume.text = "£\(String(newData.raw.eth.gbp.totalvolume24Hto))"
                    case "EOS":
                        price.text = "£\(String(newData.raw.eos.gbp.price))"
                        mcap.text = "£\(String(newData.raw.eos.gbp.mktcap))"
                        high.text = "£\(String(newData.raw.eos.gbp.high24Hour))"
                        low.text = "£\(String(newData.raw.eos.gbp.low24Hour))"
                        delta.text = "£\(String(format: "%.2f", newData.raw.eos.gbp.change24Hour))"
                        volume.text = "£\(String(newData.raw.eos.gbp.totalvolume24Hto))"
                    case "XRP":
                        price.text = "£\(String(newData.raw.xrp.gbp.price))"
                        mcap.text = "£\(String(newData.raw.xrp.gbp.mktcap))"
                        high.text = "£\(String(newData.raw.xrp.gbp.high24Hour))"
                        low.text = "£\(String(newData.raw.xrp.gbp.low24Hour))"
                        delta.text = "£\(String(format: "%.2f", newData.raw.xrp.gbp.change24Hour))"
                        volume.text = "£\(String(newData.raw.xrp.gbp.totalvolume24Hto))"
                    case "BCH":
                        price.text = "£\(String(moreData.raw.bch.gbp.price))"
                        mcap.text = "£\(String(moreData.raw.bch.gbp.mktcap))"
                        high.text = "£\(String(moreData.raw.bch.gbp.high24Hour))"
                        low.text = "£\(String(moreData.raw.bch.gbp.low24Hour))"
                        delta.text = "£\(String(format: "%.2f", moreData.raw.bch.gbp.change24Hour))"
                        volume.text = "£\(String(moreData.raw.bch.gbp.totalvolume24Hto))"
                    case "BCN":
                        price.text = "£\(String(moreData.raw.bcn.gbp.price))"
                        mcap.text = "£\(String(moreData.raw.bcn.gbp.mktcap))"
                        high.text = "£\(String(moreData.raw.bcn.gbp.high24Hour))"
                        low.text = "£\(String(moreData.raw.bcn.gbp.low24Hour))"
                        delta.text = "£\(String(format: "%.2f", moreData.raw.bcn.gbp.change24Hour))"
                        volume.text = "£\(String(moreData.raw.bcn.gbp.totalvolume24Hto))"
                    case "ADA":
                        price.text = "£\(String(moreData.raw.ada.gbp.price))"
                        mcap.text = "£\(String(moreData.raw.ada.gbp.mktcap))"
                        high.text = "£\(String(moreData.raw.ada.gbp.high24Hour))"
                        low.text = "£\(String(moreData.raw.ada.gbp.low24Hour))"
                        delta.text = "£\(String(format: "%.2f", moreData.raw.ada.gbp.change24Hour))"
                        volume.text = "£\(String(moreData.raw.ada.gbp.totalvolume24Hto))"
                        
                    case "TRX":
                        price.text = "£\(String(moreData.raw.trx.gbp.price))"
                        mcap.text = "£\(String(moreData.raw.trx.gbp.mktcap))"
                        high.text = "£\(String(moreData.raw.trx.gbp.high24Hour))"
                        low.text = "£\(String(moreData.raw.trx.gbp.low24Hour))"
                        delta.text = "£\(String(format: "%.2f", moreData.raw.trx.usd.change24Hour))"
                        volume.text = "£\(String(moreData.raw.trx.gbp.totalvolume24Hto))"
                    default:
                        break
                        
                    }
                default:
                    break
                }
            }
        }
    }
}
