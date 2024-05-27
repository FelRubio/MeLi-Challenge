//
//  ProductAttribute.swift
//  MeLi Challenge
//
//  Created by Felipe on 27/05/24.
//

public struct ProductAttribute: Identifiable, Hashable {
    public let id: String // Unique id, use value_id
    public let name: String
    public let group: String
    public let values: [String]
}
