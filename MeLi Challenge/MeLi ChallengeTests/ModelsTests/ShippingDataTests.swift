//
//  ShippingDataTests.swift
//  MeLi ChallengeTests
//
//  Created by Felipe on 27/05/24.
//

import XCTest
@testable import MeLi_Challenge

final class ShippingDataTests: XCTestCase {
    func testShippingDataInitializationWithBothTrue() {
        let shippingData = ShippingData(storePickUp: true, freeShipping: true)
        
        XCTAssertEqual(shippingData.storePickUp, true)
        XCTAssertEqual(shippingData.freeShipping, true)
    }
    
    func testShippingDataInitializationWithBothFalse() {
        let shippingData = ShippingData(storePickUp: false, freeShipping: false)
        
        XCTAssertEqual(shippingData.storePickUp, false)
        XCTAssertEqual(shippingData.freeShipping, false)
    }
    
    func testShippingDataInitializationWithStorePickUpTrueFreeShippingFalse() {
        let shippingData = ShippingData(storePickUp: true, freeShipping: false)
        
        XCTAssertEqual(shippingData.storePickUp, true)
        XCTAssertEqual(shippingData.freeShipping, false)
    }
    
    func testShippingDataInitializationWithStorePickUpFalseFreeShippingTrue() {
        let shippingData = ShippingData(storePickUp: false, freeShipping: true)
        
        XCTAssertEqual(shippingData.storePickUp, false)
        XCTAssertEqual(shippingData.freeShipping, true)
    }
}
