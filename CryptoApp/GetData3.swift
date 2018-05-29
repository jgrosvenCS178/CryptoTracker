//
//  GetData3.swift
//  CryptoApp
//
//  Created by Justin Grosvenor on 5/28/18.
//  Copyright © 2018 Justin Grosvenor. All rights reserved.
//

import Foundation
class getData3 {
    
    var data3: Xlmtoxmr? = nil
    var url = URL(string: "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=XLM,XMR,NEO,DASH,XEM&tsyms=USD,EUR,GBP")!
    
   
    func getData() {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
                if let res = try? jsonDecoder.decode(Xlmtoxmr.self, from: data){
                    self.data3 = res
                }
            }
        }
        task.resume()
    }
}

struct Xlmtoxmr: Codable {
    let raw: Raw3
    let display: Display3
    
    enum CodingKeys: String, CodingKey {
        case raw = "RAW"
        case display = "DISPLAY"
    }
}

struct Display3: Codable {
    let xlm, xmr, neo, dash: DisplayDash
    let xem: DisplayXem
    
    enum CodingKeys: String, CodingKey {
        case xlm = "XLM"
        case xmr = "XMR"
        case neo = "NEO"
        case dash = "DASH"
        case xem = "XEM"
    }
}

struct DisplayDash: Codable {
    let usd, eur: [String: String]
    let gbp: PurpleGbp
    
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case eur = "EUR"
        case gbp = "GBP"
    }
}

struct PurpleGbp: Codable {
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

struct DisplayXem: Codable {
    let usd: [String: String]
    let eur, gbp: PurpleGbp
    
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case eur = "EUR"
        case gbp = "GBP"
    }
}

struct Raw3: Codable {
    let xlm, xmr, neo, dash: RawDash
    let xem: RawXem
    
    enum CodingKeys: String, CodingKey {
        case xlm = "XLM"
        case xmr = "XMR"
        case neo = "NEO"
        case dash = "DASH"
        case xem = "XEM"
    }
}

struct RawDash: Codable {
    let usd, eur: Eur3
    let gbp: FluffyGbp
    
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case eur = "EUR"
        case gbp = "GBP"
    }
}

struct Eur3: Codable {
    let type, market, fromsymbol, tosymbol: String
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

struct FluffyGbp: Codable {
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

struct RawXem: Codable {
    let usd: Eur
    let eur, gbp: FluffyGbp
    
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case eur = "EUR"
        case gbp = "GBP"
    }
}
