//
//  getPrices.swift
//  CryptoApp
//
//  Created by Justin Grosvenor on 5/9/18.
//  Copyright © 2018 Justin Grosvenor. All rights reserved.
//

import Foundation
import CoreData

class GetPrices{
    
    func getBaseURL() -> URL{
        return URL(string: "https://min-api.cryptocompare.com/data/price?")!
    }
    
    func getBitcoin(){
        
    }
    
    func setQuery(_ coin: String) -> Dictionary<String, String>{
        let search_term: String = coin
        
        let queryDictionary: [String : String] = ["fsym=": search_term,
                                                  "&tsyms=": "USD"]
        return queryDictionary
    }
}

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}
