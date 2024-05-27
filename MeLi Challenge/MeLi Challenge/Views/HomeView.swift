//
//  HomeView.swift
//  MeLi Challenge
//
//  Created by Felipe on 27/05/24.
//

import SwiftUI

struct HomeView: View {
    @State private var searchBar = ""

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<100, id: \.self) { index in
                    NavigationLink(destination: {
                        ProductDetailView()
                            .navigationTitle("PRODUCT_DETAIL_NAV_TITLE")
                    }, label: {
                        ProductCardView()
                    })
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)
        }
        .background(Color(.secondarySystemBackground))
        .navigationTitle("HOME_NAV_TITLE")
        .searchable(text: $searchBar, placement: .navigationBarDrawer(displayMode: .always))
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
