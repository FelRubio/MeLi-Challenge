//
//  ShippingDataView.swift
//  MeLi Challenge
//
//  Created by Felipe on 30/05/24.
//

import SwiftUI

struct ShippingDataView: View {
    let shippingData: ShippingData
    
    var alignment: Alignment = .leading
    var textAlignment: TextAlignment = .leading
    
    init(shippingData: ShippingData) {
        self.shippingData = shippingData
    }
    
    var body: some View {
        VStack {
            if shippingData.freeShipping {
                Text("FREE_SHIPPING_LABEL")
                    .font(.headline)
                    .foregroundStyle(.green)
                    .multilineTextAlignment(textAlignment)
                    .frame(maxWidth: .infinity, alignment: alignment)
            }
            
            if shippingData.storePickUp {
                Text("STORE_PICK_UP_LABEL")
                    .font(.footnote)
                    .multilineTextAlignment(textAlignment)
                    .frame(maxWidth: .infinity, alignment: alignment)
            }
        }
    }
}

extension ShippingDataView {
    func alignment(_ alignment: Alignment) -> Self {
        var copy = self
        copy.alignment = alignment
        return copy
    }
    
    func multilineTextAlignment(_ textAlignment: TextAlignment) -> Self {
        var copy = self
        copy.textAlignment = textAlignment
        return copy
    }
}

#Preview {
    ShippingDataView(shippingData: .init(storePickUp: true, freeShipping: true))
}
