//
//  ProductAttributeView.swift
//  MeLi Challenge
//
//  Created by Felipe on 30/05/24.
//

import SwiftUI

struct ProductAttributeView: View {
    let attribute: ProductAttribute
    
    init(attribute: ProductAttribute) {
        self.attribute = attribute
    }
    
    var body: some View {
        HStack(alignment: .top) {
            Text(attribute.name)
                .bold()
                .frame(width: 100, alignment: .leading) // Fixed width for the name
                .multilineTextAlignment(.leading)
            
            Text(attribute.value)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .center) // Flexible width for the value
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    ProductAttributeView(attribute: .init(id: UUID().uuidString, name: "Brand", value: "Generic brand"))
}
