//
//  MockUpProductRepository.swift
//  MeLi Challenge
//
//  Created by Felipe on 29/05/24.
//

public struct MockUpProductRepository: ProductRepositoryProtocol {
    public func fetchProductsBy(_ query: String) async throws -> [Product] {
        [
            .randomSample(),
            .randomSample(),
            .randomSample(),
            .randomSample(),
            .randomSample(),
            .randomSample(),
            .randomSample(),
            .randomSample(),
            .randomSample(),
            .randomSample(),
            .randomSample(),
            .randomSample(),
            .randomSample(),
            .randomSample(),
            .randomSample(),
            .randomSample(),
            .randomSample(),
            .randomSample()
        ]
    }
    
    public func getProductDetailWith(productIdentifier: String) async throws -> ProductDetail? {
        nil
    }
    
    public func getProductDescription(with id: String) async throws -> String {
        ""
    }
    
    public func fetchPromotions() async throws -> [Product] {
        [
            .randomSample(),
            .randomSample(),
            .randomSample(),
            .randomSample(),
            .randomSample(),
            .randomSample(),
            .randomSample(),
            .randomSample(),
            .randomSample(),
            .randomSample(),
            .randomSample(),
            .randomSample(),
            .randomSample(),
            .randomSample(),
            .randomSample(),
            .randomSample(),
            .randomSample(),
            .randomSample()
        ]
    }
}
