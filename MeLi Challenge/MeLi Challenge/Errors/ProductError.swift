//
//  ProductError.swift
//  MeLi Challenge
//
//  Created by Felipe on 4/06/24.
//

import Foundation

public enum ProductError: Error {
    case couldNotFecthProducts(Error?)
    case couldNotGetDetailsForProduct(String, Error?)
    case couldNotGetDescriptionForProduct(String, Error?)
    case couldNotGetPromotions(Error?)
}
