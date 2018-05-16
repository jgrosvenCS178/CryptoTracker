//
//  GetDetail.swift
//  CryptoApp
//
//  Created by Justin Grosvenor on 5/15/18.
//  Copyright © 2018 Justin Grosvenor. All rights reserved.
//

import Foundation

class GetDetail {

    func getBaseURL() -> URL{
        return URL(string: "https://min-api.cryptocompare.com/data/pricemultifull")!
    }

    func setQuerySingle(_ coin: String) -> Dictionary<String, String>{
        let queryDictionary: [String : String] = ["fsyms": "BTC,LTC,ETH,XRP,EOS", "tsyms": "USD,GBP,EUR,AUS"]
        return queryDictionary
    }





}


struct dataContainer {
    var raw: String?
    var rawObject: [String: [String: AnyObject]]
}

