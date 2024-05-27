//
//  ProductTests.swift
//  MeLi ChallengeTests
//
//  Created by Felipe on 27/05/24.
//

import XCTest
@testable import MeLi_Challenge

final class ProductTests: XCTestCase {
    func testProductInitializationWithValidValues() {
        let shippingData = ShippingData(storePickUp: true, freeShipping: false)
        let installmentsData = InstallmentsData(quantity: 12, amount: 99.99, rate: 0, currencyId: "USD")
        let attribute = ProductAttribute(id: "color", name: "Color", group: "General", values: ["Red", "Blue"])
        
        let product = Product(
            id: "12345",
            title: "Sample Product",
            thumbnailURL: "http://example.com/image.jpg",
            price: 100,
            attributes: [attribute],
            currencyId: "USD",
            condition: "New",
            seller: "Sample Seller",
            quantityAvailable: 10,
            shippingData: shippingData,
            installmentsData: installmentsData
        )
        
        XCTAssertEqual(product.id, "12345")
        XCTAssertEqual(product.title, "Sample Product")
        XCTAssertEqual(product.thumbnailURL, "http://example.com/image.jpg")
        XCTAssertEqual(product.price, 100)
        XCTAssertEqual(product.attributes, [attribute])
        XCTAssertEqual(product.currencyId, "USD")
        XCTAssertEqual(product.condition, "New")
        XCTAssertEqual(product.seller, "Sample Seller")
        XCTAssertEqual(product.quantityAvailable, 10)
        XCTAssertEqual(product.shippingData, shippingData)
        XCTAssertEqual(product.installmentsData, installmentsData)
    }
    
    func testProductInitializationWithEmptyAttributesArray() {
        let shippingData = ShippingData(storePickUp: true, freeShipping: false)
        let installmentsData = InstallmentsData(quantity: 12, amount: 99.99, rate: 0, currencyId: "USD")
        
        let product = Product(
            id: "12345",
            title: "Sample Product",
            thumbnailURL: "http://example.com/image.jpg",
            price: 100,
            attributes: [],
            currencyId: "USD",
            condition: "New",
            seller: "Sample Seller",
            quantityAvailable: 10,
            shippingData: shippingData,
            installmentsData: installmentsData
        )
        
        XCTAssertEqual(product.id, "12345")
        XCTAssertEqual(product.title, "Sample Product")
        XCTAssertEqual(product.thumbnailURL, "http://example.com/image.jpg")
        XCTAssertEqual(product.price, 100)
        XCTAssertEqual(product.attributes, [])
        XCTAssertEqual(product.currencyId, "USD")
        XCTAssertEqual(product.condition, "New")
        XCTAssertEqual(product.seller, "Sample Seller")
        XCTAssertEqual(product.quantityAvailable, 10)
        XCTAssertEqual(product.shippingData, shippingData)
        XCTAssertEqual(product.installmentsData, installmentsData)
    }
    
    func testProductInitializationWithEdgeCases() {
        let shippingData = ShippingData(storePickUp: false, freeShipping: true)
        let installmentsData = InstallmentsData(quantity: 0, amount: 0.0, rate: -1, currencyId: "")
        
        let product = Product(
            id: "",
            title: "",
            thumbnailURL: "",
            price: 0,
            attributes: [],
            currencyId: "",
            condition: "",
            seller: "",
            quantityAvailable: 0,
            shippingData: shippingData,
            installmentsData: installmentsData
        )
        
        XCTAssertEqual(product.id, "")
        XCTAssertEqual(product.title, "")
        XCTAssertEqual(product.thumbnailURL, "")
        XCTAssertEqual(product.price, 0)
        XCTAssertEqual(product.attributes, [])
        XCTAssertEqual(product.currencyId, "")
        XCTAssertEqual(product.condition, "")
        XCTAssertEqual(product.seller, "")
        XCTAssertEqual(product.quantityAvailable, 0)
        XCTAssertEqual(product.shippingData, shippingData)
        XCTAssertEqual(product.installmentsData, installmentsData)
    }
}
