//
//  ProductCardView.swift
//  MeLi Challenge
//
//  Created by Felipe on 27/05/24.
//

import SwiftUI

struct ProductCardView: View {
    private var productName: String
    
    init(productName: String = "") {
        self.productName = productName
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Rectangle()
                .fill(.gray)
                .frame(width: 100, height: 100)
            VStack {
                Text(productName.isEmpty ? String(localized: "PRODUCT_NAME_PLACEHOLDER") : productName)
                    .font(.footnote)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                Text("PRICE_PLACEHOLDER")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.horizontal)
            .padding(.vertical, 6)
        }
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(radius: 4)
        .frame(height: 100)
        .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    ProductCardView()
        .padding()
}
