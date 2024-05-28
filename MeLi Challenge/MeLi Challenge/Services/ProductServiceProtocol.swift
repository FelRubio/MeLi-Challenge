//
//  ProductService.swift
//  MeLi Challenge
//
//  Created by Felipe on 28/05/24.
//

/// A protocol defining the services related to products.
public protocol ProductServiceProtocol {
    /// Searches for products based on a query.
    ///
    /// - Parameter query: The search query string.
    /// - Returns: An array of `Product` that match the query.
    func searchProductsBy(_ query: String) -> [Product]
}
