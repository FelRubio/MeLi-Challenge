//
//  NetworkManager.swift
//  MeLi Challenge
//
//  Created by Felipe on 27/05/24.
//

import Foundation
import Network

public class NetworkManager {
    public static let shared = NetworkManager()
    
    /// An instance of `NWPathMonitor` for monitoring network connection status.
    private let monitor = NWPathMonitor()
    /// A custom DispatchQueue for handling network status updates.
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    /// A property to store the network connection status; true if connected, false otherwise.
    public private(set) var isConnected: Bool = false
    
    private init() {
        // Sets the path update handler for monitoring changes in the network connection.
        monitor.pathUpdateHandler = { [weak self] path in
            // Updates the isConnected status based on the path's satisfaction.
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        // Starts monitoring the network connection on the custom queue.
        monitor.start(queue: queue)
    }
    /// Fetches data from a given URL asynchronously.
    ///
    /// - Parameter url: The URL from which to fetch data.
    /// - Throws: ``NetworkError`` for various error conditions.
    /// - Returns: The data fetched from the given URL.
    public func getData(from url: URL) async throws -> Data {
        guard isConnected else {
            throw NetworkError.noInternetConnection
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                var response: String?
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])

                response = String(data: jsonData, encoding: .utf8)

                throw NetworkError.badStatusCode(statusCode, response)
            }

            return data
        } catch let networkError as NetworkError {
            throw networkError
        } catch {
            throw NetworkError.other(error)
        }
    }
    
    /// Performs an async HTTP request with the specified parameters and returns the raw Data object.
    ///
    /// - Parameters:
    ///   - url: The target URL for the request.
    ///   - method: The HTTP method to be used for the request (e.g., .get, .post, .put, .delete).
    ///   - headers: An optional dictionary of custom headers to include in the request. The keys are header field names,
    ///   and the values are the corresponding field values. The default value is nil.
    ///   - body: An optional dictionary representing the request body. The keys are parameter names, and the values are
    ///   the corresponding parameter values. The default value is nil.
    /// - Returns: The raw Data object.
    /// - Throws: ``NetworkError`` for various error conditions.
    public func request(
        url: URL,
        method: HTTPMethod,
        headers: [String: String]? = nil,
        body: [String: Any]? = nil,
        params: [URLQueryItem]? = nil
    ) async throws -> Data {
        guard isConnected else {
            throw NetworkError.noInternetConnection
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }

        if let body = body {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        if let queryParams = params {
            request.url?.append(queryItems: queryParams)
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                var response: String?
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])

                response = String(data: jsonData, encoding: .utf8)

                throw NetworkError.badStatusCode(statusCode, response)
            }

            return data
        } catch let networkError as NetworkError {
            throw networkError
        } catch {
            throw NetworkError.other(error)
        }
    }

    /// Performs an asynchronous HTTP request with the specified parameters and returns the raw Data object,
    /// using an array of Encodable objects for the body.
    ///
    /// - Parameters:
    ///   - url: The target URL for the request.
    ///   - method: The HTTP method to be used for the request (e.g., .get, .post, .put, .delete).
    ///   - headers: An optional dictionary of custom headers to include in the request.
    ///   - body: Raw data object representing the request body.
    ///   - params: Optional URL query parameters.
    /// - Returns: The raw Data object.
    /// - Throws: ``NetworkError`` for various error conditions.
    public func request(
        url: URL,
        method: HTTPMethod,
        headers: [String: String]? = nil,
        body: Data? = nil,
        params: [URLQueryItem]? = nil
    ) async throws -> Data {
        guard isConnected else {
            throw NetworkError.noInternetConnection
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }

        if let body = body {
            request.httpBody = body
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        if let queryParams = params {
            request.url?.append(queryItems: queryParams)
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                var response: String?
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])

                response = String(data: jsonData, encoding: .utf8)

                throw NetworkError.badStatusCode(statusCode, response)
            }

            return data
        } catch let networkError as NetworkError {
            throw networkError
        } catch {
            throw NetworkError.other(error)
        }
    }
}

extension NetworkManager {
    /// Performs an async HTTP request with the specified parameters and returns the raw Data
    /// object using a Codable object for the body.
    ///
    /// - Parameters:
    ///   - url: The target URL for the request.
    ///   - method: The HTTP method to be used for the request (e.g., .get, .post, .put, .delete).
    ///   - headers: An optional dictionary of custom headers to include in the request. The keys are header field names
    ///   , and the values are the corresponding field values. The default value is nil.
    ///   - body: An optional Codable object representing the request body.
    /// - Returns: The raw Data object.
    /// - Throws: ``NetworkError`` for various error conditions.
    public func request<T: Encodable>(
        url: URL,
        method: HTTPMethod,
        headers: [String: String]? = nil,
        body: T? = nil,
        params: [URLQueryItem]? = nil
    ) async throws -> Data {
        let body = try body?.asDictionary()

        return try await request(
            url: url,
            method: method,
            headers: headers,
            body: body,
            params: params
        )
    }

    /// Performs an async HTTP request with the specified parameters and returns a Codable object using a
    /// dictionary for the body.
    ///
    /// - Parameters:
    ///   - url: The target URL for the request.
    ///   - method: The HTTP method to be used for the request (e.g., .get, .post, .put, .delete).
    ///   - headers: An optional dictionary of custom headers to include in the request. The keys are header field names
    ///   , and the values are the corresponding field values. The default value is nil.
    ///   - body: An optional dictionary representing the request body. The keys are parameter names, and the values are
    ///   the corresponding parameter values. The default value is nil.
    /// - Returns: A Codable object of type T.
    /// - Throws: ``NetworkError`` for various error conditions.
    public func request<T: Decodable>(
        url: URL,
        method: HTTPMethod,
        headers: [String: String]? = nil,
        body: [String: Any]? = nil,
        params: [URLQueryItem]? = nil
    ) async throws -> T {
        let data = try await request(url: url, method: method, headers: headers, body: body, params: params)
        return try JSONDecoder().decode(T.self, from: data)
    }

