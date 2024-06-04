//
//  HomeView.swift
//  MeLi Challenge
//
//  Created by Felipe on 27/05/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var viewModel: HomeViewModel

    var body: some View {
        VStack {
            if viewModel.viewState == .idle {
                if !viewModel.searchResults.isEmpty || !viewModel.promotions.isEmpty {
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.homeProducts) { product in
                                NavigationLink(destination: {
                                    ProductDetailView(
                                        viewModel: .init(
                                            product: product,
                                            productService: ProductService(repository: ProductRepository())
                                        )
                                    )
                                        .navigationTitle("PRODUCT_DETAIL_NAV_TITLE")
                                }, label: {
                                    ProductCardView(product: product)
                                })
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .refreshable {
                        try? await viewModel.refreshHome()
                    }
                } else {
                    Text("NO_PRODUCTS_FOUND")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .padding()
                }
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
        .task {
            viewModel.viewState = .processing
            try? await viewModel.setHomeProducts()
            viewModel.viewState = .idle
        }
        .background(Color(.secondarySystemBackground))
        .navigationTitle("HOME_NAV_TITLE")
        .searchable(text: $viewModel.searchQuery, placement: .navigationBarDrawer(displayMode: .always))
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .environmentObject(
                HomeViewModel(
                    ProductService(repository: MockUpProductRepository())
                )
            )
    }
}
