//
//  ProductDetailViewModel.swift
//  MeLi Challenge
//
//  Created by Felipe on 30/05/24.
//

import Foundation

public class ProductDetailViewModel: ObservableObject {
    @MainActor @Published var productDetail: ProductDetail?
    @MainActor @Published var viewState: ViewState = .processing
    @MainActor @Published var error: Error?
    
    let product: Product
    
    private let productService: ProductServiceProtocol
    
    public init(product: Product, productService: ProductServiceProtocol) {
        self.product = product
        self.productService = productService
    }
    
    @MainActor
    public func setProductDetail() async throws {
        do {
            error = nil
            productDetail = try await productService.getProductDetail(with: product.id)
        }
    }
    
    @MainActor
    var productName: String {
        productDetail?.name ?? product.title
    }
    
    @MainActor
    var productImages: [URL] {
        if let details = productDetail,
           !details.pictures.isEmpty {
            return details.pictures
        } else if let thumbnailURL = URL(string: product.thumbnailURL.convertToHTTPS()) {
            return [thumbnailURL]
        } else {
            return []
        }
    }
    
    var hasDiscount: Bool {
        if let originalPrice = product.originalPrice,
           originalPrice > product.price {
            return true
        }
        return false
    }
    
    var discountedPrice: String {
        if let originalPrice = product.originalPrice {
            return "\(originalPrice.formatted(.currency(code: product.currencyId)))"
        }
        
        return ""
    }
    
    var productPrice: String {
        "\(product.price.formatted(.currency(code: product.currencyId)))"
    }
    
    var discountedPercentage: Int {
        if let originalPrice = product.originalPrice {
            let dif = originalPrice - product.price
            let div = Double(dif) / Double(originalPrice)
            let percentage = div * 100

            return Int(percentage)
        }
        
        return 0
    }
    
    var installmentsInfoString: String {
        "\(product.installmentsData.quantity)x \(product.installmentsData.amount.formatted(.currency(code: product.currencyId)))"
    }
}
