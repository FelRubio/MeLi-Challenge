//
//  ProductDTO.swift
//  MeLi Challenge
//
//  Created by Felipe on 28/05/24.
//

public struct ProductDTO: Decodable {
    public let id: String
    public let title: String
    public let condition: String
    public let thumbnail: String
    public let currencyId: String
    public let attributes: [ProductAttributeDTO]
    public let shipping: ShippingDataDTO
    public let installments: InstallmentsDataDTO
    
    public enum CodingKeys: String, CodingKey {
        case id
        case title
        case condition
        case thumbnail
        case currencyId = "currency_id"
        case attributes
        case shipping
        case installments
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.condition = try container.decode(String.self, forKey: .condition)
        self.thumbnail = try container.decode(String.self, forKey: .thumbnail)
        self.currencyId = try container.decode(String.self, forKey: .currencyId)
        self.attributes = try container.decode([ProductAttributeDTO].self, forKey: .attributes)
        self.shipping = try container.decode(ShippingDataDTO.self, forKey: .shipping)
        self.installments = try container.decode(InstallmentsDataDTO.self, forKey: .installments)
    }
}