    /// Performs an async HTTP request with the specified parameters and returns a Codable object using a
    /// Codable object for the body.
    ///
    /// - Parameters:
    ///   - url: The target URL for the request.
    ///   - method: The HTTP method to be used for the request (e.g., .get, .post, .put, .delete).
    ///   - headers: An optional dictionary of custom headers to include in the request. The keys are header field names
    ///   , and the values are the corresponding field values. The default value is nil.
    ///   - body: An optional Codable object representing the request body of type T.
    /// - Returns: A Codable object of type U.
    /// - Throws: ``NetworkError`` for various error conditions.
    public func request<T: Encodable, U: Decodable>(
        url: URL,
        method: HTTPMethod,
        headers: [String: String]? = nil,
        body: T? = nil,
        params: [URLQueryItem]? = nil
    ) async throws -> U {
        let data = try await request(url: url, method: method, headers: headers, body: body, params: params)
        return try JSONDecoder().decode(U.self, from: data)
    }

    // MARK: - Same request functions that accept String-based URLs.

    /// Fetches data from a given URL asynchronously.
    ///
    /// - Parameter url: The URL from which to fetch data.
    /// - Throws: ``NetworkError`` for various error conditions.
    /// - Returns: The data fetched from the given URL.
    public func getData(from url: String) async throws -> Data {
        guard let url = URL(string: url) else {
            throw NetworkError.badURL
        }

        return try await getData(from: url)
    }

    /// Performs an async HTTP request with the specified parameters and returns the raw Data object.
    ///
    /// - Parameters:
    ///   - url: The target URL for the request.
    ///   - method: The HTTP method to be used for the request (e.g., .get, .post, .put, .delete).
    ///   - headers: An optional dictionary of custom headers to include in the request. The keys are header field names
    ///   , and the values are the corresponding field values. The default value is nil.
    ///   - body: An optional dictionary representing the request body. The keys are parameter names, and the values are
    ///   the corresponding parameter values. The default value is nil.
    /// - Returns: The raw Data object.
    /// - Throws: ``NetworkError`` for various error conditions.
    public func request(
        url: String,
        method: HTTPMethod,
        headers: [String: String]? = nil,
        body: [String: Any]? = nil,
        params: [URLQueryItem]? = nil
    ) async throws -> Data {
        guard let url = URL(string: url) else {
            throw NetworkError.badURL
        }

        return try await request(url: url, method: method, headers: headers, body: body, params: params)
    }

    /// Performs an async HTTP request with the specified parameters and returns the raw Data
    /// object using a Codable object for the body.
    ///
    /// - Parameters:
    ///   - url: The target URL for the request.
    ///   - method: The HTTP method to be used for the request (e.g., .get, .post, .put, .delete).
    ///   - headers: An optional dictionary of custom headers to include in the request. The keys are header field names
    ///   , and the values are the corresponding field values. The default value is nil.
    ///   - body: An optional Codable object representing the request body.
    /// - Returns: The raw Data object.
    /// - Throws: ``NetworkError`` for various error conditions.
    public func request<T: Encodable>(
        url: String,
        method: HTTPMethod,
        headers: [String: String]? = nil,
        body: T? = nil,
        params: [URLQueryItem]? = nil
    ) async throws -> Data {
        guard let url = URL(string: url) else {
            throw NetworkError.badURL
        }

        let data = try await request(url: url, method: method, headers: headers, body: body, params: params)
        return data
    }

    /// Performs an async HTTP request with the specified parameters and returns a Codable
    /// object using a dictionary for the body.
    ///
    /// - Parameters:
    ///   - url: The target URL for the request.
    ///   - method: The HTTP method to be used for the request (e.g., .get, .post, .put, .delete).
    ///   - headers: An optional dictionary of custom headers to include in the request. The keys are header field names
    ///   , and the values are the corresponding field values. The default value is nil.
    ///   - body: An optional dictionary representing the request body. The keys are parameter names, and
    ///   the values are the corresponding parameter values. The default value is nil.
    /// - Returns: A Codable object of type T.
    /// - Throws: ``NetworkError`` for various error conditions.
    public func request<T: Decodable>(
        url: String,
        method: HTTPMethod,
        headers: [String: String]? = nil,
        body: [String: Any]? = nil,
        params: [URLQueryItem]? = nil
    ) async throws -> T {
        guard let url = URL(string: url) else {
            throw NetworkError.badURL
        }
        return try await request(url: url, method: method, headers: headers, body: body, params: params)
    }

    /// Performs an async HTTP request with the specified parameters and returns a Codable
    /// object using a Codable object for the body.
    ///
    /// - Parameters:
    ///   - url: The target URL for the request.
    ///   - method: The HTTP method to be used for the request (e.g., .get, .post, .put, .delete).
    ///   - headers: An optional dictionary of custom headers to include in the request. The keys are header field names
    ///   , and the values are the corresponding field values. The default value is nil.
    ///   - body: An optional Codable object representing the request body of type T.
    /// - Returns: A Codable object of type U.
    /// - Throws: ``NetworkError`` for various error conditions.
    public func request<T: Encodable, U: Decodable>(
        url: String,
        method: HTTPMethod,
        headers: [String: String]? = nil,
        body: T? = nil,
        params: [URLQueryItem]? = nil
    ) async throws -> U {
        guard let url = URL(string: url) else {
            throw NetworkError.badURL
        }
        return try await request(url: url, method: method, headers: headers, body: body, params: params)
    }
}

