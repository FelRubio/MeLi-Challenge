//
//  ProductDetailView.swift
//  MeLi Challenge
//
//  Created by Felipe on 27/05/24.
//

import SwiftUI

struct ProductDetailView: View {
    private let images: [Color] = [.gray, .blue, .red] // Placeholder data
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    // Product name
                    Text("PRODUCT_NAME_PLACEHOLDER")
                        .font(.title3)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Scrollable images
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 10) {
                            ForEach(images, id: \.self) { color in
                                Rectangle()
                                    .fill(color.opacity(0.8))
                                    .containerRelativeFrame(.horizontal)
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .frame(height: geometry.size.width)
                    
                    // TODO: Product details
                    Text("Product details:")
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                .padding([.horizontal, .bottom])
            }
        }

    }
}

#Preview {
    ProductDetailView()
}
