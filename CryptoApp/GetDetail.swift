//
//  GetDetail.swift
//  CryptoApp
//
//  Created by Justin Grosvenor on 5/15/18.
//  Copyright © 2018 Justin Grosvenor. All rights reserved.
//

import Foundation

class GetDetail {
    var results: Welcome?
    func getBaseURL() -> URL{
        return URL(string: "https://min-api.cryptocompare.com/data/pricemultifull")!
    }

    func setQueryDetail() -> Dictionary<String, String>{
        let queryDictionary: [String : String] = ["fsyms": "BTC,LTC,ETH,XRP,EOS", "tsyms": "USD,GBP,EUR"]
        return queryDictionary
    }

    func searchDetails() {
        let query = setQueryDetail()
        let newURL = getBaseURL().withQueries(query)
        print(newURL!)
        let task = URLSession.shared.dataTask(with: newURL!) { (data, response, error) in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                if let res = try? jsonDecoder.decode(Welcome.self, from: data)
                {
                    //print(res)
                    self.results = res
                }
                else {
                    print(error as Any)
                }
            }
        }
        task.resume()
    }



}


struct Welcome: Codable {
    let raw: Raw
    let display: Display
    
    enum CodingKeys: String, CodingKey {
        case raw = "RAW"
        case display = "DISPLAY"
    }
}

struct Display: Codable {
    let btc, ltc: DisplayBtc
    let eth, xrp: DisplayEth
    let eos: DisplayBtc
    
    enum CodingKeys: String, CodingKey {
        case btc = "BTC"
        case ltc = "LTC"
        case eth = "ETH"
        case xrp = "XRP"
        case eos = "EOS"
    }
}

struct DisplayBtc: Codable {
    let usd, gbp, eur: [String: String]
    
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case gbp = "GBP"
        case eur = "EUR"
    }
}

struct DisplayEth: Codable {
    let usd: [String: String]
    let gbp: PurpleGBP
    let eur: [String: String]
    
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case gbp = "GBP"
        case eur = "EUR"
    }
}

struct PurpleGBP: Codable {
    let fromsymbol, tosymbol, market, price: String
    let lastupdate, lastvolume, lastvolumeto: String
    let lasttradeid: Int
    let volumeday, volumedayto, volume24Hour, volume24Hourto: String
    let openday, highday, lowday, open24Hour: String
    let high24Hour, low24Hour, lastmarket, change24Hour: String
    let changepct24Hour, changeday, changepctday, supply: String
    let mktcap, totalvolume24H, totalvolume24Hto: String
    
    enum CodingKeys: String, CodingKey {
        case fromsymbol = "FROMSYMBOL"
        case tosymbol = "TOSYMBOL"
        case market = "MARKET"
        case price = "PRICE"
        case lastupdate = "LASTUPDATE"
        case lastvolume = "LASTVOLUME"
        case lastvolumeto = "LASTVOLUMETO"
        case lasttradeid = "LASTTRADEID"
        case volumeday = "VOLUMEDAY"
        case volumedayto = "VOLUMEDAYTO"
        case volume24Hour = "VOLUME24HOUR"
        case volume24Hourto = "VOLUME24HOURTO"
        case openday = "OPENDAY"
        case highday = "HIGHDAY"
        case lowday = "LOWDAY"
        case open24Hour = "OPEN24HOUR"
        case high24Hour = "HIGH24HOUR"
        case low24Hour = "LOW24HOUR"
        case lastmarket = "LASTMARKET"
        case change24Hour = "CHANGE24HOUR"
        case changepct24Hour = "CHANGEPCT24HOUR"
        case changeday = "CHANGEDAY"
        case changepctday = "CHANGEPCTDAY"
        case supply = "SUPPLY"
        case mktcap = "MKTCAP"
        case totalvolume24H = "TOTALVOLUME24H"
        case totalvolume24Hto = "TOTALVOLUME24HTO"
    }
}

struct Raw: Codable {
    let btc, ltc: RawBtc
    let eth, xrp: RawEth
    let eos: RawBtc
    
    enum CodingKeys: String, CodingKey {
        case btc = "BTC"
        case ltc = "LTC"
        case eth = "ETH"
        case xrp = "XRP"
        case eos = "EOS"
    }
}

struct RawBtc: Codable {
    let usd, gbp, eur: Eur
    
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case gbp = "GBP"
        case eur = "EUR"
    }
}

