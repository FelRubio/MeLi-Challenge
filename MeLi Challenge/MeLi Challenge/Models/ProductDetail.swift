//
//  ProductDetail.swift
//  MeLi Challenge
//
//  Created by Felipe on 28/05/24.
//

import Foundation

/// Represents detailed information about a product.
public struct ProductDetail: Identifiable, Hashable {
    /// The unique identifier of the product detail.
    public let id: String
    /// The attributes of the product.
    public let attributes: [ProductAttribute]
    /// The URLs of the product's pictures.
    public let pictures: [URL]
    
    /// Initializes a new instance of `ProductDetail`.
    /// - Parameters:
    ///   - id: The unique identifier of the product detail.
    ///   - attributes: The attributes of the product.
    ///   - pictures: The URLs of the product's pictures.
    public init(id: String, attributes: [ProductAttribute], pictures: [URL]) {
        self.id = id
        self.attributes = attributes
        self.pictures = pictures
    }
}
