//
//  PriceViewController.swift
//  CryptoApp
//
//  Created by Justin Grosvenor on 5/22/18.
//  Copyright © 2018 Justin Grosvenor. All rights reserved.
//

import UIKit

class PriceViewController: UITableViewController {

    private let getDetail = GetDetail()
    private let getMore = getMoreData()
    private let Data3 = getData3()
    private var newData: Welcome? = nil
    private var moreData: Welcome2? = nil
    private var data3: Xlmtoxmr?
    private var dataSuccess: Bool = false
    
    // PRICES: [usd,eur,gbp]
    var prices: [[String]] = []
    
    var btcp: [String] = []
    var ltcp: [String] = []
    var ethp: [String] = []
    var eosp: [String] = []
    var xrpp: [String] = []
    var bchp: [String] = []
    var bcnp: [String] = []
    var adap: [String] = []
    var trxp: [String] = []
    var xlmp: [String] = []
    var xmrp: [String] = []
    var neop: [String] = []
    var dashp: [String] = []
    var xemp: [String] = []
    // [0=usd,1=eur,2=gbp]
    var fiat: Int = 0
    
    
    // 1=bitcoin 2=litecoin 3=EOS 4=ETH 5=XRP 6=BCH 7=BCN
    let logos: [UIImage] = [#imageLiteral(resourceName: "btc"),#imageLiteral(resourceName: "ltc"),#imageLiteral(resourceName: "eos"),#imageLiteral(resourceName: "eth"),#imageLiteral(resourceName: "xrp"),#imageLiteral(resourceName: "bch"),#imageLiteral(resourceName: "bcn"),#imageLiteral(resourceName: "ada"),#imageLiteral(resourceName: "trx"),#imageLiteral(resourceName: "xlm"),#imageLiteral(resourceName: "xmr"),#imageLiteral(resourceName: "neo"),#imageLiteral(resourceName: "dash"),#imageLiteral(resourceName: "xem")]
    let symbols: [String] = ["BTC", "LTC", "EOS", "ETH", "XRP", "BCH", "BCN", "ADA", "TRX", "XLM", "XMR", "NEO", "DASH", "XEM"]
    let names: [String] = ["BITCOIN", "LITECOIN", "EOS", "ETHERIUM", "RIPPLE", "BITCOIN CASH", "BYTECOIN", "CARDANO", "TRON", "STELLAR", "MONERO", "NEO", "DASH", "NEM"]
    
 
    ///////////////////////////
    // MARK: -  GET DATA
    /////////

    @objc
    func requestData() -> Bool {
        getDetail.searchDetails()
        getMore.getData()
        Data3.getData()
        usleep(300000)
        if let thisData = getDetail.results {
            newData = thisData
            print("data success first first")
            if setMoreData(){
                dataSuccess = true
            }
            return dataSuccess
        }
        else {
            usleep(1500000)
            if let thisData = getDetail.results {
                newData = thisData
                print("data success second try")
                if setMoreData(){
                    dataSuccess = true
                }
                dataSuccess = true
                return dataSuccess
            }
            else {
                print("inner fail")
                sleep(4)
                if let thisData = getDetail.results {
                    newData = thisData
                    print("data success third try")
                    if setMoreData(){
                        dataSuccess = true
                    }
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
        usleep(200000)
        if let thisMoreData = getMore.datas {
            moreData = thisMoreData
            print("more data success second dump")
            if setData3(){
                dataSuccess = true
            }
            return dataSuccess
        }
        else {
            usleep(1500000)
            if let thisMoreData = getMore.datas {
                moreData = thisMoreData
                print("data success second try second dump")
                if setData3(){
                    dataSuccess = true
                }
                return dataSuccess
            }
            else {
                print("inner fail")
                sleep(4)
                if let thisMoreData = getMore.datas {
                    moreData = thisMoreData
                    print("data success third try second dump")
                    if setData3(){
                        dataSuccess = true
                    }
                    return dataSuccess
                }
                else {
                    print("Data3 Failure")
                    dataSuccess = false
                    return dataSuccess
                }
            }
        }
        
    }
    func setData3() -> Bool {
        usleep(200000)
        if let thisData3 = Data3.data3 {
            data3 = thisData3
            dataSuccess = true
            print("more data3 success second dump")
            checkData()
            return dataSuccess
        }
        else {
            usleep(1500000)
            if let thisData3 = Data3.data3 {
                data3 = thisData3
                dataSuccess = true
                print("data3 success second try second dump")
                checkData()
                return dataSuccess
            }
            else {
                print("inner fail3")
                sleep(4)
                if let thisData3 = Data3.data3 {
                    data3 = thisData3
                    dataSuccess = true
                    print("data3 success third try second dump")
                    checkData()
                    return dataSuccess
                }
                else {
                    print("Data3 Failure second dump")
                    dataSuccess = false
                    return dataSuccess
                }
            }
        }
        
    }
    
    ///////////////////////////
    // MARK: -  CHECKDATA
    /////////
    func checkData(){
        if dataSuccess{
            refreshController.endRefreshing()
            makePriceList()
            //print(prices)
            self.tableView.reloadData()
            //print("checkdata executed")
        }
    }
    

    
    ///////////////////////////
    // MARK: -  REFRESH CONTROLLER
    /////////
    
    lazy var refreshController: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(requestData), for: .valueChanged)
        return refreshControl
    }()
    
    
    ///////////////////////////
    // MARK: -  VIEW DID LOAD
    /////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Pull Down Refresh
        tableView.refreshControl = refreshController
        if requestData() {
            print("data success prices")
            print(prices)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    ///////////////////////////
    // MARK: -  FIAT CONTROLLER
    /////////
    
    @IBOutlet weak var fiatController: UISegmentedControl!
    @IBAction func fiatControl(_ sender: Any) {
        switch (sender as AnyObject).selectedSegmentIndex {
        case 0:
            fiat = 0
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        case 1:
            fiat = 1
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        case 2:
            fiat = 2
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        default:
            break
        }
        
    }
    
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return prices.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coinPrice", for: indexPath)
        
        if prices[indexPath.row].count > 0 {
            let price = prices[indexPath.row][fiat]
            cell.textLabel?.text = names[indexPath.row]
            cell.detailTextLabel?.text = price
            cell.imageView?.image = logos[indexPath.row]
        }
        else {
            print("index error in prices")
        }
        // Configure the cell...

        return cell
    }
    
    func makePriceList() {
        prices = []
        btcp = getBTCP()
        ltcp = getLTCP()
        eosp = getEOSP()
        ethp = getETHP()
        xrpp = getXRPP()
        bchp = getBCHP()
        bcnp = getBCNP()
        adap = getADAP()
        trxp = getTRXP()
        xlmp = getXLMP()
        xmrp = getXMRP()
        neop = getNEOP()
        dashp = getDASHP()
        xemp = getXEMP()
        prices.append(btcp)
        prices.append(ltcp)
        prices.append(eosp)
        prices.append(ethp)
        prices.append(xrpp)
        prices.append(bchp)
        prices.append(bcnp)
        prices.append(adap)
        prices.append(trxp)
        prices.append(xlmp)
        prices.append(xmrp)
        prices.append(neop)
        prices.append(dashp)
        prices.append(xemp)
    }
    
    func getBTCP() -> [String] {
        var prices: [String] = []
        if let newData = newData {
            prices.append("$\(newData.raw.btc.usd.price)")
            prices.append("€\(newData.raw.btc.eur.price)")
            prices.append("£\(newData.raw.btc.gbp.price)")
        }
        return prices
    }
    
    func getLTCP() -> [String] {
        var prices: [String] = []
        if let newData = newData {
            prices.append("$\(newData.raw.ltc.usd.price)")
            prices.append("€\(newData.raw.ltc.eur.price)")
            prices.append("£\(newData.raw.ltc.gbp.price)")
        }
        return prices
    }
    
    
    func getETHP() -> [String] {
        var prices: [String] = []
        if let newData = newData {
            prices.append("$\(newData.raw.eth.usd.price)")
            prices.append("€\(newData.raw.eth.eur.price)")
            prices.append("£\(newData.raw.eth.gbp.price)")
        }
        return prices
    }
    
    func getEOSP() -> [String] {
        var prices: [String] = []
        if let newData = newData {
            prices.append("$\(newData.raw.eos.usd.price)")
            prices.append("€\(newData.raw.eos.eur.price)")
            prices.append("£\(newData.raw.eos.gbp.price)")
        }
        return prices
    }
    
    func getXRPP() -> [String] {
        var prices: [String] = []
        if let newData = newData {
            prices.append("$\(newData.raw.xrp.usd.price)")
            prices.append("€\(newData.raw.xrp.eur.price)")
            prices.append("£\(newData.raw.xrp.gbp.price)")
        }
        return prices
    }
    
    func getBCHP() -> [String] {
        var prices: [String] = []
        if let moreData = moreData {
            prices.append("$\(moreData.raw.bch.usd.price)")
            prices.append("€\(moreData.raw.bch.eur.price)")
            prices.append("£\(moreData.raw.bch.gbp.price)")
        }
        return prices
    }
    
    func getBCNP() -> [String] {
        var prices: [String] = []
        if let moreData = moreData {
            prices.append("$\(moreData.raw.bcn.usd.price)")
            prices.append("€\(moreData.raw.bcn.eur.price)")
            prices.append("£\(moreData.raw.bcn.gbp.price)")
        }
        return prices
    }
    
    func getADAP() -> [String] {
        var prices: [String] = []
        if let moreData = moreData {
            prices.append("$\(moreData.raw.ada.usd.price)")
            prices.append("€\(moreData.raw.ada.eur.price)")
            prices.append("£\(moreData.raw.ada.gbp.price)")
        }
        return prices
    }
    
    func getTRXP() -> [String] {
        var prices: [String] = []
        if let moreData = moreData {
            prices.append("$\(moreData.raw.trx.usd.price)")
            prices.append("€\(moreData.raw.trx.eur.price)")
            prices.append("£\(moreData.raw.trx.gbp.price)")
        }
        return prices
    }
    
    func getXLMP() -> [String] {
        var prices: [String] = []
        if let data3 = data3 {
            prices.append("$\(data3.raw.xlm.usd.price)")
            prices.append("€\(data3.raw.xlm.eur.price)")
            prices.append("£\(data3.raw.xlm.gbp.price)")
        }
        return prices
    }
    
    func getXMRP() -> [String] {
        var prices: [String] = []
        if let data3 = data3 {
            prices.append("$\(data3.raw.xmr.usd.price)")
            prices.append("€\(data3.raw.xmr.eur.price)")
            prices.append("£\(data3.raw.xmr.gbp.price)")
        }
        return prices
    }
    
    func getNEOP() -> [String] {
        var prices: [String] = []
        if let data3 = data3 {
            prices.append("$\(data3.raw.neo.usd.price)")
            prices.append("€\(data3.raw.neo.eur.price)")
            prices.append("£\(data3.raw.neo.gbp.price)")
        }
        return prices
    }
    
    func getDASHP() -> [String] {
        var prices: [String] = []
        if let data3 = data3 {
            prices.append("$\(data3.raw.dash.usd.price)")
            prices.append("€\(data3.raw.dash.eur.price)")
            prices.append("£\(data3.raw.dash.gbp.price)")
        }
        return prices
    }
    
    func getXEMP() -> [String] {
        var prices: [String] = []
        if let data3 = data3 {
            prices.append("$\(data3.raw.xem.usd.price)")
            prices.append("€\(data3.raw.xem.eur.price)")
            prices.append("£\(data3.raw.xem.gbp.price)")
        }
        return prices
    }
    
    
    
    
    
    
    
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
