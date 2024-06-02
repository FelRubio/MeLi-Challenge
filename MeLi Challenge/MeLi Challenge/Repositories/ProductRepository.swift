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
            let url = APIEndpoints.searchProducts.buildEndpointWith(baseURL: "https://api.mercadolibre.com/")
            let result: FetchProductsResults = try await apiClient.request(
                url: url,
                method: .get,
                params: [
                    .init(name: "status", value: "active"),
                    .init(name: "q", value: query)
                ]
            )
            return result.results.elements.compactMap {
                ProductTranslator.translate(from: $0)
            }
        } catch {
#if DEBUG
            print(error)
#endif
            throw error
        }
    }
    
    public func getProductDetailWith(productIdentifier: String) async throws -> ProductDetail? {
        do {
            let url = APIEndpoints.fetchProduct.buildEndpointWith(baseURL: "https://api.mercadolibre.com/") + productIdentifier
            let result: ProductDetailDTO = try await apiClient.request(url: url, method: .get)
            let description = try await getProductDescription(with: productIdentifier)
            return ProductDetailTranslator.translate(from: result, with: description)
        } catch {
#if DEBUG
            print(error)
#endif
            throw error
        }
    }
    
    public func getProductDescription(with id: String) async throws -> String {
        do {
            let url = APIEndpoints.fetchProduct.buildEndpointWith(baseURL: "https://api.mercadolibre.com/") + "\(id)/" + APIEndpoints.description.path
            let result: DescriptionDTO = try await apiClient.request(url: url, method: .get)
            return result.text
        } catch {
#if DEBUG
            print(error)
#endif
            throw error
        }
    }
}
