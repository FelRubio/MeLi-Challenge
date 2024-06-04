//
//  HomeViewModel.swift
//  MeLi Challenge
//
//  Created by Felipe on 29/05/24.
//

import Foundation
import Combine

public class HomeViewModel: ObservableObject {
    @MainActor @Published var searchQuery: String = ""
    @MainActor @Published var searchResults: [Product] = []
    @MainActor @Published var promotions: [Product] = []
    @MainActor @Published var viewState: ViewState = .idle
    
    private var cancellables = Set<AnyCancellable>()
    private var searchTask: Task<Void, Never>?
    
    private let productService: ProductServiceProtocol
    
    public init(_ productService: ProductServiceProtocol) {
        self.productService = productService
        $searchQuery
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                self?.performSearch(query: query)
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    var homeProducts: [Product] {
        if searchResults.isEmpty {
            return promotions
        }
        
        return searchResults
    }
    
    @MainActor
    public func refreshHome() async throws {
        do {
            viewState = .processing
            if searchQuery.isEmpty {
                try await setHomeProducts()
            } else {
                performSearch(query: searchQuery)
            }
            viewState = .idle
        } catch {
            viewState = .idle
        }
    }
    
    @MainActor
    public func setHomeProducts() async throws {
        do {
            let products = try await productService.getPromotions()
            if promotions != products {
                promotions = products
            }
        } catch {
            Logger.log("\(error.localizedDescription)", level: .debug)
        }
    }
    
    private func performSearch(query: String) {
        // Cancel the previous search task if it is still running
        searchTask?.cancel()
        
        searchTask = Task { @MainActor in
            do {
                viewState = .processing
                guard !query.isEmpty else {
                    self.searchResults = []
                    viewState = .idle
                    return
                }
                let results = try await productService.searchProductsBy(searchQuery.lowercased())
                
                guard !Task.isCancelled else {
                    viewState = .idle
                    return
                }
                
                self.searchResults = results
                self.viewState = .idle

            } catch {
                Logger.log("Search failed: \(error.localizedDescription)", level: .error)
                viewState = .idle
            }
        }
    }
}
