//
//  ProductAttributeTranslator.swift
//  MeLi Challenge
//
//  Created by Felipe on 28/05/24.
//

public struct ProductAttributeTranslator {
    private init() { }
    
    public static func translate(from dto: ProductAttributeDTO) -> ProductAttribute? {
        guard let value = dto.value,
              // Remove GTIN attribute as it is an attribute that
              // is not eligible to be displayed
              !dto.id.lowercased().contains("gtin") else {
            return nil
        }
        
        return .init(id: dto.id, name: dto.name, value: value)
    }
}
