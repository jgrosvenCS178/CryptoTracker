//
//  Coins.swift
//  CryptoApp
//
//  Created by Justin Grosvenor on 5/29/18.
//  Copyright © 2018 Justin Grosvenor. All rights reserved.
//

import Foundation
import UIKit

class CoinList {
    // 1=bitcoin 2=litecoin 3=EOS 4=ETH 5=XRP 6=BCH 7=BCN
    let logos: [UIImage] = [#imageLiteral(resourceName: "btc"),#imageLiteral(resourceName: "ltc"),#imageLiteral(resourceName: "eos"),#imageLiteral(resourceName: "eth"),#imageLiteral(resourceName: "xrp"),#imageLiteral(resourceName: "bch"),#imageLiteral(resourceName: "bcn"),#imageLiteral(resourceName: "ada"),#imageLiteral(resourceName: "trx"),#imageLiteral(resourceName: "xlm"),#imageLiteral(resourceName: "xmr"),#imageLiteral(resourceName: "neo"),#imageLiteral(resourceName: "dash"),#imageLiteral(resourceName: "xem")]
    let symbols: [String] = ["BTC", "LTC", "EOS", "ETH", "XRP", "BCH", "BCN", "ADA", "TRX", "XLM", "XMR", "NEO", "DASH", "XEM"]
    let names: [String] = ["BITCOIN", "LITECOIN", "EOS", "ETHERIUM", "RIPPLE", "BITCOIN CASH", "BYTECOIN", "CARDANO", "TRON", "STELLAR", "MONERO", "NEO", "DASH", "NEM"]

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


    



}
