//
//  ProductAttribute.swift
//  MeLi Challenge
//
//  Created by Felipe on 27/05/24.
//

/// Represents an attribute of a product.
public struct ProductAttribute: Identifiable, Hashable {
    /// The unique identifier of the attribute.
    public let id: String
    /// The name of the attribute.
    public let name: String
    /// The group to which the attribute belongs.
    public let group: String
    /// The values of the attribute.
    public let values: [String]

    /// Initializes a new instance of `ProductAttribute`.
    /// - Parameters:
    ///   - id: The unique identifier of the attribute.
    ///   - name: The name of the attribute.
    ///   - group: The group to which the attribute belongs.
    ///   - values: The values of the attribute.
    public init(id: String, name: String, group: String, values: [String]) {
        self.id = id
        self.name = name
        self.group = group
        self.values = values
    }
}
