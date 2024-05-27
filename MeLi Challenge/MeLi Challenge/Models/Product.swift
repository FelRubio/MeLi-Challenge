//
//  Product.swift
//  MeLi Challenge
//
//  Created by Felipe on 27/05/24.
//

public struct Product: Identifiable, Hashable {
    public let id: String
    public let title: String
    public let thumbnailURL: String
    public let price: Int
    public let attributes: [ProductAttribute]
    public let currencyId: String
    public let condition: String
    public let seller: String
    public let quantityAvailable: Int
    public let shippingData: ShippingData
    public let installmentsData: InstallmentsData
}
