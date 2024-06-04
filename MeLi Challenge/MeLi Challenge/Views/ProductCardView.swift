//
//  ProductCardView.swift
//  MeLi Challenge
//
//  Created by Felipe on 27/05/24.
//

import SwiftUI

struct ProductCardView: View {
    private let product: Product
    @State private var thumbnailImage: UIImage?
    
    var installmentsInfoString: String {
        "\(product.installmentsData.quantity)x \(product.installmentsData.amount.formatted(.currency(code: product.currencyId)))"
    }
    
    init(product: Product) {
        self.product = product
    }
    
    var body: some View {
        HStack(spacing: 0) {
            AsyncImage(
                url: URL(string: product.thumbnailURL.convertToHTTPS())
            ) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 120, height: 120)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                        .frame(maxWidth: 120, maxHeight: 120, alignment: .center)
                case .failure(let error):
                    defaultThumbnail
                        .task {
                            print(error)
                        }
                @unknown default:
                    defaultThumbnail
                }
            }
            
            VStack {
                Group {
                    Text(product.title)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.footnote)
                        .lineLimit(3)
                    
                    Spacer()

                    Text(product.price.formatted(.currency(code: product.currencyId)))
                        .bold()
                        .fontDesign(.rounded)
                    
                    Text("IN \(installmentsInfoString)")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    
                    if product.shippingData.freeShipping {
                        Text("FREE_SHIPPING_LABEL")
                            .font(.caption)
                            .bold()
                            .foregroundStyle(.green)
                    }
                }
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
        }
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(radius: 4)
        .fixedSize(horizontal: false, vertical: true)
    }
    
    var defaultThumbnail: some View {
        Image(systemName: "photo.on.rectangle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: 80, maxHeight: 80, alignment: .center)
            .padding()
            .foregroundStyle(.secondary)
            .opacity(0.7)
    }
}

#Preview {
    ProductCardView(product: Product.randomSample())
    .padding()
}
