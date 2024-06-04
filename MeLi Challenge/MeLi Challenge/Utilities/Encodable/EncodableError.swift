//
//  EncodableError.swift
//  MeLi Challenge
//
//  Created by Felipe on 27/05/24.
//

/// An enumeration representing the various errors that can occur when working with Encodable objects.
public enum EncodableError: Error {
    /// Error case when converting an Encodable object to a dictionary.
    case asDictionary
    /// Error case when converting an Encodable object to a JSON string.
    case jsonString
}
