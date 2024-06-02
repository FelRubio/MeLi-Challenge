//
//  ProductRepositoryProtocol.swift
//  MeLi Challenge
//
//  Created by Felipe on 27/05/24.
//

/// A protocol defining the repository methods related to products.
public protocol ProductRepositoryProtocol {
    /// Fetches products based on a query asynchronously.
    ///
    /// - Parameter query: The search query string.
    /// - Returns: An array of `Product` that match the query.
    /// - Throws: An error if the fetch fails.
    func fetchProductsBy(_ query: String) async throws -> [Product]
    
    /// Gets detailed information of a product asynchronously.
    ///
    /// - Parameter productIdentifier: The unique identifier of the product.
    /// - Returns: The `ProductDetail` of the product.
    /// - Throws: An error if the fetch fails.
    func getProductDetailWith(productIdentifier: String) async throws -> ProductDetail?
    
    /// Gets the description of a product asynchronously.
    ///
    /// - Parameter id: The unique identifier of the product description.
    /// - Returns: The description of the product as a `String`.
    /// - Throws: An error if the fetch fails.
    func getProductDescription(with id: String) async throws -> String
    
    /// Fetches promotions asynchronously.
    ///
    /// This method retrieves the current promotions available.
    ///
    /// - Throws: An error if the fetch operation fails.
    func fetchPromotions() async throws -> [Product]
}
