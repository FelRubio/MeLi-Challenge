//
//  ConfigReader.swift
//  MeLi Challenge
//
//  Created by Felipe on 4/06/24.
//

import Foundation

enum Configuration {
    /// An error type representing errors that may occur during configuration reading.
    enum ReaderError: Error {
        /// Indicates that a required configuration key is missing.
        case missingKey
        /// Indicates that a configuration value is invalid.
        case invalidValue
    }

    /// Reads a configuration value from the app's Info.plist file.
    ///
    /// - Parameters:
    ///   - key: The key of the configuration value to read.
    /// - Throws: A `ReaderError` if the value cannot be read or is invalid.
    /// - Returns: The configuration value, converted to the specified type.
    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
            throw ReaderError.missingKey
        }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw ReaderError.invalidValue
        }
    }
}
