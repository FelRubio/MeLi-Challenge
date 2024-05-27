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
    /// The interest rate for the installments.
    public let rate: Int
    /// The currency ID for the installment amount.
    public let currencyId: String

    /// Initializes a new instance of `InstallmentsData`.
    /// - Parameters:
    ///   - quantity: The number of installments.
    ///   - amount: The amount for each installment.
    ///   - rate: The interest rate for the installments.
    ///   - currencyId: The currency ID for the installment amount.
    public init(quantity: Int, amount: Double, rate: Int, currencyId: String) {
        self.quantity = quantity
        self.amount = amount
        self.rate = rate
        self.currencyId = currencyId
    }
}
