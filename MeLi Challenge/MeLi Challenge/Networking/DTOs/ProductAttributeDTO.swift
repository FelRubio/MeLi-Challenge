//
//  ProductAttributeDTO.swift
//  MeLi Challenge
//
//  Created by Felipe on 28/05/24.
//

public struct ProductAttributeDTO: Decodable {
    public let id: String
    public let name: String
    public let value: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case value = "value_name"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.value = try container.decodeIfPresent(String.self, forKey: .value)
    }
}
