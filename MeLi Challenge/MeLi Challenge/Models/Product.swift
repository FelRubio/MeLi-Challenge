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
    /// The original price of the product (optional).
    public let originalPrice: Int?
    /// The currency ID for the product price.
    public let currencyId: String
    /// The condition of the product (e.g., new, used).
    public let condition: String
    /// The quantity of the product available.
    public let quantityAvailable: Int
    /// The shipping data of the product.
    public let shippingData: ShippingData
    /// The installment payment data of the product.
    public let installmentsData: InstallmentsData

    /// Initializes a new instance of `Product`.
    /// - Parameters:
    ///   - id: The unique identifier of the product.
    ///   - title: The title of the product.
    ///   - thumbnailURL: The URL of the product's thumbnail image.
    ///   - price: The price of the product.
    ///   - originalPrice: The original price of the product (optional).
    ///   - currencyId: The currency ID for the product price.
    ///   - condition: The condition of the product (e.g., new, used).
    ///   - quantityAvailable: The quantity of the product available.
    ///   - shippingData: The shipping data of the product.
    ///   - installmentsData: The installment payment data of the product.
    public init(
        id: String,
        title: String,
        thumbnailURL: String,
        price: Int,
        originalPrice: Int?,
        currencyId: String,
        condition: String,
        quantityAvailable: Int,
        shippingData: ShippingData,
        installmentsData: InstallmentsData
    ) {
        self.id = id
        self.title = title
        self.thumbnailURL = thumbnailURL
        self.price = price
        self.originalPrice = originalPrice
        self.currencyId = currencyId
        self.condition = condition
        self.quantityAvailable = quantityAvailable
        self.shippingData = shippingData
        self.installmentsData = installmentsData
    }

    /// Generates a sample `Product` instance with random data.
    /// - Returns: A `Product` instance with random data.
    public static func randomSample() -> Product {
        return Product(
            id: UUID().uuidString,
            title: "Sample Product \(Int.random(in: 1...1000))",
            thumbnailURL: "https://picsum.photos/200",
            price: Int.random(in: 1...1000) * 100,
            originalPrice: Bool.random() ? Int.random(in: 1...1000) * 100 : nil,
            currencyId: ["USD", "EUR", "GBP", "COP"].randomElement()!,
            condition: ["New", "Used", "Refurbished"].randomElement()!,
            quantityAvailable: Int.random(in: 1...100),
            shippingData: ShippingData.randomSample(),
            installmentsData: InstallmentsData.randomSample()
        )
    }
}