struct Eur: Codable {
    let type: String
    let market: Market
    let fromsymbol: String
    let tosymbol: Tosymbol
    let flags: String
    let price: Double
    let lastupdate: Int
    let lastvolume, lastvolumeto: Double
    let lasttradeid: String
    let volumeday, volumedayto, volume24Hour, volume24Hourto: Double
    let openday, highday, lowday, open24Hour: Double
    let high24Hour, low24Hour: Double
    let lastmarket: String
    let change24Hour, changepct24Hour, changeday, changepctday: Double
    let supply, mktcap, totalvolume24H, totalvolume24Hto: Double
    
    enum CodingKeys: String, CodingKey {
        case type = "TYPE"
        case market = "MARKET"
        case fromsymbol = "FROMSYMBOL"
        case tosymbol = "TOSYMBOL"
        case flags = "FLAGS"
        case price = "PRICE"
        case lastupdate = "LASTUPDATE"
        case lastvolume = "LASTVOLUME"
        case lastvolumeto = "LASTVOLUMETO"
        case lasttradeid = "LASTTRADEID"
        case volumeday = "VOLUMEDAY"
        case volumedayto = "VOLUMEDAYTO"
        case volume24Hour = "VOLUME24HOUR"
        case volume24Hourto = "VOLUME24HOURTO"
        case openday = "OPENDAY"
        case highday = "HIGHDAY"
        case lowday = "LOWDAY"
        case open24Hour = "OPEN24HOUR"
        case high24Hour = "HIGH24HOUR"
        case low24Hour = "LOW24HOUR"
        case lastmarket = "LASTMARKET"
        case change24Hour = "CHANGE24HOUR"
        case changepct24Hour = "CHANGEPCT24HOUR"
        case changeday = "CHANGEDAY"
        case changepctday = "CHANGEPCTDAY"
        case supply = "SUPPLY"
        case mktcap = "MKTCAP"
        case totalvolume24H = "TOTALVOLUME24H"
        case totalvolume24Hto = "TOTALVOLUME24HTO"
    }
}

enum Market: String, Codable {
    case cccagg = "CCCAGG"
}

enum Tosymbol: String, Codable {
    case eur = "EUR"
    case gbp = "GBP"
    case usd = "USD"
}

struct RawEth: Codable {
    let usd: Eur
    let gbp: FluffyGBP
    let eur: Eur
    
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case gbp = "GBP"
        case eur = "EUR"
    }
}

struct FluffyGBP: Codable {
    let type, market, fromsymbol, tosymbol: String
    let flags: String
    let price: Double
    let lastupdate, lastvolume, lastvolumeto, lasttradeid: Int
    let volumeday, volumedayto: Int
    let volume24Hour, volume24Hourto, openday, highday: Double
    let lowday, open24Hour, high24Hour, low24Hour: Double
    let lastmarket: String
    let change24Hour, changepct24Hour, changeday, changepctday: Double
    let supply, mktcap, totalvolume24H, totalvolume24Hto: Double
    
    enum CodingKeys: String, CodingKey {
        case type = "TYPE"
        case market = "MARKET"
        case fromsymbol = "FROMSYMBOL"
        case tosymbol = "TOSYMBOL"
        case flags = "FLAGS"
        case price = "PRICE"
        case lastupdate = "LASTUPDATE"
        case lastvolume = "LASTVOLUME"
        case lastvolumeto = "LASTVOLUMETO"
        case lasttradeid = "LASTTRADEID"
        case volumeday = "VOLUMEDAY"
        case volumedayto = "VOLUMEDAYTO"
        case volume24Hour = "VOLUME24HOUR"
        case volume24Hourto = "VOLUME24HOURTO"
        case openday = "OPENDAY"
        case highday = "HIGHDAY"
        case lowday = "LOWDAY"
        case open24Hour = "OPEN24HOUR"
        case high24Hour = "HIGH24HOUR"
        case low24Hour = "LOW24HOUR"
        case lastmarket = "LASTMARKET"
        case change24Hour = "CHANGE24HOUR"
        case changepct24Hour = "CHANGEPCT24HOUR"
        case changeday = "CHANGEDAY"
        case changepctday = "CHANGEPCTDAY"
        case supply = "SUPPLY"
        case mktcap = "MKTCAP"
        case totalvolume24H = "TOTALVOLUME24H"
        case totalvolume24Hto = "TOTALVOLUME24HTO"
    }
}
