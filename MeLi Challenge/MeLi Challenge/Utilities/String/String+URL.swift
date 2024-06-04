//
//  String+URL.swift
//  MeLi Challenge
//
//  Created by Felipe on 29/05/24.
//

import Foundation

extension String {
    func convertToHTTPS() -> String {
        guard var urlComponents = URLComponents(string: self) else {
            return self
        }
        urlComponents.scheme = "https"
        return urlComponents.string ?? self
    }
}
