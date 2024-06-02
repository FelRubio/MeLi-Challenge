//
//  Endpoints.swift
//  MeLi Challenge
//
//  Created by Felipe on 28/05/24.
//

/// An enumeration representing the different API endpoints.
public enum APIEndpoints: String {
    /// The endpoint for searching products.
    case searchProducts = "sites/MCO/search"
    case fetchProduct = "items/"
    case description = "description/"
    
    /// The path of the API endpoint.
    ///
    /// - Returns: The raw value of the endpoint as a string.
    public var path: String {
        return self.rawValue
    }
    
    /// Builds the full endpoint URL with the given base URL.
    ///
    /// - Parameter baseURL: The base URL of the API.
    /// - Returns: The full endpoint URL as a string.
    public func buildEndpointWith(baseURL: String) -> String {
        return baseURL + path
    }
}
