//
//  CompanyDetail.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 14/10/2020.
//

import Foundation

struct CompanyDetail {
    let company: Company
    let news: [News]
    let stats: Stats
    let logo: URL
    let quote: Quote
}

extension CompanyDetail {
    init(companyDetail: IEXCompanyDetail) {
        company = Company(iexCompany: companyDetail.company)
        stats = Stats(stats: companyDetail.stats)
        news = companyDetail.news.map(News.init(news:))
        logo = companyDetail.logo.url
        quote = Quote(quote: companyDetail.quote)
    }

    static let random = CompanyDetail(company: .random,
                                      news: [.random, .random, .random],
                                      stats: .random,
                                      logo: .random,
                                      quote: .random)
}