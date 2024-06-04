//
//  ProductDetailTranslator.swift
//  MeLi Challenge
//
//  Created by Felipe on 29/05/24.
//

import Foundation

public struct ProductDetailTranslator {
    private init() { }
    
    public static func translate(from dto: ProductDetailDTO, with description: String) -> ProductDetail {
        .init(
            id: dto.id,
            name: dto.name,
            attributes: dto.attributes.compactMap {
                ProductAttributeTranslator.translate(from: $0)
            },
            pictures: dto.pictures.compactMap {
                URL(string: $0.secureURL)
            },
            warranty: dto.warranty ?? "",
            description: description,
            condition: dto.condition
        )
    }
}
