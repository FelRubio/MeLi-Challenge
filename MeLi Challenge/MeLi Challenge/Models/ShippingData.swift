//
//  ShippingData.swift
//  MeLi Challenge
//
//  Created by Felipe on 27/05/24.
//

/// Represents shipping data for a product.
public struct ShippingData: Hashable {
    /// Indicates whether store pickup is available.
    public let storePickUp: Bool
    /// Indicates whether free shipping is available.
    public let freeShipping: Bool

    /// Initializes a new instance of `ShippingData`.
    /// - Parameters:
    ///   - storePickUp: Indicates whether store pickup is available.
    ///   - freeShipping: Indicates whether free shipping is available.
    public init(storePickUp: Bool, freeShipping: Bool) {
        self.storePickUp = storePickUp
        self.freeShipping = freeShipping
    }
}

// Extensions to generate random samples for ShippingData and InstallmentsData
extension ShippingData {
    /// Generates a sample `ShippingData` instance with random data.
    /// - Returns: A `ShippingData` instance with random data.
    public static func randomSample() -> ShippingData {
        return ShippingData(
            storePickUp: Bool.random(),
            freeShipping: Bool.random()
        )
    }
}
