//
//  NetworkError.swift
//  MeLi Challenge
//
//  Created by Felipe on 27/05/24.
//

public enum NetworkError: Error {
    /// Indicates that the URL provided for the network request is not valid.
    case badURL

    /// Indicates that the response contains a status code outside the 200...299 range.
    /// It includes the status code and an optional JSON dictionary containing the error response.
    ///
    /// - Parameters:
    ///   - Int: The status code of the response.
    ///   - String?: An optional string containing the error response.
    case badStatusCode(Int, String?)

    /// Indicates that there is no internet connection available.
    case noInternetConnection

    /// Indicates that an error other than a bad URL or bad status code has occurred.
    /// It includes the original `Error` object that caused the network error.
    ///
    /// - Parameters:
    ///   - Error: The original error that caused the network error.
    case other(Error)
}
