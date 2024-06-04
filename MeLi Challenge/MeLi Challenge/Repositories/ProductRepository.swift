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
            Logger.log("Fetching products by query: \(query)", level: .info)
            let url = APIEndpoints.searchProducts.buildEndpointWith(baseURL: "https://api.mercadolibre.com/")
            let result: FetchProductsResults = try await apiClient.request(
                url: url,
                method: .get,
                params: [
                    .init(name: "status", value: "active"),
                    .init(name: "q", value: query)
                ]
            )
            let results = result.results.elements.compactMap {
                ProductTranslator.translate(from: $0)
            }
            Logger.log("\(results.count) products found!", level: .info)
            return results
        } catch {
            Logger.log("Could not fetch products by query: \(query), Error: \(error.localizedDescription)", level: .info)
            throw ProductError.couldNotFecthProducts(error)
        }
    }
    
    public func getProductDetailWith(productIdentifier: String) async throws -> ProductDetail? {
        do {
            Logger.log("Getting product details with product Id: \(productIdentifier)", level: .info)
            let url = APIEndpoints.fetchProduct.buildEndpointWith(baseURL: "https://api.mercadolibre.com/") + productIdentifier
            let result: ProductDetailDTO = try await apiClient.request(url: url, method: .get)
            let description = try? await getProductDescription(with: productIdentifier)
            let detail = ProductDetailTranslator.translate(from: result, with: description ?? "")
            Logger.log("Details found for product \(productIdentifier)", level: .info)
            return detail
        } catch {
            Logger.log("Could not get product: \(productIdentifier) detail, Error: \(error.localizedDescription)", level: .info)
            throw ProductError.couldNotGetDetailsForProduct(productIdentifier, error)
        }
    }
    
    public func getProductDescription(with id: String) async throws -> String {
        do {
            Logger.log("Getting product description with product Id: \(id)", level: .info)
            let url = APIEndpoints.fetchProduct.buildEndpointWith(baseURL: "https://api.mercadolibre.com/") + "\(id)/" + APIEndpoints.description.path
            let result: DescriptionDTO = try await apiClient.request(url: url, method: .get)
            Logger.log("Description found for product \(id)", level: .info)
            return result.text
        } catch {
            Logger.log("Could not get description for product: \(id) detail, Error: \(error.localizedDescription)", level: .info)
            throw ProductError.couldNotGetDescriptionForProduct(id, error)
        }
    }
    
    public func fetchPromotions() async throws -> [Product] {
        do {
            Logger.log("Fetching promotion products...", level: .info)
            let url = APIEndpoints.searchProducts.buildEndpointWith(baseURL: "https://api.mercadolibre.com/")
            let result: FetchProductsResults = try await apiClient.request(
                url: url,
                method: .get,
                params: [
                    .init(name: "status", value: "active"),
                    .init(name: "q", value: "promotions")
                ]
            )
            let results = result.results.elements.compactMap {
                ProductTranslator.translate(from: $0)
            }
            Logger.log("\(results.count) products found!", level: .info)
            return results
        } catch {
            Logger.log("Could not fetch promotion products, Error: \(error.localizedDescription)", level: .info)
            throw ProductError.couldNotGetPromotions(error)
        }
    }
}
