//
//  GetMoreDetail.swift
//  CryptoApp
//
//  Created by Justin Grosvenor on 5/18/18.
//  Copyright © 2018 Justin Grosvenor. All rights reserved.
//

import Foundation

class getMoreData {
    var datas: Welcome2? = nil
    var url = URL(string: "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BCN,BCH,ADA,TRX&tsyms=USD,EUR,GBP")!

    func getData() {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                if let res = try? jsonDecoder.decode(Welcome2.self, from: data){
                    self.datas = res
                }
                }
            }
        task.resume()
        }
}

struct Welcome2: Codable {
    let raw: Raw2
    let display: Display2
    
    enum CodingKeys: String, CodingKey {
        case raw = "RAW"
        case display = "DISPLAY"
    }
}

struct Display2: Codable {
    let bcn: DisplayAda
    let bch: DisplayBch
    let ada, trx: DisplayAda
    
    enum CodingKeys: String, CodingKey {
        case bcn = "BCN"
        case bch = "BCH"
        case ada = "ADA"
        case trx = "TRX"
    }
}

struct DisplayAda: Codable {
    let usd: [String: String]
    let eur, gbp: PurpleEur
    
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case eur = "EUR"
        case gbp = "GBP"
    }
}

struct PurpleEur: Codable {
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

struct DisplayBch: Codable {
    let usd, eur: [String: String]
    let gbp: PurpleEur
    
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case eur = "EUR"
        case gbp = "GBP"
    }
}

struct Raw2: Codable {
    let bcn: RawAda
    let bch: RawBch
    let ada, trx: RawAda
    
    enum CodingKeys: String, CodingKey {
        case bcn = "BCN"
        case bch = "BCH"
        case ada = "ADA"
        case trx = "TRX"
    }
}

struct RawAda: Codable {
    let usd: Usd
    let eur, gbp: FluffyEur
    
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case eur = "EUR"
        case gbp = "GBP"
    }
}

struct FluffyEur: Codable {
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

struct Usd: Codable {
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

struct RawBch: Codable {
    let usd, eur: Usd
    let gbp: FluffyEur
    
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case eur = "EUR"
        case gbp = "GBP"
    }
}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? JSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
    

}

