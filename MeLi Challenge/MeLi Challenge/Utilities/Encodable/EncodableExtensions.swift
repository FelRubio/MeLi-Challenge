//
//  EncodableExtensions.swift
//  MeLi Challenge
//
//  Created by Felipe on 27/05/24.
//

import Foundation

/// An extension to the `Encodable` protocol that adds a helper function for converting `Encodable`
/// conforming objects to dictionaries.
extension Encodable {
    /// Converts an object conforming to `Encodable` into a dictionary of type `[String: Any]`.
    ///
    /// - Returns: A `[String: Any]` representation of the object.
    ///
    /// - Throws: `EncodableError.asDictionary` if encoding fails.
    public func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(
            with: data,
            options: .allowFragments
        ) as? [String: Any] else {
            throw EncodableError.asDictionary
        }
        return dictionary
    }
}
