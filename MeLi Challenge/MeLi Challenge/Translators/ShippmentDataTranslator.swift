//
//  ShippmentDataTranslator.swift
//  MeLi Challenge
//
//  Created by Felipe on 28/05/24.
//

public struct ShippmentDataTranslator {
    private init() { }
    
    public static func translate(from dto: ShippingDataDTO) -> ShippingData {
        .init(storePickUp: dto.storePickUp, freeShipping: dto.freeShipping)
    }
}
