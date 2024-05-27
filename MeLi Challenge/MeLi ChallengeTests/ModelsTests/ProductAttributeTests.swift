//
//  ProductAttributeTests.swift
//  MeLi ChallengeTests
//
//  Created by Felipe on 27/05/24.
//

import XCTest
@testable import MeLi_Challenge

final class ProductAttributeTests: XCTestCase {
    func testProductAttributeInitializationWithValidValues() {
        let attribute = ProductAttribute(id: "color", name: "Color", group: "General", values: ["Red", "Blue"])
        
        XCTAssertEqual(attribute.id, "color")
        XCTAssertEqual(attribute.name, "Color")
        XCTAssertEqual(attribute.group, "General")
        XCTAssertEqual(attribute.values, ["Red", "Blue"])
    }
    
    func testProductAttributeInitializationWithEmptyValuesArray() {
        let attribute = ProductAttribute(id: "color", name: "Color", group: "General", values: [])
        
        XCTAssertEqual(attribute.id, "color")
        XCTAssertEqual(attribute.name, "Color")
        XCTAssertEqual(attribute.group, "General")
        XCTAssertEqual(attribute.values, [])
    }
    
    func testProductAttributeInitializationWithEmptyStrings() {
        let attribute = ProductAttribute(id: "", name: "", group: "", values: ["Value1"])
        
        XCTAssertEqual(attribute.id, "")
        XCTAssertEqual(attribute.name, "")
        XCTAssertEqual(attribute.group, "")
        XCTAssertEqual(attribute.values, ["Value1"])
    }
}
