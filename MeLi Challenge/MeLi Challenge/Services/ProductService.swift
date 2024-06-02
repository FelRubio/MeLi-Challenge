//
//  ProductService.swift
//  MeLi Challenge
//
//  Created by Felipe on 29/05/24.
//

public struct ProductService: ProductServiceProtocol {
    private let repository: ProductRepositoryProtocol
    
    public init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }
    
    public func searchProductsBy(_ query: String) async throws -> [Product] {
        try await repository.fetchProductsBy(query)
    }
    
    public func getProductDetail(with id: String) async throws -> ProductDetail? {
        try await repository.getProductDetailWith(productIdentifier: id)
    }
}
