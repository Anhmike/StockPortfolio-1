//
//  CompanyBodyView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 13/10/2020.
//

import Foundation
import SwiftUI

struct CompanySummaryView: View {
    
    let companyDetail: CompanyDetail

    var companyInfo: [(key: String, image: String, value: String)] {  [
        ("Symbol", "textformat.abc", companyDetail.company.symbol),
        ("Exchange", "dollarsign.square", companyDetail.company.exchange),
        ("Industry", "wrench", companyDetail.company.industry),
        ("CEO", "figure.wave", companyDetail.company.ceo),
        ("Employees", "person.3", companyDetail.company.employees.description),
        ("Country", "flag", companyDetail.company.country),
    ] }

    let rows: [GridItem] =  [
        GridItem(.flexible())
    ]

    var body: some View {
        List {
            HStack {
                RemoteImage(url: companyDetail.logo)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
                    .border(Color.Stock.gray, width: 10)

                HStack {
                    Spacer()
                    VStack(alignment: .leading) {
                        Text(companyDetail.quote.companyName).font(.title)
                        Text("$" + companyDetail.quote.latestPrice.round2())
                            .font(.title).bold()
                        HStack {
                            Text(companyDetail.quote.gainLossString)
                            Text("(" + companyDetail.quote.percentageString + ")")
                        }.foregroundColor(companyDetail.quote.change >= 0 ? Color.Stock.green : Color.Stock.red)
                        Text(companyDetail.quote.latestUpdateString).font(.caption)
                    }
                    Spacer()
                }
            }

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows) {
                    if let tags = companyDetail.company.tags {
                        ForEach(tags, id: \.self) { tag in
                            Text(tag)
                                .padding(8)
                                .background(
                                    RoundedRectangle(cornerRadius: 16).fill(Color.Stock.gray)
                                ).font(.footnote)
                                .foregroundColor(.white)
                        }
                    }
                }
            }.padding(.vertical)


            Section(header: Text("About")) {
                Text(companyDetail.company.description)
                    .padding(.bottom)
            }
            Section(header: Text("Company details")) {
                ForEach(companyInfo, id: \.self.0) { companyInfo in
                    HStack(alignment: .top, spacing: 4) {
                        Text("\(companyInfo.key): ")
                        Text("\(companyInfo.value)").bold()
                    }
                }
            }
        }
    }
}

struct CompanyBodyView_Previews: PreviewProvider {
    static var previews: some View {
        CompanySummaryView(companyDetail: .random)
    }


}
