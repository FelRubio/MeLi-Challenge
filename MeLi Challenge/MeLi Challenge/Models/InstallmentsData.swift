//
//  InstallmentsData.swift
//  MeLi Challenge
//
//  Created by Felipe on 27/05/24.
//

/// Represents installment payment data for a product.
public struct InstallmentsData: Hashable {
    /// The number of installments.
    public let quantity: Int
    /// The amount for each installment.
    public let amount: Double
    /// The currency ID for the installment amount.
    public let currencyId: String

    /// Initializes a new instance of `InstallmentsData`.
    /// - Parameters:
    ///   - quantity: The number of installments.
    ///   - amount: The amount for each installment.
    ///   - currencyId: The currency ID for the installment amount.
    public init(quantity: Int, amount: Double, currencyId: String) {
        self.quantity = quantity
        self.amount = amount
        self.currencyId = currencyId
    }
}
