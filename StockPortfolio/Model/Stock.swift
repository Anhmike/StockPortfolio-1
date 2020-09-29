//
//  Stock.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 28/09/2020.
//

import Foundation

struct Stock {
    let symbol: String
    let companyName: String
    let latestPrice: Double
    let previousClose: Double
    let logo: URL
    let news: [News]

    var percentage: Double {
        (latestPrice - previousClose) * 100 / previousClose
    }

    struct News: Identifiable {
        let headline: String
        let source: String
        let url: URL
        let summary: String
        var id: String { headline }
    }
}
