//
//  Product.swift
//  MeLi Challenge
//
//  Created by Felipe on 27/05/24.
//

import Foundation

/// Represents a product with its details.
public struct Product: Identifiable, Hashable {
    /// The unique identifier of the product.
    public let id: String
    /// The title of the product.
    public let title: String
    /// The URL of the product's thumbnail image.
    public let thumbnailURL: String
    /// The price of the product.
    public let price: Int
    /// The attributes of the product.
    public let attributes: [ProductAttribute]
    /// The currency ID for the product price.
    public let currencyId: String
    /// The condition of the product (e.g., new, used).
    public let condition: String
    /// The name of the seller.
    public let seller: String
    /// The quantity of the product available.
    public let quantityAvailable: Int
    /// The shipping data of the product.
    public let shippingData: ShippingData
    /// The installment payment data of the product.
    public let installmentsData: InstallmentsData
    /// The description of the product.
    public let description: String
    /// The images URL of the product to be displayed.
    public let images: [URL]

    /// Initializes a new instance of `Product`.
    /// - Parameters:
    ///   - id: The unique identifier of the product.
    ///   - title: The title of the product.
    ///   - thumbnailURL: The URL of the product's thumbnail image.
    ///   - price: The price of the product.
    ///   - attributes: The attributes of the product.
    ///   - currencyId: The currency ID for the product price.
    ///   - condition: The condition of the product (e.g., new, used).
    ///   - seller: The name of the seller.
    ///   - quantityAvailable: The quantity of the product available.
    ///   - shippingData: The shipping data of the product.
    ///   - installmentsData: The installment payment data of the product.
    ///   - description: The description of the product.
    ///   - images: The array of images URL of the product to be displayed.
    public init(
        id: String,
        title: String,
        thumbnailURL: String,
        price: Int,
        attributes: [ProductAttribute],
        currencyId: String,
        condition: String,
        seller: String,
        quantityAvailable: Int,
        shippingData: ShippingData,
        installmentsData: InstallmentsData,
        description: String,
        images: [URL]
    ) {
        self.id = id
        self.title = title
        self.thumbnailURL = thumbnailURL
        self.price = price
        self.attributes = attributes
        self.currencyId = currencyId
        self.condition = condition
        self.seller = seller
        self.quantityAvailable = quantityAvailable
        self.shippingData = shippingData
        self.installmentsData = installmentsData
        self.description = description
        self.images = images
    }
}
