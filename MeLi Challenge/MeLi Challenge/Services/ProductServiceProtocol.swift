//
//  ProductService.swift
//  MeLi Challenge
//
//  Created by Felipe on 28/05/24.
//

public protocol ProductServiceProtocol {
    func searchProductsBy(_ query: String) -> [Product]
}
