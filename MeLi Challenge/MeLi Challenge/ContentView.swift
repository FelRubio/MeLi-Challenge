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
                .task {
                    let repo = ProductRepository()
                    try? await repo.fetchProductsBy("iphone")
                }
        }
    }
}

#Preview {
    ContentView()
}
