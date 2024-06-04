//
//  ConfigReader.swift
//  MeLi Challenge
//
//  Created by Felipe on 4/06/24.
//

import Foundation

enum Configuration {
    enum ReaderError: Error {
        case missingKey, invalidValue
    }

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
