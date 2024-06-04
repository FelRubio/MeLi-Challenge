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
    @MainActor @Published var error: Error? {
        didSet {
            if let error {
                Logger.log(error.localizedDescription, level: .error)
            }
        }
    }
    
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
            if searchQuery.isEmpty {
                try await setHomeProducts()
            } else {
                performSearch(query: searchQuery)
            }
        }
    }
    
    @MainActor
    public func setHomeProducts() async throws {
        let products = try await productService.getPromotions()
        if promotions != products {
            promotions = products
        }
    }
    
    private func performSearch(query: String) {
        // Cancel the previous search task if it is still running
        searchTask?.cancel()
        
        searchTask = Task { @MainActor in
            do {
                self.error = nil
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
                self.error = error
                viewState = .idle
            }
        }
    }
}
