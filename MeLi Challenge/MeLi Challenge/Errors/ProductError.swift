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
    
    var error: Error? {
        switch self {
        case .couldNotFecthProducts(let error),
                .couldNotGetDetailsForProduct(_, let error),
                .couldNotGetDescriptionForProduct(_, let error),
                .couldNotGetPromotions(let error):
            return error
        }
    }
}

extension ProductError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .couldNotFecthProducts(_):
            String(localized: "COULD_NOT_FECTH_PRODUCTS")
        case .couldNotGetDetailsForProduct(let productId, _):
            String(localized: "COULD_NOT_GET_PRODUCT_DETAIL \(productId)")
        case .couldNotGetDescriptionForProduct(let productId, _):
            String(localized: "COULD_NOT_GET_PRODUCT_DESCRIPTION \(productId)")
        case .couldNotGetPromotions(_):
            String(localized: "COULD_NOT_GET_PROMOTIONS")
        }
    }
}
