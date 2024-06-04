//
//  ContentView.swift
//  MeLi Challenge
//
//  Created by Felipe on 26/05/24.
//

import SwiftUI

struct ContentView: View {
    var environmentLabel: String? {
        if let bundleIdentifier = Bundle.main.bundleIdentifier,
           let version = try? Configuration.value(for: "CFBundleShortVersionString") as String,
           let buildNumber = try? Configuration.value(for: "CFBundleVersion") as String {
            var label = ""

    #if DEBUG
            label = "DEBUG"
    #else
            label = "RELEASE"
    #endif

    #if DEV
            label += "-DEV"
    #elseif QA
            label += "-QA"
    #elseif PROD
            label += "-PROD"
    #endif
            
            label += "-\(bundleIdentifier)"
            
            label += "-\(version)"
            
            label += "-\(buildNumber)"
            
            return label
        }
        
        return nil
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                HomeView()
                    .environmentObject(
                        HomeViewModel(
                            ProductService(
                                repository: ProductRepository()
                            )
                        )
                    )
                
                #if !PROD || (PROD && DEBUG)
                Group {
                    if let environmentLabel {
                        Text(environmentLabel)
                    } else {
                        Text("UNKNOWN_BUILD")
                    }
                }
                .multilineTextAlignment(.trailing)
                .foregroundStyle(.secondary)
                .opacity(0.8)
                .allowsHitTesting(false)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding(.horizontal)
                .environment(\.sizeCategory, .extraLarge)
                #endif
            }
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
