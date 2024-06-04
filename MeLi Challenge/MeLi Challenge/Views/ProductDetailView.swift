//
//  ProductDetailView.swift
//  MeLi Challenge
//
//  Created by Felipe on 27/05/24.
//

import SwiftUI

struct ProductDetailView: View {
    @ObservedObject private var viewModel: ProductDetailViewModel
    
    init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Group {
            if viewModel.viewState != .processing {
                if let error = viewModel.error {
                    ProductErrorView(error: error) {
                        Task {
                            await setup()
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                } else {
                    contentView
                }
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
        .task {
            await setup()
        }
    }
    
    var contentView: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Group {
                        // Product name
                        Text(viewModel.productName)
                            .font(.title3)
                        // Condition
                        Text(viewModel.product.condition)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Divider()
                    
                    // Scrollable images
                    productImages
                        .frame(height: geometry.size.width)
                    
                    Divider()
                    
                    // Pricing data
                    if viewModel.hasDiscount {
                        Text(viewModel.discountedPrice)
                            .fontDesign(.rounded)
                            .foregroundStyle(.secondary)
                            .strikethrough()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    HStack {
                        Text(viewModel.productPrice)
                            .font(.title)
                            .fontDesign(.rounded)
                        
                        if viewModel.hasDiscount {
                            Text("\(viewModel.discountedPercentage.formatted(.percent)) OFF")
                                .bold()
                                .foregroundStyle(.green)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("IN \(viewModel.installmentsInfoString)")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom)
                        

                    // Shipping information
                    ShippingDataView(shippingData: viewModel.product.shippingData)
                        .alignment(.leading)
                        .multilineTextAlignment(.leading)
                    
                    Divider()
                    
                    // Description
                    if let description = viewModel.productDetail?.description {
                        Text("DESCRIPTION")
                            .font(.title2)
                            .bold()
                            .fontDesign(.rounded)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(description)
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Divider()
                    }
                    
                    // Characteristics list
                    Text("CHARATACTERISTICS")
                        .font(.title2)
                        .bold()
                        .fontDesign(.rounded)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if let attributes = viewModel.productDetail?.attributes {
                        ForEach(attributes) { attribute in
                            ProductAttributeView(attribute: attribute)
                                .padding()
                            
                            Divider()
                        }
                    } else {
                        Text("NO_CHARACTERISTICS_FOUND")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .refreshable {
                await setup()
            }
        }
    }
    
    var defaultThumbnail: some View {
        Image(systemName: "photo.on.rectangle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
            .foregroundStyle(.secondary)
            .opacity(0.7)
    }
    
    var productImages: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(viewModel.productImages, id: \.self) { image in
                    AsyncImage(url: image) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .containerRelativeFrame(.horizontal)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .containerRelativeFrame(.horizontal)
                        case .failure(_):
                            defaultThumbnail
                                .containerRelativeFrame(.horizontal)
                        @unknown default:
                            defaultThumbnail
                                .containerRelativeFrame(.horizontal)
                        }
                    }
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
    }
    
    private func setup() async {
        do {
            withAnimation {
                viewModel.viewState = .processing
                viewModel.error = nil
            }
            try await viewModel.setProductDetail()
            withAnimation {
                viewModel.viewState = .idle
            }
        } catch {
            withAnimation {
                viewModel.error = error
                viewModel.viewState = .idle
            }
        }
    }
}

#Preview {
    ProductDetailView(
        viewModel: .init(
            product: .randomSample(),
            productService: ProductService(repository: MockUpProductRepository())
        )
    )
}
