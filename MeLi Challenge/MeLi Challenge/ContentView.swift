//
//  ContentView.swift
//  MeLi Challenge
//
//  Created by Felipe on 26/05/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            HomeView()
                .environmentObject(
                    HomeViewModel(
                        ProductService(
                            repository: ProductRepository()
                        )
                    )
                )
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(
            HomeViewModel(
                ProductService(
                    repository: MockUpProductRepository()
                )
            )
        )
}
