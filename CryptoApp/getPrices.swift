//
//  getPrices.swift
//  CryptoApp
//
//  Created by Justin Grosvenor on 5/9/18.
//  Copyright © 2018 Justin Grosvenor. All rights reserved.
//

import Foundation
import CoreData

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
    
}


class GetPrices{
    var results: coin?
    func getBaseURL() -> URL{
        return URL(string: "https://min-api.cryptocompare.com/data/price")!
    }
    
    func getBitcoin(){
        
    }
    
    func setQuerySingle(_ coin: String) -> Dictionary<String, String>{
        let queryDictionary: [String : String] = ["fsym": coin, "tsyms": "USD"]
        return queryDictionary
    }
    
    func searchSingle(_ term: String) -> Double {
        let query = setQuerySingle(term)
        let newURL = getBaseURL().withQueries(query)
        print(newURL!)
        let task = URLSession.shared.dataTask(with: newURL!) { (data, response, error) in
            if let data = data {
                print(data)
                let jsonDecoder = JSONDecoder()
                if let res = try? jsonDecoder.decode(coin.self, from: data)
                {
                    print(res)
                    self.results = res
                    
                }
                else {
                    print("error")
                }
            }
        }
        task.resume()
        sleep(1)
        var cprice: Double = 0.0
        if let newResults = self.results{
            if let bprice = newResults.price{
                print("price unwrapped success")
                cprice = bprice
            }
        }
        return cprice
    }
}

struct coin: Codable {
    var price: Double?
  enum CodingKeys: String, CodingKey {
    case price = "USD"
  }
}



