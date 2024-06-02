//
//  ProductTranslator.swift
//  MeLi Challenge
//
//  Created by Felipe on 28/05/24.
//

public struct ProductTranslator {
    private init() { }
    
    public static func translate(from dto: ProductDTO) -> Product? {
        .init(
            id: dto.id,
            title: dto.title,
            thumbnailURL: dto.thumbnail,
            price: dto.price, 
            originalPrice: dto.originalPrice,
            currencyId: dto.currencyId,
            condition: dto.condition,
            quantityAvailable: dto.availableQuantity,
            shippingData: ShippmentDataTranslator.translate(from: dto.shipping),
            installmentsData: InstallmentsDataTranslator.translate(from: dto.installments)
        )
    }
}
