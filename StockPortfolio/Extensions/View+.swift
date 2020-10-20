//
//  View+.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 01/10/2020.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
