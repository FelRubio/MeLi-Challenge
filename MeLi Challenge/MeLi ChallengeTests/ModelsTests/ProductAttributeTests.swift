//
//  ProductAttributeTests.swift
//  MeLi ChallengeTests
//
//  Created by Felipe on 27/05/24.
//

import XCTest
@testable import MeLi_Challenge

final class ProductAttributeTests: XCTestCase {
    func testProductAttributeInitializationWithValidValue() {
        let attribute = ProductAttribute(id: "color", name: "Color", value: "Red")
        
        XCTAssertEqual(attribute.id, "color")
        XCTAssertEqual(attribute.name, "Color")
        XCTAssertEqual(attribute.value, "Red")
    }
    
    func testProductAttributeInitializationWithEmptyValuesArray() {
        let attribute = ProductAttribute(id: "color", name: "Color", value: "")
        
        XCTAssertEqual(attribute.id, "color")
        XCTAssertEqual(attribute.name, "Color")
        XCTAssertEqual(attribute.value, "")
    }
    
    func testProductAttributeInitializationWithEmptyStrings() {
        let attribute = ProductAttribute(id: "", name: "", value: "")
        
        XCTAssertEqual(attribute.id, "")
        XCTAssertEqual(attribute.name, "")
        XCTAssertEqual(attribute.value, "")
    }
}
