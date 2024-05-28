//
//  ProductRepository.swift
//  MeLi Challenge
//
//  Created by Felipe on 28/05/24.
//

public class ProductRepository: ProductRepositoryProtocol {
    private let apiClient = NetworkManager.shared

    public func fetchProductsBy(_ query: String) async throws -> [Product] {
        do {
            let url = "https://api.mercadolibre.com/sites/MCO/search"
            let result: FetchProductsResults = try await apiClient.request(
                url: url,
                method: .get,
                params: [
                    .init(name: "status", value: "active"),
                    .init(name: "q", value: query)
                ]
            )
            print(result.results)
            return []
        } catch {
            print(error)
            throw error
        }
    }
    
    public func getProductDetailWith(productIdentifier: String) async throws -> ProductDetail? {
        nil
    }
    
    public func getProductDescription(with id: String) async throws -> String? {
        nil
    }
}
