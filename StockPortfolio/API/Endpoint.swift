//
//  Endpoint.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 29/09/2020.
//

import Combine
import Foundation

struct Endpoint<Item: Decodable> {
    let provider: EndpointProvider
    let path: String
    let queryItems: [URLQueryItem]

    var urlRequest: URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = provider.host
        components.path = path
        components.queryItems = queryItems

        guard let url = components.url else {
            preconditionFailure("invalid URL")
        }
        var request = URLRequest(url: url)
        request.timeoutInterval = 15
        request.allHTTPHeaderFields = provider.headers
        return request
    }
}

extension Endpoint {
    static func get(symbols: [String]) -> Endpoint<[String: IEXQuoteDetail]> {
        Endpoint<[String: IEXQuoteDetail]>(provider: EndpointProvider.iexCloud, path: "/stable/stock/market/batch",
        queryItems: [
            URLQueryItem(name: "symbols", value: symbols.joined(separator: ",")),
            URLQueryItem(name: "types", value: "quote,logo"),
            URLQueryItem(name: "displayPercent", value: "true"),
            URLQueryItem(name: "token", value: EnvironmentValue.iexToken)
        ])
    }

    static func chart(from symbol: String, period: String, interval: String) -> Endpoint<[IEXChart]> {
        Endpoint<[IEXChart]>(provider: EndpointProvider.iexCloud, path: "/stable/stock/\(symbol)/chart/\(period)",
                             queryItems: [
            URLQueryItem(name: "chartCloseOnly", value: "true"),
            URLQueryItem(name: "chartInterval", value: interval),
            URLQueryItem(name: "token", value: EnvironmentValue.iexToken)
        ])
    }

    static func news(from symbol: String, items: Int) -> Endpoint<[IEXNews]> {
        Endpoint<[IEXNews]>(provider: EndpointProvider.iexCloud, path: "/stable/stock/\(symbol)/news/last/\(items)",
                            queryItems: [
            URLQueryItem(name: "token", value: EnvironmentValue.iexToken)
        ])
    }

    static func search(from text: String) -> Endpoint<[IEXSearchResult]> {
        Endpoint<[IEXSearchResult]>(provider: EndpointProvider.iexCloud, path: "/stable/search/\(text)", queryItems: [
            URLQueryItem(name: "token", value: EnvironmentValue.iexToken)
        ])
    }

    static func marketInfo(listType: String) -> Endpoint<[IEXQuote]> {
        Endpoint<[IEXQuote]>(provider: EndpointProvider.iexCloud, path: "/stable/stock/market/list/\(listType)",
                                   queryItems: [
            URLQueryItem(name: "token", value: EnvironmentValue.iexToken),
            URLQueryItem(name: "displayPercent", value: "true")
        ])
    }

    static func logo(from symbol: String) -> Endpoint<IEXLogo> {
        Endpoint<IEXLogo>(provider: EndpointProvider.iexCloud, path: "/stable/stock/\(symbol)/logo", queryItems: [
            URLQueryItem(name: "token", value: EnvironmentValue.iexToken)
        ])
    }

    static func logos(from symbols: [String]) -> Endpoint<[String: IEXLogoResponse]> {
        Endpoint<[String: IEXLogoResponse]>(provider: .iexCloud, path: "/stable/stock/market/batch",
        queryItems: [
            URLQueryItem(name: "symbols", value: symbols.joined(separator: ",")),
            URLQueryItem(name: "types", value: "logo"),
            URLQueryItem(name: "token", value: EnvironmentValue.iexToken)
        ])
    }

    static func companyDetail(from symbol: String) -> Endpoint<IEXCompanyDetail> {
        Endpoint<IEXCompanyDetail>(provider: EndpointProvider.iexCloud, path: "/stable/stock/\(symbol)/batch",
        queryItems: [
            URLQueryItem(name: "types", value: "news,company,stats,logo,quote,recommendation-trends,price-target"),
            URLQueryItem(name: "last", value: "5"),
            URLQueryItem(name: "displayPercent", value: "true"),
            URLQueryItem(name: "token", value: EnvironmentValue.iexToken)
        ])
    }
}
