//
//  ProductErrorView.swift
//  MeLi Challenge
//
//  Created by Felipe on 4/06/24.
//

import SwiftUI

public struct ProductErrorView: View {
    private let error: Error
    private let recoveryAction: (() -> Void)?
    
    public init(error: Error, recoveryAction: (() -> Void)? = nil) {
        self.error = error
        self.recoveryAction = recoveryAction
    }
    
    public var body: some View {
        VStack {
            if let error = (error as? ProductError)?.error {
                Group {
                    if error is NetworkError {
                        Text("NETWORK_ISSUE_TITLE")
                    } else {
                        Text("SOMETHING_WENT_WRONG")
                    }
                }
                .multilineTextAlignment(.center)
                .font(.title)
                .bold()
                .padding()
                Text(error.localizedDescription)
                    .multilineTextAlignment(.center)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding()
            } else {
                Text("SOMETHING_WENT_WRONG")
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .bold()
                    .padding()
                Text("DEFAULT_ERROR_DESCRIPTION")
                    .multilineTextAlignment(.center)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding()
            }
            
            if let recoveryAction {
                Button("RETRY") {
                    recoveryAction()
                }
            }
        }
    }
}

#Preview {
    ProductErrorView(error: ProductError.couldNotFecthProducts(NetworkError.badURL))
}
