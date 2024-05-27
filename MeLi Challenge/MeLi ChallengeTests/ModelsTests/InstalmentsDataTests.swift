//
//  InstalmentsDataTests.swift
//  MeLi ChallengeTests
//
//  Created by Felipe on 27/05/24.
//

import XCTest
@testable import MeLi_Challenge

final class InstalmentsDataTests: XCTestCase {
    func testInstallmentsDataInitializationWithValidValues() {
        let installmentsData = InstallmentsData(quantity: 12, amount: 99.99, rate: 0, currencyId: "USD")
        
        XCTAssertEqual(installmentsData.quantity, 12)
        XCTAssertEqual(installmentsData.amount, 99.99)
        XCTAssertEqual(installmentsData.rate, 0)
        XCTAssertEqual(installmentsData.currencyId, "USD")
    }
    
    func testInstallmentsDataInitializationWithZeroQuantity() {
        let installmentsData = InstallmentsData(quantity: 0, amount: 99.99, rate: 0, currencyId: "USD")
        
        XCTAssertEqual(installmentsData.quantity, 0)
        XCTAssertEqual(installmentsData.amount, 99.99)
        XCTAssertEqual(installmentsData.rate, 0)
        XCTAssertEqual(installmentsData.currencyId, "USD")
    }
    
    func testInstallmentsDataInitializationWithZeroAmount() {
        let installmentsData = InstallmentsData(quantity: 12, amount: 0.0, rate: 0, currencyId: "USD")
        
        XCTAssertEqual(installmentsData.quantity, 12)
        XCTAssertEqual(installmentsData.amount, 0.0)
        XCTAssertEqual(installmentsData.rate, 0)
        XCTAssertEqual(installmentsData.currencyId, "USD")
    }
    
    func testInstallmentsDataInitializationWithNegativeRate() {
        let installmentsData = InstallmentsData(quantity: 12, amount: 99.99, rate: -1, currencyId: "USD")
        
        XCTAssertEqual(installmentsData.quantity, 12)
        XCTAssertEqual(installmentsData.amount, 99.99)
        XCTAssertEqual(installmentsData.rate, -1)
        XCTAssertEqual(installmentsData.currencyId, "USD")
    }
    
    func testInstallmentsDataInitializationWithEmptyCurrencyId() {
        let installmentsData = InstallmentsData(quantity: 12, amount: 99.99, rate: 0, currencyId: "")
        
        XCTAssertEqual(installmentsData.quantity, 12)
        XCTAssertEqual(installmentsData.amount, 99.99)
        XCTAssertEqual(installmentsData.rate, 0)
        XCTAssertEqual(installmentsData.currencyId, "")
    }
}
